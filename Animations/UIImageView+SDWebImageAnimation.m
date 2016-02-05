//
//  UIImageView+SDWebImageAnimation.m
//  UIImageView
//
//  Created by YouXianMing on 16/2/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIImageView+SDWebImageAnimation.h"
#import "UIView+WebCacheOperation.h"
#import "objc/runtime.h"
#import "UIView+AnimationProperty.h"

static char imageURLKey;

@implementation UIImageView (SDWebImageAnimation)

- (void)sd_setImageWithURL:(NSURL *)url
                   options:(SDWebImageOptions)options
                  progress:(SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(SDWebImageCompletionBlock)completedBlock
         animationStrategy:(SDWebImageAnimationStrategy *)animationStrategy
                  animated:(BOOL)animated {
    
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (url) {
        
        __weak UIImageView *wself = self;
        
        if (animationStrategy == nil) {
            
            animationStrategy = [SDWebImageAnimationStrategy new];
        }
        
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (!wself) {
                
                return;
            }
            
            dispatch_main_sync_safe(^{
                
                if (!wself) {
                    
                    return;
                }
                
                if (image) {
                    
                    wself.image = image;
                    
                    if (animated == YES) {
                        
                        if(image && cacheType == SDImageCacheTypeNone){
                            
                            animationStrategy.imageView = wself;
                            [animationStrategy startAnimation];
                        }
                    }
                    
                    [wself setNeedsLayout];
                }
                
                if (completedBlock && finished) {
                    
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
        
    } else {
        
        dispatch_main_async_safe(^{
            
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain"
                                                 code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            
            if (completedBlock) {
                
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(SDWebImageCompletionBlock)completedBlock
             fadeAnimation:(BOOL)fadeAnimation {
    
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        
        self.image = placeholder;
    }
    
    if (url) {
        
        __weak UIImageView *wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (!wself) {
                
                return;
            }
            
            dispatch_main_sync_safe(^{
                
                if (!wself) {
                    
                    return;
                }
                
                if (image) {
                    
                    wself.image = image;
                    
                    if (fadeAnimation == YES) {
                        
                        if(image && cacheType == SDImageCacheTypeNone){
                            
                            CATransition *transition  = [CATransition animation];
                            transition.type           = kCATransitionFade; // there are other types but this is the nicest
                            transition.duration       = 0.34;              // set the duration that you like
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            [self.layer addAnimation:transition forKey:nil];
                        }
                    }
                    
                    [wself setNeedsLayout];
                    
                } else {
                    
                    if ((options & SDWebImageDelayPlaceholder)) {
                        
                        wself.image = placeholder;
                        
                        if (fadeAnimation == YES) {
                            
                            if(image && cacheType == SDImageCacheTypeNone){
                                
                                CATransition *transition  = [CATransition animation];
                                transition.type           = kCATransitionFade; // there are other types but this is the nicest
                                transition.duration       = 0.34;              // set the duration that you like
                                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                [self.layer addAnimation:transition forKey:nil];
                            }
                        }
                        
                        [wself setNeedsLayout];
                    }
                }
                
                if (completedBlock && finished) {
                    
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
        
    } else {
        
        dispatch_main_async_safe(^{
            
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain"
                                                 code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            
            if (completedBlock) {
                
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)sd_cancelCurrentImageLoad {
    
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}

- (void)sd_cancelCurrentAnimationImagesLoad {
    
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}

@end

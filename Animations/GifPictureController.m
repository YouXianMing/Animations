//
//  GifPictureController.m
//  Animations
//
//  Created by YouXianMing on 16/2/21.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GifPictureController.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UIImageView+WebCache.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface GifPictureController ()

@end

@implementation GifPictureController

- (void)setup {
    
    [super setup];
    
    // https://github.com/Flipboard/FLAnimatedImage
    
    self.contentView.layer.masksToBounds = YES;
    
    FLAnimatedImageView *gifImageView = [[FLAnimatedImageView alloc] init];
    gifImageView.frame                = CGRectMake(0.0, 0.0, 100.0, 100.0);
    [self.contentView addSubview:gifImageView];
    
    __weak GifPictureController *wself = self;
    NSString *imagePath                = @"http://images2015.cnblogs.com/blog/607542/201601/607542-20160123090832343-133952004.gif";
    NSData   *gifImageData             = [self imageDataFromDiskCacheWithKey:imagePath];
    
    if (gifImageData) {
        
        [wself animatedImageView:gifImageView data:gifImageData];
        
    } else {
        
        NSURL *url = [NSURL URLWithString:imagePath];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                
                                                                [[[SDWebImageManager sharedManager] imageCache] storeImage:image
                                                                                                      recalculateFromImage:NO
                                                                                                                 imageData:data
                                                                                                                    forKey:url.absoluteString
                                                                                                                    toDisk:YES];
                                                                
                                                                [[GCDQueue mainQueue] execute:^{
                                                                    
                                                                    [wself animatedImageView:gifImageView data:data];
                                                                }];
                                                            }];
    }
}

- (void)animatedImageView:(FLAnimatedImageView *)imageView data:(NSData *)data {

    FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:data];
    imageView.frame           = CGRectMake(0, 0, gifImage.size.width, gifImage.size.height);
    imageView.center          = self.contentView.middlePoint;
    imageView.animatedImage   = gifImage;
    imageView.alpha           = 0.f;
    
    [UIView animateWithDuration:1.f animations:^{
        
        imageView.alpha = 1.f;
    }];
}

- (NSData *)imageDataFromDiskCacheWithKey:(NSString *)key {
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:key];
    return [NSData dataWithContentsOfFile:path];
}

@end

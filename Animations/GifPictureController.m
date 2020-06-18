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
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface GifPictureController ()

@end

@implementation GifPictureController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:url options:SDWebImageDownloaderAvoidDecodeImage | SDWebImageDownloaderScaleDownLargeImages | SDWebImageDownloaderHighPriority
                                                           progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
            NSLog(@"%ld / %ld", (long)receivedSize, (long)expectedSize);
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            [SDImageCache.sharedImageCache storeImageDataToDisk:data forKey:imagePath];
            [wself animatedImageView:gifImageView data:data];
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
    
    return [SDImageCache.sharedImageCache diskImageDataForKey:key];;
}

@end

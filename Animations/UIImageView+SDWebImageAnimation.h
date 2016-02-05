//
//  UIImageView+SDWebImageAnimation.h
//  UIImageView
//
//  Created by YouXianMing on 16/2/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManager.h"
#import "SDWebImageAnimationStrategy.h"

@interface UIImageView (SDWebImageAnimation)

/**
 *  Set image with fade animation.
 *
 *  @param url            Image url.
 *  @param placeholder    Place holder image.
 *  @param options        SDWebImageOptions.
 *  @param progressBlock  SDWebImage downloader progress block.
 *  @param completedBlock Completed block.
 *  @param fadeAnimation  Animated or not.
 */
- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(SDWebImageCompletionBlock)completedBlock
             fadeAnimation:(BOOL)fadeAnimation;

/**
 *  Set image with animationStrategy.
 *
 *  @param url               Image url.
 *  @param options           SDWebImageOptions.
 *  @param progressBlock     SDWebImage downloader progress block.
 *  @param completedBlock    Completed block.
 *  @param animationStrategy Animation strategy.
 *  @param animated          Animated or not.
 */
- (void)sd_setImageWithURL:(NSURL *)url
                   options:(SDWebImageOptions)options
                  progress:(SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(SDWebImageCompletionBlock)completedBlock
         animationStrategy:(SDWebImageAnimationStrategy *)animationStrategy
                  animated:(BOOL)animated;

@end

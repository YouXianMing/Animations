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

@interface UIImageView (SDWebImageAnimation)

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(SDWebImageCompletionBlock)completedBlock
             fadeAnimation:(BOOL)fadeAnimation;

@end

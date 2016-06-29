//
//  ScratchImageViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/22.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ScratchImageViewController.h"
#import "MDScratchImageView.h"
#import "UIView+SetRect.h"
#import "UIImage+ImageEffects.h"

@interface ScratchImageViewController ()

@end

@implementation ScratchImageViewController

- (void)setup {

    [super setup];
    
    self.titleView.backgroundColor       = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    
    UIImage *image = [UIImage imageNamed:@"1"];
    
    // 背景图片
    UIImageView *blurImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero, image.size}];
    blurImageView.image        = image;
    blurImageView.center       = self.contentView.middlePoint;
    [self.contentView addSubview:blurImageView];
    
    // 被刮的图片
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:blurImageView.frame];
    [scratchImageView setImage:[image blurImage] radius:20.f];
    [self.contentView addSubview:scratchImageView];
}

@end

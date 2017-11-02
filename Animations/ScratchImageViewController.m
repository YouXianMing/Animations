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
#import "UIView+AnimationProperty.h"

@interface ScratchImageViewController ()

@end

@implementation ScratchImageViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.titleView.backgroundColor       = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    
    UIImage *image            = [UIImage imageNamed:@"1"];
    UIView  *imageContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageContentView.scale    = MAX(Height / image.size.height, Width / image.size.width);
    imageContentView.center   = self.contentView.middlePoint;
    [self.contentView addSubview:imageContentView];
    
    // 背景图片
    UIImageView *blurImageView = [[UIImageView alloc] initWithFrame:imageContentView.bounds];
    blurImageView.image        = image;
    [imageContentView addSubview:blurImageView];
    
    // 被刮的图片
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageContentView.bounds];
    [scratchImageView setImage:[image blurImage] radius:20.f];
    [imageContentView addSubview:scratchImageView];
}

@end

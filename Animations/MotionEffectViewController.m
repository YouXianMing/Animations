//
//  MotionEffectViewController.m
//  Animations
//
//  Created by YouXianMing on 16/2/18.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MotionEffectViewController.h"
#import "UIView+MotionEffect.h"
#import "UIView+SetRect.h"

@interface MotionEffectViewController ()

@end

@implementation MotionEffectViewController

- (void)setup {
    
    [super setup];
    
    // https://github.com/jvenegas/TLMotionEffect
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width - 15, Width - 15)];
        imageView.image        = [UIImage imageNamed:@"最外层"];
        imageView.center       = self.contentView.middlePoint;
        [self.contentView addSubview:imageView];
        
        [imageView addCenterMotionEffectsWithOffset:20.f];
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width - 15, Width - 15)];
        imageView.image        = [UIImage imageNamed:@"中间层"];
        imageView.center       = self.contentView.middlePoint;
        [self.contentView addSubview:imageView];
        
        [imageView addCenterMotionEffectsWithOffset:10.f];
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width - 15, Width - 15)];
        imageView.image        = [UIImage imageNamed:@"最里层"];
        imageView.center       = self.contentView.middlePoint;
        [self.contentView addSubview:imageView];
        
        [imageView addCenterMotionEffectsWithOffset:5.f];
    }
}

@end

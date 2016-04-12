//
//  ReplicatorLineViewController.m
//  Animations
//
//  Created by YouXianMing on 16/4/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ReplicatorLineViewController.h"
#import "ReplicatorLineAnimationView.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIView+GlowView.h"

@interface ReplicatorLineViewController ()

@end

@implementation ReplicatorLineViewController

- (void)setup {
    
    [super setup];
    
    UIImage *image = [UIImage imageNamed:@"typeOneLine"];
    CGRect   rect  = CGRectMake(0, 0, image.size.width, image.size.height);
    ReplicatorLineAnimationView *replicatorLineView = [[ReplicatorLineAnimationView alloc] initWithFrame:rect];
    replicatorLineView.direction = kReplicatorLeft;
    replicatorLineView.speed     = 0.5f;
    replicatorLineView.image     = image;
    [replicatorLineView startAnimation];
    replicatorLineView.center = self.contentView.middlePoint;
    [self.contentView addSubview:replicatorLineView];
    
    {
        UIView *redView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, image.size.height)];
        redView.backgroundColor = [UIColor redColor];
        redView.y               = replicatorLineView.y;
        redView.right           = replicatorLineView.left;
        [self.contentView addSubview:redView];
    }
    
    {
        UIView *redView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, image.size.height)];
        redView.backgroundColor = [UIColor redColor];
        redView.y               = replicatorLineView.y;
        redView.left            = replicatorLineView.right;
        [self.contentView addSubview:redView];
    }
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text     = @"Loading...";
        label.font     = [UIFont HeitiSCWithFontSize:10.f];
        [label sizeToFit];
        
        label.x      = replicatorLineView.x - 3;
        label.bottom = replicatorLineView.top - 3;
        [self.contentView addSubview:label];
        
        label.glowRadius            = @(2.f);
        label.glowOpacity           = @(1.f);
        label.glowColor             = [UIColor cyanColor];
        label.glowDuration          = @(1.f);
        label.hideDuration          = @(3.f);
        label.glowAnimationDuration = @(2.f);
        [label createGlowLayer];
        [label insertGlowLayer];
        [label startGlowLoop];
    }
}

@end

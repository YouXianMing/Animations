//
//  MusicBarAnimationController.m
//  Animations
//
//  Created by YouXianMing on 16/1/15.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MusicBarAnimationController.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface MusicBarAnimationController ()

@property (nonatomic, strong) GCDTimer  *timer;

@end

@implementation MusicBarAnimationController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    CGFloat width  = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    [self.contentView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.frame              = CGRectMake(0, 0, width, height);
    replicatorLayer.position           = self.view.center;
    replicatorLayer.instanceCount      = width / 8;
    replicatorLayer.masksToBounds      = YES;
    replicatorLayer.instanceTransform  = CATransform3DMakeTranslation(-8.0, 0.0, 0.0);
    replicatorLayer.instanceDelay      = 0.5f;
    
    CALayer *layer        = [CALayer layer];
    layer.frame           = CGRectMake(width - 4, height, 4, height);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.cornerRadius    = 2.f;
    [replicatorLayer addSublayer:layer];
    
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        colorAnimation.toValue           = (id)[UIColor colorWithRed:arc4random() % 256 / 255.f
                                                               green:arc4random() % 256 / 255.f
                                                                blue:arc4random() % 256 / 255.f
                                                               alpha:1].CGColor;
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnimation.toValue           = @(layer.position.y - arc4random() % ((NSInteger)height - 64));
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 1.f;
        group.autoreverses      = true;
        group.repeatCount       = 20;
        group.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.animations        = @[colorAnimation, positionAnimation];
        [layer addAnimation:group forKey:nil];
        
    } timeIntervalWithSecs:1.f delaySecs:1.f];
    [self.timer start];
}

- (void)setupSubViews {
    
    // Title label.
    UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 64.f)];
    titleLabel.font          = [UIFont AvenirWithFontSize:20.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
    titleLabel.text          = self.title;
    titleLabel.bottom        = self.titleView.height;
    [self.titleView addSubview:titleLabel];
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.height - 0.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, titleLabel.centerY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end

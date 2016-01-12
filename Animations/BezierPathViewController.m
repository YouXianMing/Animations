//
//  BezierPathViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BezierPathViewController.h"
#import "UIView+SetRect.h"
#import "CALayer+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIView+AnimationProperty.h"
#import "WxHxD.h"
#import "GCD.h"

@interface BezierPathViewController ()

@property (nonatomic, strong) GCDTimer      *timer;
@property (nonatomic, strong) CAShapeLayer  *shapeLayer;

@end

@implementation BezierPathViewController

- (void)setup {
    
    [super setup];
    
    // Scale value.
    CGFloat scale = 1;
    
    if (iPhone == iPhone4_4s || iPhone == iPhone5_5s) {

        scale = 0.65f;
        
    } else if (iPhone == iPhone6) {
    
        scale = 0.75f;
        
    } else if (iPhone == iPhone6_plus) {
        
        scale = 0.8f;
    }
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    // Used as background.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        
        shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth   = 0.5f;
        shapeLayer.opacity     = 0.5f;
        shapeLayer.position    = self.contentView.middlePoint;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        
        [self.contentView.layer addSublayer:shapeLayer];
    }
    
    // Animation.
    {
        self.shapeLayer           = [CAShapeLayer layer];
        self.shapeLayer.frame     = CGRectMake(0, 0, 600, 300);
        self.shapeLayer.path      = [self path].CGPath;
        self.shapeLayer.strokeEnd = 0.f;
        
        self.shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        self.shapeLayer.strokeColor   = [UIColor redColor].CGColor;
        self.shapeLayer.lineWidth     = 2.f;
        self.shapeLayer.position      = self.contentView.middlePoint;
        self.shapeLayer.shadowColor   = [UIColor redColor].CGColor;
        self.shapeLayer.shadowOpacity = 1.f;
        self.shapeLayer.shadowRadius  = 4.f;
        self.shapeLayer.lineCap       = kCALineCapRound;
        [self.shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        [self.contentView.layer addSublayer:self.shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
        [self.timer event:^{
            
            CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
            aniStart.toValue           = [NSNumber numberWithFloat:MAX];
            aniStart.duration          = 4.9f;
            
            CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
            aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
            aniEnd.duration            = 4.9f;
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.duration          = 4.9f;
            group.animations        = @[aniEnd, aniStart];
            
            self.shapeLayer.strokeStart   = MAX;
            self.shapeLayer.strokeEnd     = MAX + GAP;
            [self.shapeLayer addAnimation:group forKey:nil];
            
        } timeIntervalWithSecs:5.f delaySecs:1.f];
        [self.timer start];
    }
}

- (UIBezierPath *)path {
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 150)];
    [bezierPath addLineToPoint: CGPointMake(68, 150)];
    [bezierPath addLineToPoint: CGPointMake(83, 107)];
    [bezierPath addLineToPoint: CGPointMake(96, 206)];
    [bezierPath addLineToPoint: CGPointMake(102, 150)];
    [bezierPath addLineToPoint: CGPointMake(116, 150)];
    [bezierPath addLineToPoint: CGPointMake(127, 82)];
    [bezierPath addLineToPoint: CGPointMake(143, 213)];
    [bezierPath addLineToPoint: CGPointMake(160, 150)];
    [bezierPath addLineToPoint: CGPointMake(179, 150)];
    [bezierPath addLineToPoint: CGPointMake(183, 135)];
    [bezierPath addLineToPoint: CGPointMake(192, 169)];
    [bezierPath addLineToPoint: CGPointMake(199, 150)];
    [bezierPath addLineToPoint: CGPointMake(210, 177)];
    [bezierPath addLineToPoint: CGPointMake(227, 70)];
    [bezierPath addLineToPoint: CGPointMake(230, 210)];
    [bezierPath addLineToPoint: CGPointMake(249, 135)];
    [bezierPath addLineToPoint: CGPointMake(257, 150)];
    [bezierPath addLineToPoint: CGPointMake(360, 150)];
    [bezierPath addLineToPoint: CGPointMake(372, 124)];
    [bezierPath addLineToPoint: CGPointMake(395, 197)];
    [bezierPath addLineToPoint: CGPointMake(408, 82)];
    [bezierPath addLineToPoint: CGPointMake(416, 150)];
    [bezierPath addLineToPoint: CGPointMake(424, 135)];
    [bezierPath addLineToPoint: CGPointMake(448, 224)];
    [bezierPath addLineToPoint: CGPointMake(456, 107)];
    [bezierPath addLineToPoint: CGPointMake(463, 150)];
    [bezierPath addLineToPoint: CGPointMake(600, 150)];
    bezierPath.lineCapStyle = kCGLineCapSquare;
    
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    return bezierPath;
}

- (void)buildTitleView {
    
    [super buildTitleView];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont AvenirWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end

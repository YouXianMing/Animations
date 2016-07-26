//
//  CircleAnimationViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CircleAnimationViewController.h"
#import "CircleView.h"
#import "GCD.h"
#import "UIView+SetRect.h"

@interface CircleAnimationViewController ()

@property (nonatomic, strong) CircleView  *circleView1;
@property (nonatomic, strong) CircleView  *circleView2;
@property (nonatomic, strong) CircleView  *circleView3;
@property (nonatomic, strong) CircleView  *circleView4;

@property (nonatomic, strong) GCDTimer    *timer;

@end

@implementation CircleAnimationViewController

- (void)setup {

    [super setup];
    
    CGFloat gapFromTop = 64.f + 20;
    CGFloat width      = self.contentView.width;
    
    CGFloat halfWidth  = width / 2.f;
    CGFloat radius     = width / 3.f + 20;
    
    CGPoint point1     = CGPointMake(halfWidth / 2.f, gapFromTop + halfWidth / 2.f);
    CGPoint point2     = CGPointMake(halfWidth / 2.f + halfWidth, gapFromTop + halfWidth / 2.f);
    CGPoint point3     = CGPointMake(halfWidth / 2.f, gapFromTop + halfWidth / 2.f + halfWidth);
    CGPoint point4     = CGPointMake(halfWidth / 2.f + halfWidth, gapFromTop + halfWidth / 2.f + halfWidth);
    
    // 圆圈1
    self.circleView1 = [CircleView circleViewWithFrame:CGRectMake(0, 0, radius, radius)
                                             lineWidth:2
                                             lineColor:[UIColor grayColor]
                                             clockWise:YES
                                            startAngle:0];
    [self.circleView1 buildView];
    self.circleView1.center = point1;
    [self.contentView addSubview:self.circleView1];
    
    // 圆圈2
    self.circleView2 = [CircleView circleViewWithFrame:CGRectMake(0, 0, radius, radius)
                                             lineWidth:radius / 2.f
                                             lineColor:[UIColor blackColor]
                                             clockWise:YES
                                            startAngle:0];
    [self.circleView2 buildView];
    self.circleView2.center = point2;
    [self.contentView addSubview:self.circleView2];
    
    // 圆圈3
    self.circleView3 = [CircleView circleViewWithFrame:CGRectMake(0, 0, radius, radius)
                                             lineWidth:2
                                             lineColor:[UIColor blackColor]
                                             clockWise:YES
                                            startAngle:0];
    [self.circleView3 buildView];
    self.circleView3.center = point3;
    [self.contentView addSubview:self.circleView3];
    
    // 圆圈4
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    imageView.image        = [UIImage imageNamed:@"colors"];
    imageView.center       = point4;
    
    [self.contentView addSubview:imageView];
    self.circleView4 = [CircleView circleViewWithFrame:CGRectMake(0, 0, radius, radius)
                                             lineWidth:radius / 2.f
                                             lineColor:[UIColor blackColor]
                                             clockWise:YES
                                            startAngle:0];
    [self.circleView4 buildView];
    imageView.layer.mask = self.circleView4.layer;

    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        CGFloat percent        = arc4random() % 100 / 100.f;
        CGFloat anotherPercent = arc4random() % 100 / 100.f;
        
        // 圆圈1动画
        [weakSelf.circleView1 strokeEnd:percent animationType:ElasticEaseInOut animated:YES duration:1.f];
        
        // 圆圈2动画
        [weakSelf.circleView2 strokeEnd:percent animationType:ExponentialEaseInOut animated:YES duration:1.f];
        
        // 圆圈3动画
        [weakSelf.circleView3 strokeStart:(percent < anotherPercent ? percent : anotherPercent)
                        animationType:ExponentialEaseInOut
                             animated:YES duration:1.f];
        
        [weakSelf.circleView3 strokeEnd:(percent < anotherPercent ? anotherPercent : percent)
                      animationType:ExponentialEaseInOut
                           animated:YES duration:1.f];
        
        // 圆圈4动画
        [weakSelf.circleView4 strokeEnd:percent animationType:ExponentialEaseOut animated:YES duration:1.f];
        
    } timeIntervalWithSecs:1.5f];
    
    [self.timer start];
}

@end

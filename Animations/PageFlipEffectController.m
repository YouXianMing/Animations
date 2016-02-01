//
//  PageFlipEffectController.m
//  Animations
//
//  Created by YouXianMing on 16/1/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PageFlipEffectController.h"
#import "Math.h"
#import "CALayer+SetRect.h"
#import "UIView+SetRect.h"
#import "POP.h"


@interface PageFlipEffectController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) Math    *math;

@end

@implementation PageFlipEffectController

- (void)setup {
    
    [super setup];
    
    UIImage *image = [UIImage imageNamed:@"pic_1"];
    CGSize   size  = [Math resetFromSize:image.size withFixedWidth:Width / 2.f];
    
    // layer
    _layer               = [CALayer layer];
    _layer.anchorPoint   = CGPointMake(1.f, 0.5f);
    _layer.frame         = CGRectMake(0, 0, Width / 2.f, size.height);
    _layer.x             = 0;
    _layer.position      = CGPointMake(Width / 2.f, self.contentView.middleY);
    _layer.contents      = (__bridge id)([UIImage imageNamed:@"pic_1"].CGImage);
    _layer.borderColor   = [UIColor blackColor].CGColor;
    _layer.borderWidth   = 4.f;
    _layer.masksToBounds = YES;
    _layer.transform     = CATransform3DMakeRotation([Math radianFromDegree:0], 0.0, 1.0, 0.0);
    [self.contentView.layer addSublayer:_layer];
    
    // 一元一次方程
    self.math = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 0) PointB:MATHPointMake(Width, 180)];
    
    // 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    
    CGPoint curPoint = [sender locationInView:self.view];
    CGFloat x        = curPoint.x;
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    // 透视
    perspectiveTransform.m34 = -1.0 / 2000.0;
    
    // 空间旋转
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree: x * self.math.k], 0, 1, 0);
    
    [CATransaction setDisableActions:YES];
    _layer.transform = perspectiveTransform;
    
    if (x >= Width / 2.f) {
        
        [CATransaction setDisableActions:YES];
        _layer.contents = (__bridge id)([UIImage imageNamed:@"pic_2"].CGImage);
        
    } else {
        
        [CATransaction setDisableActions:YES];
        _layer.contents = (__bridge id)([UIImage imageNamed:@"pic_1"].CGImage);
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (x >= Width / 2.f) {
            
            // 初始化3D变换,获取默认值
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            
            // 透视
            perspectiveTransform.m34 = -1.0/2000.0;
            
            // 空间旋转
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:180], 0, 1, 0);
            
            [CATransaction setDisableActions:NO];
            _layer.transform = perspectiveTransform;
            
        } else {
            
            // 初始化3D变换,获取默认值
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            
            // 透视
            perspectiveTransform.m34 = -1.0/2000.0;
            
            // 空间旋转
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:0], 0, 1, 0);
            
            [CATransaction setDisableActions:NO];
            _layer.transform = perspectiveTransform;
        }
    }
}

@end

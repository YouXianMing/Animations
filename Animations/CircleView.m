//
//  CircleView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/11/12.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "CircleView.h"

// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
#define   DEGREES(radian)  ((radian) * 180.f / M_PI)

@interface CircleView ()

/**
 *  圆形layer
 */
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CircleView

/**
 *  初始化frame值
 *
 *  @param frame 尺寸值
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 创建出layer
        [self createCircleLayer];
    }
    
    return self;
}

/**
 *  创建出layer
 */
- (void)createCircleLayer {
    
    self.circleLayer       = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
}

/**
 *  初始化view
 */
- (void)buildView {
    
    // 初始化信息
    CGFloat  lineWidth = (self.lineWidth <= 0 ? 1 : self.lineWidth);
    UIColor *lineColor = (self.lineColor == nil ? [UIColor blackColor] : self.lineColor);
    CGSize   size      = self.bounds.size;
    CGFloat  radius    = size.width / 2.f - lineWidth / 2.f; // 设置半径(刚好贴到frame上面去)
    
    // 旋转方向
    BOOL clockWise = self.clockWise;
    CGFloat startAngle = 0;
    CGFloat endAngle   = 0;
    if (clockWise == YES) {
        
        startAngle = -RADIAN(180 - self.startAngle);
        endAngle   = RADIAN(180 + self.startAngle);
        
    } else {
        
        startAngle = RADIAN(180 - self.startAngle);
        endAngle   = -RADIAN(180 + self.startAngle);
    }
    
    // 创建出贝塞尔曲线
    UIBezierPath *circlePath \
        = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.height / 2.f, size.width / 2.f)
                                         radius:radius
                                     startAngle:startAngle
                                       endAngle:endAngle
                                      clockwise:clockWise];

    // 获取path
    self.circleLayer.path = circlePath.CGPath;
    
    // 设置颜色
    self.circleLayer.strokeColor = lineColor.CGColor;
    self.circleLayer.fillColor   = [[UIColor clearColor] CGColor];
    self.circleLayer.lineWidth   = lineWidth;
    self.circleLayer.strokeEnd   = 0.f;
}

- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    // 过滤掉不合理的值
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        
        // 关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeEnd";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
            [YXEasing calculateFrameFromValue:self.circleLayer.strokeEnd
                                      toValue:value
                                         func:func
                                   frameCount:duration * 60];
        
        // 执行动画
        self.circleLayer.strokeEnd = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // 关闭动画
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeEnd = value;
        [CATransaction setDisableActions:NO];
    }
}

- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    // 过滤掉不合理的值
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        
        // 关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeStart";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
        [YXEasing calculateFrameFromValue:self.circleLayer.strokeStart
                                  toValue:value
                                     func:func
                               frameCount:duration * 60];
        
        // 执行动画
        self.circleLayer.strokeStart = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // 关闭动画
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeStart = value;
        [CATransaction setDisableActions:NO];
    }
}



+ (instancetype)circleViewWithFrame:(CGRect)frame
                          lineWidth:(CGFloat)width
                          lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise
                         startAngle:(CGFloat)angle {
    
    CircleView *circleView = [[CircleView alloc] initWithFrame:frame];
    circleView.lineWidth   = width;
    circleView.lineColor   = color;
    circleView.clockWise   = clockWise;
    circleView.startAngle  = angle;
    
    return circleView;
}

@end

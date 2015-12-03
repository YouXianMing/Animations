//
//  EasingRotateAnimationType.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "EasingRotateAnimationType.h"
#import "RotateAnimationView.h"
#import "YXEasing.h"

@interface EasingRotateAnimationType ()

@property (nonatomic, weak) RotateAnimationView *animationView;

@end

@implementation EasingRotateAnimationType

- (void)setClientView:(UIView *)clientView {

    self.animationView = (RotateAnimationView *)clientView;
}

- (UIView *)clientView {

    return self.animationView;
}

- (void)startAnimation {

    if (self.animationView) {
        
        // 设置动画
        CAKeyframeAnimation *circle = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        circle.duration             = self.animationView.duration;
        circle.values               = [YXEasing calculateFrameFromValue:self.animationView.fromCircleRadian
                                                                toValue:self.animationView.toCircleRadian
                                                                   func:ElasticEaseOut
                                                             frameCount:self.animationView.duration * 60];
        
        // 进行值的设置
        self.animationView.layer.transform = CATransform3DMakeRotation(self.animationView.toCircleRadian, 0, 0, 1);
        
        // 添加动画效果
        [self.animationView.layer addAnimation:circle forKey:nil];
    }
}

- (void)additionalParameter:(NSDictionary *)param {

}

@end

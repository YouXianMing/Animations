//
//  NormalRotateAnimationType.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "NormalRotateAnimationType.h"
#import "RotateAnimationView.h"

@interface NormalRotateAnimationType ()

@property (nonatomic, weak) RotateAnimationView *animationView;

@end

@implementation NormalRotateAnimationType

- (void)setClientView:(UIView *)clientView {
    
    self.animationView = (RotateAnimationView *)clientView;
}

- (UIView *)clientView {
    
    return self.animationView;
}

- (void)startAnimation {
    
    if (self.animationView) {
        
        // 设置动画
        CABasicAnimation *circle     = [CABasicAnimation animation];
        circle.keyPath               = @"transform.rotation.z";
        circle.fromValue             = [NSNumber numberWithFloat:self.animationView.fromCircleRadian];
        circle.toValue               = [NSNumber numberWithFloat:self.animationView.toCircleRadian];
        circle.duration              = self.animationView.duration;
        
        // 进行值的设置
        self.animationView.layer.transform   = CATransform3DMakeRotation(self.animationView.toCircleRadian, 0, 0, 1);
        
        // 添加动画效果
        [self.animationView.layer addAnimation:circle forKey:nil];
    }
}

- (void)additionalParameter:(NSDictionary *)param {
    
}

@end

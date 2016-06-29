//
//  POPSpringRotateAnimationType.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "POPSpringRotateAnimationType.h"
#import "RotateAnimationView.h"
#import "POP.h"

@interface POPSpringRotateAnimationType ()

@property (nonatomic, weak) RotateAnimationView *animationView;

@end

@implementation POPSpringRotateAnimationType

- (void)setClientView:(UIView *)clientView {
    
    self.animationView = (RotateAnimationView *)clientView;
}

- (UIView *)clientView {
    
    return self.animationView;
}

- (void)startAnimation {
    
    if (self.animationView) {
        
        // 设置动画
        POPSpringAnimation *circle = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        circle.fromValue           = [NSNumber numberWithFloat:self.animationView.fromCircleRadian];
        circle.toValue             = [NSNumber numberWithFloat:self.animationView.toCircleRadian];
        circle.springSpeed         = 0.2f;
        circle.springBounciness    = 2.f;
        
        // 添加动画效果
        [self.animationView.layer pop_addAnimation:circle forKey:nil];
    }
}

- (void)additionalParameter:(NSDictionary *)param {
    
}

@end

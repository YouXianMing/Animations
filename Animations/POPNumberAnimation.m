//
//  POPNumberAnimation.m
//  Animations
//
//  Created by YouXianMing on 15/11/18.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "POPNumberAnimation.h"
#import "POP.h"

@interface POPNumberAnimation ()

@property (nonatomic, strong) POPBasicAnimation  *conutAnimation;

@end

@implementation POPNumberAnimation

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.conutAnimation = [POPBasicAnimation animation];
    }
    
    return self;
}

- (void)saveValues {
    
    self.conutAnimation.fromValue = @(self.fromValue);
    self.conutAnimation.toValue   = @(self.toValue);
    self.conutAnimation.duration  = (self.duration <= 0 ? 0.4f : self.duration);
    
    if (self.timingFunction) {
        
        self.conutAnimation.timingFunction = self.timingFunction;
    }
}

- (void)startAnimation {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(POPNumberAnimation:currentValue:)]) {
        
        __weak POPNumberAnimation *weakSelf = self;
        
        // 将计算出来的值通过writeBlock动态给控件设定
        self.conutAnimation.property = \
            [POPMutableAnimatableProperty propertyWithName:@"conutAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
                
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                
                weakSelf.currentValue = values[0];
                [weakSelf.delegate POPNumberAnimation:weakSelf currentValue:values[0]];
            };
        }];
        
        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
}

- (void)stopAnimation {
    
    [self pop_removeAllAnimations];
}

@end

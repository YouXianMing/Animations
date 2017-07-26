//
//  UIView+ConvertRect.m
//  ConverView
//
//  Created by YouXianMing on 2017/7/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "UIView+ConvertRect.h"

@implementation UIView (ConvertRect)

- (CGPoint)frameOriginFromView:(UIView *)view {
    
    return [self convertPoint:CGPointZero toView:view];
}

- (CGRect)frameFromView:(UIView *)view {
    
    return [self convertRect:self.bounds toView:view];
}

@end

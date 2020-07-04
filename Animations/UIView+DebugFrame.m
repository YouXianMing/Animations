//
//  UIView+DebugFrame.m
//  ConverView
//
//  Created by YouXianMing on 2017/7/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "UIView+DebugFrame.h"

@implementation UIView (DebugFrame)

- (void)showOutline:(BOOL)showOutline outlineWidth:(CGFloat)width outlineColor:(UIColor *)outlineColor backgroundColor:(UIColor *)backgroundColor {
    
#ifdef DEBUG
    
    if (showOutline) {
        
        self.layer.borderWidth = width;
        
        if (outlineColor) {
            
            self.layer.borderColor = outlineColor.CGColor;
        }
    }
    
    if (backgroundColor) {
        
        self.backgroundColor = backgroundColor;
    }
    
#endif
}

- (void)showOutlineWithColor:(UIColor *)color {
    
    [self showOutline:YES outlineWidth:0.5f outlineColor:color backgroundColor:nil];
}

- (void)showBoldOutlineWithColor:(UIColor *)color {
    
    [self showOutline:YES outlineWidth:3.f outlineColor:color backgroundColor:nil];
}

- (void)showRandomColorOutline {
    
    [self showOutline:YES outlineWidth:0.5f outlineColor:[self randomHueColorWithAlpha:1.f] backgroundColor:nil];
}

- (void)showRandomBoldColorOutline {
    
    [self showOutline:YES outlineWidth:3.f outlineColor:[self randomHueColorWithAlpha:1.f] backgroundColor:nil];
}

- (void)showRandomColorOutlineAndBackgroundColor {
    
    [self showOutline:YES outlineWidth:0.5f outlineColor:[self randomHueColorWithAlpha:1.f] backgroundColor:[self randomHueColorWithAlpha:0.25f]];
}

- (void)showRandomBoldColorOutlineAndBackgroundColor {
    
    [self showOutline:YES outlineWidth:3.f outlineColor:[self randomHueColorWithAlpha:1.f] backgroundColor:[self randomHueColorWithAlpha:0.25f]];
}

- (UIColor *)randomHueColorWithAlpha:(CGFloat)alpha {
 
    return [UIColor colorWithHue:arc4random() % 256 / 255.f
                      saturation:1.f brightness:1.f alpha:alpha];
}

- (void)subviewsShowOutlineWithColor:(UIColor *)color level:(NSInteger)level {
    
    [UIView showSubviewFramesWithView:self level:level color:color];
}

+ (void)showSubviewFramesWithView:(UIView *)view level:(NSInteger)level color:(UIColor *)color {
    
    [view showOutlineWithColor:[color colorWithAlphaComponent:0.25]];
    
    if (view.subviews.count <= 0 || level <= 0) {
        
        return;
    }
    
    [view.subviews enumerateObjectsUsingBlock:^(UIView * subView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [UIView showSubviewFramesWithView:subView level:level - 1 color:color];
    }];
}
@end

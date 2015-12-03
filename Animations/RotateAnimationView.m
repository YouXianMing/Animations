//
//  RotateAnimationView.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "RotateAnimationView.h"
#import "NormalRotateAnimationType.h"

@implementation RotateAnimationView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self configDefaultValue];
    }
    
    return self;
}

- (void)configDefaultValue {
    
    self.duration         = 1.f;
    self.fromCircleRadian = 0.f;
    self.toCircleRadian   = M_PI;
    self.animationType    = [NormalRotateAnimationType new];
}

- (void)startRotateAnimated:(BOOL)animated {

    if (animated) {
                
        self.animationType.clientView = self;
        [self.animationType startAnimation];
        
    } else {
    
        self.layer.transform = CATransform3DMakeRotation(_toCircleRadian, 0, 0, 1);
    }
}

@end

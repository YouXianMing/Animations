//
//  POPPressButton.m
//  Animations
//
//  Created by YouXianMing on 16/5/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "POPPressButton.h"
#import "Math.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface POPPressButton ()

@property (nonatomic, strong) Math    *math;

@property (nonatomic, strong) UIView  *backgroundView;
@property (nonatomic, strong) Math    *backgroundViewMath;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) Math    *labelMath;

@end

@implementation POPPressButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _label.frame          = CGRectMake(0, 0, self.width, self.height);
    _backgroundView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // Init Math.
        self.backgroundViewMath = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1) PointB:MATHPointMake(1, 0.5f)];
        self.math               = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1) PointB:MATHPointMake(1, 0.95f)];
        self.labelMath          = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1) PointB:MATHPointMake(1, 1.10f)];
        
        // Setup layer.
        self.layer.borderWidth   = 1.f;
        self.layer.cornerRadius  = 4.f;
        self.layer.borderColor   = [[UIColor colorWithRed:0.137  green:0.624  blue:0.867 alpha:1] colorWithAlphaComponent:0.5f].CGColor;
        self.layer.masksToBounds = YES;
        
        
        self.backgroundView                 = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0.137  green:0.624  blue:0.867 alpha:1];
        [self.contentView addSubview:self.backgroundView];
        
        self.label               = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor     = [UIColor whiteColor];
        self.label.font          = [UIFont fontWithName:@"GillSans-Light" size:15.f];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

- (void)currentPercent:(CGFloat)percent {
    
    _backgroundView.backgroundColor = [[UIColor colorWithRed:0.137  green:0.624  blue:0.867 alpha:1]
                                       colorWithAlphaComponent:_backgroundViewMath.k * percent + _backgroundViewMath.b];
    
    self.scale = _math.k * percent + _math.b;
    
    _label.scale = _labelMath.k * percent + _labelMath.b;
}

- (void)setTitle:(NSString *)title {

    _label.text = title;
}

- (NSString *)title {

    return _label.text;
}

@end

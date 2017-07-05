//
//  PressScaleButton.m
//  Animations
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PressScaleButton.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "UIFont+Fonts.h"
#import "AttributedStringConfigHelper.h"

@interface PressScaleButton ()

@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) Math     *backgroundViewMath;

@property (nonatomic, strong) UILabel             *label;

@end

@implementation PressScaleButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _backgroundView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundViewMath = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1) PointB:MATHPointMake(1, 0)];
        
        // Init subViews.
        self.backgroundView                     = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor     = [UIColor whiteColor];
        self.backgroundView.layer.cornerRadius  = self.backgroundView.width / 2.f;
        self.backgroundView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.backgroundView];
        
        self.label                = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.textAlignment  = NSTextAlignmentCenter;
        self.label.attributedText = [self percentStringWithPercentValue:0.f];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

- (void)currentScalePercent:(CGFloat)percent {
    
    // BackgroundView
    CGFloat colorValue              = _backgroundViewMath.k * percent + _backgroundViewMath.b;
    _backgroundView.backgroundColor = [UIColor colorWithRed:colorValue  green:colorValue  blue:colorValue alpha:1];
    
    // Label
    _label.attributedText = [self percentStringWithPercentValue:percent];
}

- (NSMutableAttributedString *)percentStringWithPercentValue:(CGFloat)percent {
    
    NSString *totalString = [NSString stringWithFormat:@"%.f%%", fabs(percent * 100)];
    return [NSMutableAttributedString mutableAttributedStringWithString:totalString config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor colorWithRed:percent green:percent blue:percent alpha:1.f] range:NSMakeRange(0, string.length)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor redColor] colorWithAlphaComponent:0.5f] range:NSMakeRange(string.length - 1, 1)]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont HYQiHeiWithFontSize:30.f] range:NSMakeRange(0, string.length)]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"GillSans-LightItalic" size:14.f] range:NSMakeRange(string.length - 1, 1)]];
    }];
}

@end

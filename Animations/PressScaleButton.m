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
#import "StringRangeManager.h"
#import "UIFont+Fonts.h"
#import "StringAttributeHelper.h"

@interface PressScaleButton ()

@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) Math     *backgroundViewMath;

@property (nonatomic, strong) UILabel             *label;
@property (nonatomic, strong) StringRangeManager  *rangeManager;

@end

@implementation PressScaleButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _backgroundView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
     
        // Init tools.
        self.rangeManager = [StringRangeManager new];
        
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

    self.rangeManager.content           = [NSString stringWithFormat:@"%.f%%", fabs(percent * 100)];
    self.rangeManager.parts[@"percent"] = @"%";
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:self.rangeManager.content];
    
    {
        ForegroundColorAttribute *attribute = [ForegroundColorAttribute new];
        attribute.color                     = [UIColor colorWithRed:percent green:percent blue:percent alpha:1.f];
        attribute.effectRange               = self.rangeManager.contentRange;
        [richString addStringAttribute:attribute];
    }
    
    {
        ForegroundColorAttribute *attribute = [ForegroundColorAttribute new];
        attribute.color                     = [[UIColor redColor] colorWithAlphaComponent:0.5f];
        attribute.effectRange               = [[self.rangeManager rangesFromPartName:@"percent" options:0].firstObject rangeValue];
        [richString addStringAttribute:attribute];
    }
    
    {
        FontAttribute *attribute = [FontAttribute new];
        attribute.font           = [UIFont HYQiHeiWithFontSize:30.f];
        attribute.effectRange    = self.rangeManager.contentRange;
        [richString addStringAttribute:attribute];
    }
    
    {
        FontAttribute *attribute = [FontAttribute new];
        attribute.font           = [UIFont fontWithName:@"GillSans-LightItalic" size:14.f];
        attribute.effectRange    = [[self.rangeManager rangesFromPartName:@"percent" options:0].firstObject rangeValue];
        [richString addStringAttribute:attribute];
    }
    
    return richString;
}

@end

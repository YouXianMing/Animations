//
//  RangeValueView.m
//  POPSpring
//
//  Created by YouXianMing on 15/5/14.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "RangeValueView.h"

@interface RangeValueView ()

@property (nonatomic)          CGFloat    currentValue;
@property (nonatomic, strong)  UILabel   *labelName;
@property (nonatomic, strong)  UILabel   *labelValue;
@property (nonatomic, strong)  UISlider  *slider;

@end

@implementation RangeValueView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    CGRect frame   = self.frame;
    CGFloat width  = frame.size.width;
    
    // 标签
    self.labelName               = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 100, 20)];
    self.labelName.font          = [UIFont fontWithName:@"Heiti SC" size:10.f];
    [self addSubview:self.labelName];
    
    self.labelValue               = [[UILabel alloc] initWithFrame:CGRectMake(width - 103, 0, 100, 20)];
    self.labelValue.font          = [UIFont fontWithName:@"Heiti SC" size:10.f];
    self.labelValue.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.labelValue];
    
    // Slider
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(2, 15, width - 4, 10)];
    [self addSubview:self.slider];
    self.slider.minimumTrackTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    self.slider.maximumTrackTintColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider"]
                      forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider"]
                      forState:UIControlStateHighlighted];

    [self.slider addTarget:self
                    action:@selector(sliderChanged:)
          forControlEvents:UIControlEventValueChanged];
}

- (void)sliderChanged:(UISlider *)slider {
    
    // 更新UI
    CGFloat value        = slider.value;
    NSString *string     = [NSString stringWithFormat:@"%.2f", value];
    self.labelValue.text = string;
    
    // 当前的value值
    _currentValue        = value;
}

+ (instancetype)rangeValueViewWithFrame:(CGRect)frame
                                   name:(NSString *)name
                               minValue:(CGFloat)minValue
                               maxValue:(CGFloat)maxValue
                           defaultValue:(CGFloat)defaultValue {
    
    CGFloat x      = frame.origin.x;
    CGFloat y      = frame.origin.y;
    CGFloat width  = frame.size.width;
    CGFloat height = 25;
    
    RangeValueView *range = [[RangeValueView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    // 基本配置
    range.maxValue        = maxValue;
    range.minValue        = minValue;
    range.defaultValue    = defaultValue;
    range.text            = name;
    
    // 额外配置
    range.currentValue    = defaultValue;
    range.labelValue.text = [NSString stringWithFormat:@"%.2f", defaultValue];
    
    return range;
}

@synthesize minValue = _minValue;
- (void)setMinValue:(CGFloat)minValue {
    
    _minValue            = minValue;
    _slider.minimumValue = minValue;
}

- (CGFloat)minValue {
    
    return _minValue;
}

@synthesize maxValue = _maxValue;
- (void)setMaxValue:(CGFloat)maxValue {
    
    _maxValue            = maxValue;
    _slider.maximumValue = maxValue;
}

- (CGFloat)maxValue {
    
    return _maxValue;
}

@synthesize defaultValue = _defaultValue;
- (void)setDefaultValue:(CGFloat)defaultValue {
    
    _defaultValue = defaultValue;
    _slider.value = defaultValue;
}

- (CGFloat)defaultValue {
    
    return _defaultValue;
}

@synthesize text = _text;
- (void)setText:(NSString *)text {
    
    _text           = text;
    _labelName.text = text;
}

- (NSString *)text {
    
    return _text;
}

@end

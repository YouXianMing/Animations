//
//  PopNumberController.m
//  Animations
//
//  Created by YouXianMing on 15/11/18.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "PopNumberController.h"
#import "POPNumberAnimation.h"
#import "AttributedStringConfigHelper.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "GCD.h"

@interface PopNumberController () <POPNumberAnimationDelegate>

@property (nonatomic, strong) POPNumberAnimation *numberAnimation;
@property (nonatomic, strong) GCDTimer           *timer;
@property (nonatomic, strong) UILabel            *label;

@end

@implementation PopNumberController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Init label.
    _label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.center        = self.contentView.middlePoint;
    [self.contentView addSubview:_label];
    
    // Init numberAnimation.
    self.numberAnimation          = [[POPNumberAnimation alloc] init];
    self.numberAnimation.delegate = self;
    
    // Timer event.
    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        // Start animation.
        [weakSelf configNumberAnimation];
        [weakSelf.numberAnimation startAnimation];
        
    } timeIntervalWithSecs:3.f];
    [self.timer start];
}

- (void)configNumberAnimation {
    
    self.numberAnimation.fromValue      = self.numberAnimation.currentValue;
    self.numberAnimation.toValue        = (arc4random() % 101 / 1.f);
    self.numberAnimation.duration       = 2.f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
}

- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
    
    // Init string.
    NSString *numberString = [NSString stringWithFormat:@"%.1f", currentValue];
    NSString *totalString  = [NSString stringWithFormat:@"%@ mps", numberString];
    
    NSMutableAttributedString *richString = [NSMutableAttributedString mutableAttributedStringWithString:totalString config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont HYQiHeiWithFontSize:30.f] range:NSMakeRange(0, string.length)]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont HYQiHeiWithFontSize:60.f] range:NSMakeRange(0, string.length - 4)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[self mpsColorWithValue:currentValue / 100.f] range:NSMakeRange(string.length - 4, 4)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[self numColorWithValue:currentValue / 100.f] range:NSMakeRange(0, string.length - 4)]];
    }];
    
    _label.attributedText = richString;
}

- (UIColor *)numColorWithValue:(CGFloat)value {
    
    return [UIColor colorWithRed:value green:0 blue:0 alpha:1.f];
}

- (UIColor *)mpsColorWithValue:(CGFloat)value {
    
    return [UIColor colorWithRed:0 green:value / 2.f blue:value / 3.f alpha:value];
}

@end

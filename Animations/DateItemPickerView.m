//
//  DateItemPickerView.m
//  Animations
//
//  Created by YouXianMing on 2017/11/30.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "DateItemPickerView.h"
#import "UIFont+Fonts.h"
#import "UIButton+Inits.h"
#import "UIButton+Style.h"
#import "UIView+SetRect.h"
#import "UIColor+ForPublicUse.h"

@implementation DateItemPickerView

- (void)buildViewsInContentView:(UIView *)contentView {
    
    // 顶部白色的view
    UIView *topWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40.f)];
    [contentView addSubview:topWhiteView];
    
    // 确定按钮
    UIButton *button       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.right           = Width;
    button.normalTitle     = @"确定";
    button.titleLabel.font = [UIFont HeitiSCWithFontSize:13.f];
    [button addTarget:self action:@selector(buttonEvent)];
    [topWhiteView addSubview:button];
    
    [button titleLabelHorizontalAlignment:UIControlContentHorizontalAlignmentRight
                        verticalAlignment:UIControlContentVerticalAlignmentCenter
                        contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12.f)];
    
    [button titleLabelColorWithNormalStateColor:[UIColor blackColor]
                          highlightedStateColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]
                             disabledStateColor:nil];
    
    // 顶部线条
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    line.backgroundColor = [UIColor lineColor];
    [topWhiteView addSubview:line];
    
    if (self.info && [self.info isKindOfClass:[NSString class]]) {
        
        UILabel *label               = [UILabel new];
        label.text                   = self.info;
        label.font                   = [UIFont HeitiSCWithFontSize:15.f];
        label.textColor              = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
        label.userInteractionEnabled = NO;
        [label sizeToFit];
        
        label.center = topWhiteView.middlePoint;
        [topWhiteView addSubview:label];
    }
    
    UIDatePicker *picker  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40.f, Width, 180.f)];
    picker.datePickerMode = UIDatePickerModeDate;
    [picker addTarget:self action:@selector(datePickerEvent:) forControlEvents:UIControlEventValueChanged];
    
    self.picker           = picker;
    [contentView addSubview:picker];
}

- (void)configPicker {
    
    UIDatePicker *picker = self.picker;
    picker.minimumDate   = [NSDate date];
    
    if (self.selectedItem && [self.selectedItem isKindOfClass:[NSDate class]]) {
        
        picker.date = self.selectedItem;
    }
}

- (void)datePickerEvent:(UIDatePicker *)picker {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerView:didSelectedIndexs:items:)]) {
        
        [self.delegate baseShowPickerView:self didSelectedIndexs:nil items:@[picker.date]];
    }
}

+ (CGFloat)contentViewHeight {
    
    CGFloat bottomHeight = 0;
    
    if (iPhoneX) {
        
        bottomHeight = UIView.additionaliPhoneXBottomSafeHeight;
    }
    
    return 180.f + 40.f + bottomHeight;
}

- (void)buttonEvent {
    
    [self hideFromKeyWindow];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerView:didSelectedIndexs:items:)]) {
        
        UIDatePicker *picker = self.picker;
        [self.delegate baseShowPickerView:self didSelectedIndexs:nil items:@[picker.date]];
    }
}

@end

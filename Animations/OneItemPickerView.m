//
//  OneItemPickerView.m
//  Animations
//
//  Created by YouXianMing on 2017/11/29.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "OneItemPickerView.h"
#import "CustomPickerView.h"
#import "UIView+SetRect.h"
#import "OneItemPickerRowView.h"
#import "UIColor+ForPublicUse.h"
#import "UIButton+Style.h"
#import "UIButton+Inits.h"
#import "UIFont+Fonts.h"

@interface OneItemPickerView () <CustomPickerViewDelegate> {
    
    CustomPickerView *_pickerView;
}

@end

@implementation OneItemPickerView

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
    
    // 创建pickerView
    _pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 40.f, Width, 0) delegate:self pickerViewHeightType:kCustomPickerViewHeightTypeMid];
    [contentView addSubview:_pickerView];
}

- (void)configPicker {
    
    // 获取rows
    NSMutableArray <PickerViewRow *> *rows = [NSMutableArray array];
    [self.showDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[OneItemPickerRowView class] data:obj]];
    }];
    
    PickerViewComponent   *component  = [PickerViewComponent pickerViewComponentWithRows:rows componentWidth:Width];
    PickerViewDataAdapter *adpater    = [PickerViewDataAdapter pickerViewDataAdapterWithComponents:@[component] rowHeight:40.f];
    _pickerView.pickerViewDataAdapter = adpater;
    
    // 如果有初始选定元素,则直接定位到初始选定元素的地方
    if (self.selectedItem && [self.selectedItem isKindOfClass:[NSAttributedString class]]) {
        
        __block NSInteger index = 0;
        [self.showDatas enumerateObjectsUsingBlock:^(NSAttributedString *string, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([string isEqualToAttributedString:self.selectedItem]) {
                
                index = idx;
                *stop = YES;
            }
        }];
        
        [_pickerView selectRow:index inComponent:0 animated:NO];
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerView:didSelectedIndexs:items:)] && self.showDatas.count) {
        
        NSInteger selectedIndex = [_pickerView.pickView selectedRowInComponent:0];
        [self.delegate baseShowPickerView:self didSelectedIndexs:@[@(selectedIndex)] items:@[self.showDatas[selectedIndex]]];
    }
}

#pragma mark - CustomPickerViewDelegate

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {

    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerView:didSelectedIndexs:items:)]) {
        
        [self.delegate baseShowPickerView:self didSelectedIndexs:rows items:datas];
    }
}

@end

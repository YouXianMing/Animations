//
//  CustomPickerView.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView                *pickView;
@property (nonatomic)         ECustomPickerViewHeightType  pickerViewHeightType;

@end

@implementation CustomPickerView

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id <CustomPickerViewDelegate>)delegate
         pickerViewHeightType:(ECustomPickerViewHeightType)pickerViewHeightType
                  dataAdapter:(PickerViewDataAdapter *)dataAdapter {
    
    self.pickerViewHeightType  = pickerViewHeightType;
    self.pickerViewDataAdapter = dataAdapter;
    self.delegate              = delegate;
    CGFloat height             = [self heithWithPickerViewHeightType:pickerViewHeightType];
    
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height)]) {
        
        self.pickView            = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        self.pickView.delegate   = self;
        self.pickView.dataSource = self;
        [self addSubview:self.pickView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id <CustomPickerViewDelegate>)delegate
         pickerViewHeightType:(ECustomPickerViewHeightType)pickerViewHeightType {
    
    return [self initWithFrame:frame delegate:delegate pickerViewHeightType:pickerViewHeightType dataAdapter:nil];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.pickView.frame  = CGRectMake(0, 0, self.frame.size.width, [self heithWithPickerViewHeightType:self.pickerViewHeightType]);
    self.pickView.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
}

- (CGFloat)heithWithPickerViewHeightType:(ECustomPickerViewHeightType)type {
    
    CGFloat height;
    
    switch (self.pickerViewHeightType) {
            
        case kCustomPickerViewHeightTypeMin:
            height = 162.f;
            break;
            
        case kCustomPickerViewHeightTypeMid:
            height = 180.f;
            break;
            
        case kCustomPickerViewHeightTypeMax:
            height = 216.f;
            break;
            
        default:
            height = 180.f;
            break;
    }
    
    return height;
}

- (void)reloadAllComponents {
    
    [self.pickView reloadAllComponents];
}

- (void)reloadComponent:(NSInteger)component {
    
    [self.pickView reloadComponent:component];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    
    [self.pickView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
 
    return [self.pickView selectedRowInComponent:component];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.pickerViewDataAdapter.components.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.pickerViewDataAdapter.components[component].rows.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.pickerViewDataAdapter.components[component].componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return self.pickerViewDataAdapter.rowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    PickerViewComponent *pickerViewComponent = self.pickerViewDataAdapter.components[component];
    PickerViewRow       *pickerViewRow       = self.pickerViewDataAdapter.components[component].rows[row];
    
    PickerCustomView *customView = (PickerCustomView *)view;
    if (customView == nil) {
        
        customView = [[pickerViewRow.pickerCustomViewClass alloc] initWithFrame:CGRectMake(0, 0,
                                                                                           pickerViewComponent.componentWidth,
                                                                                           self.pickerViewDataAdapter.rowHeight)];
    }
    
    customView.row       = row;
    customView.component = component;
    customView.data      = pickerViewRow.data;
    [customView loadContent];
    
    if (self.showPickerCustomViewFrame == YES) {

        customView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.15f];
    }
    
    return customView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPickerView:didSelectRow:inComponent:)]) {
        
        [self.delegate customPickerView:self didSelectRow:row inComponent:component];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPickerView:didSelectedRows:selectedDatas:)]) {
    
        NSMutableArray *datas = [NSMutableArray array];
        NSMutableArray *rows  = [NSMutableArray array];
        
        for (int i = 0; i < self.pickerViewDataAdapter.components.count; i++) {
            
            NSInteger row  = [pickerView selectedRowInComponent:i];
            id        data = nil;
            
            if ([self.pickerViewDataAdapter.components[i].rows count]) {
             
               data = self.pickerViewDataAdapter.components[i].rows[row].data;
            }
            
            [rows  addObject:@(row)];
            [datas addObject:data ? data : [NSNull null]];
        }

        [self.delegate customPickerView:self didSelectedRows:rows selectedDatas:datas];
    }
}

@end

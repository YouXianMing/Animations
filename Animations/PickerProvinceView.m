//
//  PickerProvinceView.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PickerProvinceView.h"
#import "PickerProvinceModel.h"
#import "UIFont+Fonts.h"

@interface PickerProvinceView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PickerProvinceView

- (void)buildSubView {
    
    self.label               = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 2;
    self.label.font          = [UIFont HeitiSCWithFontSize:15.f];
    self.label.textColor     = [UIColor redColor];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    PickerProvinceModel *model = self.data;
    self.label.text            = model.province;
}

@end

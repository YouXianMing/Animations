//
//  PickerCityView.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PickerCityView.h"
#import "PickerCityModel.h"
#import "UIFont+Fonts.h"

@interface PickerCityView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PickerCityView

- (void)buildSubView {
    
    self.label               = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 2;
    self.label.font          = [UIFont HeitiSCWithFontSize:15.f];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    PickerCityModel *model = self.data;
    self.label.text        = model.city;
    
    if ([model.city isEqualToString:@"其他"]) {
        
        self.label.textColor = [UIColor lightGrayColor];
        
    } else {
        
        self.label.textColor = [UIColor blackColor];
    }
}

@end

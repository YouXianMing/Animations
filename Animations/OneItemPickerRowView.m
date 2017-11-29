//
//  OneItemPickerRowView.m
//  Animations
//
//  Created by YouXianMing on 2017/11/29.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "OneItemPickerRowView.h"
#import "UIView+SetRect.h"

@interface OneItemPickerRowView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation OneItemPickerRowView

- (void)buildSubView {
    
    self.label = [UILabel new];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    self.label.attributedText = self.data;
    [self.label sizeToFit];
    
    self.label.center = self.middlePoint;
}

@end

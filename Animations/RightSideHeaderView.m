//
//  RightSideHeaderView.m
//  SecondList
//
//  Created by YouXianMing on 2017/8/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "RightSideHeaderView.h"
#import "CategoryModel.h"
#import "UIFont+Fonts.h"

@implementation RightSideHeaderView

- (void)setupHeaderFooterView {
    
    [super setupHeaderFooterView];
    
    self.textLabel.font      = [UIFont AvenirLightWithFontSize:11.f];
    self.textLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.85f];
}

- (void)loadContent {
    
    CategoryModel *model = self.data;
    self.textLabel.text  = model.name;
}

+ (CGFloat)heightWithData:(id)data {
    
    return 25.f;
}

@end

//
//  PickerCustomView.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCustomView : UIView

@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger component;
@property (nonatomic, weak) id data;

- (void)setup;
- (void)buildSubView;
- (void)loadContent;

@end

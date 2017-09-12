//
//  PickerAreaView.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PickerAreaView.h"
#import "PickerAreaModel.h"
#import "UIFont+Fonts.h"

@interface PickerAreaView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PickerAreaView

- (void)buildSubView {
    
    self.label               = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 2;
    self.label.font          = [UIFont HeitiSCWithFontSize:15.f];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    PickerAreaModel *model = self.data;
    self.label.text        = model.area;
    
    if ([model.area isEqualToString:@"其他"]) {
        
        self.label.textColor = [UIColor lightGrayColor];
        
    } else {
        
        self.label.textColor = [UIColor blackColor];
    }
}

@end

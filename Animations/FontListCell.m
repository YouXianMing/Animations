//
//  FontListCell.m
//  Animations
//
//  Created by YouXianMing on 16/5/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "FontListCell.h"
#import "UIView+SetRect.h"

@interface FontListCell ()

@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation FontListCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 20, 40)];
    [self addSubview:self.fontLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)loadContent {

    NSString *fontName = self.data;
    
    self.fontLabel.text = fontName;
    self.fontLabel.font = [UIFont fontWithName:fontName size:12.f];
}

- (void)buttonEvent {

    NSLog(@"%@", self.data);
}

@end

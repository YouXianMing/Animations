//
//  ColorSpaceCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ColorSpaceCell.h"
#import "UIView+SetRect.h"

@interface ColorSpaceCell ()

@property (nonatomic, strong) UIView *lineBackgroundView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ColorSpaceCell

+ (NSDictionary *)backgroundColor:(UIColor *)backgroundColor lineColor:(UIColor *)lineColor leftGap:(NSNumber *)leftGap rightGap:(NSNumber *)rightGap {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (backgroundColor) {
        
        dic[@"backgroundColor"] = backgroundColor;
    }
    
    if (lineColor) {
        
        dic[@"lineColor"] = lineColor;
    }
    
    if (leftGap) {
        
        dic[@"leftGap"] = leftGap;
    }
    
    if (rightGap) {
        
        dic[@"leftGap"] = leftGap;
    }
    
    return dic;
}

- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    self.lineBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
    [self addSubview:self.lineBackgroundView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
    [self addSubview:self.lineView];
}

- (void)loadContent {
    
    NSDictionary *dic = self.data;
    
    self.lineBackgroundView.height = self.dataAdapter.cellHeight;
    self.lineView.height           = self.dataAdapter.cellHeight;
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        self.lineBackgroundView.hidden = NO;
        self.lineView.hidden           = NO;
        
        // backgroundColor
        self.lineBackgroundView.backgroundColor = [dic[@"backgroundColor"] isKindOfClass:[UIColor class]] ? dic[@"backgroundColor"] : [UIColor clearColor];
        
        // lineColor
        self.lineView.backgroundColor = [dic[@"lineColor"] isKindOfClass:[UIColor class]] ? dic[@"lineColor"] : [UIColor clearColor];
        
        // leftGap + rightGap
        NSNumber *left      = [dic[@"leftGap"]  isKindOfClass:[NSNumber class]] ? dic[@"leftGap"]  : @(0.f);
        NSNumber *right     = [dic[@"rightGap"] isKindOfClass:[NSNumber class]] ? dic[@"rightGap"] : @(0.f);
        self.lineView.left  = left.floatValue;
        self.lineView.width = Width - left.floatValue - right.floatValue;
        
    } else {
        
        self.lineBackgroundView.hidden = YES;
        self.lineView.hidden           = YES;
    }
}

@end

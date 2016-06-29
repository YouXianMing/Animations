//
//  ShowTextModel.m
//  Animations
//
//  Created by YouXianMing on 16/4/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ShowTextModel.h"
#import "NSString+LabelWidthAndHeight.h"

@interface ShowTextModel ()

@property (nonatomic) CGFloat   expendStringHeight;
@property (nonatomic) CGFloat   normalStringHeight;

@end

@implementation ShowTextModel

- (void)calculateTheExpendStringHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width {

    self.expendStringHeight = 10 + [self.inputString heightWithStringAttribute:attribute fixedWidth:width] + 10;
}

- (void)calculateTheNormalStringHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width {

    CGFloat oneLineHeight = [NSString aLineOfTextHeightWithStringAttribute:attribute];
    CGFloat textHeight    = [self.inputString heightWithStringAttribute:attribute fixedWidth:width];

    CGFloat normalTextHeight = textHeight >= 3 * oneLineHeight ? 3 * oneLineHeight : textHeight;
    self.normalStringHeight  = 10 + normalTextHeight + 10;
}

@end

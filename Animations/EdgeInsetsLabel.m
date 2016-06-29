//
//  EdgeInsetsLabel.m
//  TechCode
//
//  Created by YouXianMing on 16/5/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "EdgeInsetsLabel.h"

@implementation EdgeInsetsLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect         = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                            limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (void)sizeToFitWithText:(NSString *)text {
    
    self.text = text;
    [self sizeToFit];
}

@end

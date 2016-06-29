//
//  NSAttributedString+LabelWidthAndHeight.m
//  Animations
//
//  Created by YouXianMing on 16/1/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSAttributedString+LabelWidthAndHeight.h"

@implementation NSAttributedString (LabelWidthAndHeight)

- (CGFloat)heightWithFixedWidth:(CGFloat)width {
    
    CGFloat height = 0;
    
    if (self.length) {
        
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                         context:nil];
        
        height = rect.size.height;
    }
    
    return height;
}

- (CGFloat)width {
    
    CGFloat width = 0;
    
    if (self.length) {
        
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                         context:nil];
        
        width = rect.size.width;
    }
    
    return width;
}

@end

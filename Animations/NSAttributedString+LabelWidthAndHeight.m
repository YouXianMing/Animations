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

- (CGFloat)coreTextHeightWithFixedWidth:(CGFloat)width {
    
    int maxValue = 20000;
    
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    
    // 这里的高要设置足够大
    CGRect           drawingRect = CGRectMake(0, 0, width, maxValue);
    CGMutablePathRef path        = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    
    CTFrameRef textFrame  = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    NSArray   *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    // 最后一行line的原点y坐标
    int line_y = (int) origins[[linesArray count] -1].y;
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef)[linesArray objectAtIndex:[linesArray count] - 1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    // +1为了纠正descent转换成int小数点后舍去的值
    total_height = maxValue - line_y + (int) descent + 1;
    
    CGPathRelease(path);
    CFRelease(framesetter);
    CFRelease(textFrame);
    
    return total_height;
}

@end

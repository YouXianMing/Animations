//
//  AttributedStringInitConfig.m
//  TextKit
//
//  Created by XianMingYou on 15/3/27.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "AttributedStringInitConfig.h"

@implementation AttributedStringInitConfig

- (NSDictionary *)createAttributes {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:(self.textColor == nil ? [UIColor blackColor] : self.textColor)          forKey:NSForegroundColorAttributeName];
    [dic setValue:(self.textFont  == nil ? [UIFont systemFontOfSize:18.f] : self.textFont) forKey:NSFontAttributeName];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    
    style.lineSpacing         = (self.lineSpacing <= 0 ? 5.f : self.lineSpacing);
    style.paragraphSpacing    = (self.paragraphSpacing <= 0 ? 5.f : self.paragraphSpacing);
    style.firstLineHeadIndent = (self.firstLineHeadIndent <= 0 ? 18 * 2 : self.firstLineHeadIndent);
    [dic setValue:style forKey:NSParagraphStyleAttributeName];
    
    [dic setValue:(self.kern <= 0 ? @(0) : @(self.kern)) forKey:NSKernAttributeName];
    
    return dic;
}


@end

//
//  AttributedStringInitConfig.h
//  TextKit
//
//  Created by XianMingYou on 15/3/27.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AttributedStringInitConfig : NSObject

@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, strong) UIFont   *textFont;
@property (nonatomic, assign) CGFloat   kern;                // 字间距


@property (nonatomic, assign) CGFloat   lineSpacing;         // 段落样式 - 行间距
@property (nonatomic, assign) CGFloat   paragraphSpacing;    // 段落样式 - 段间距
@property (nonatomic, assign) CGFloat   firstLineHeadIndent; // 段落样式 - 段首文字缩进

- (NSDictionary *)createAttributes;

@end

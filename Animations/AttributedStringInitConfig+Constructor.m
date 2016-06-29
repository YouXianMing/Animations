//
//  AttributedStringInitConfig+Constructor.m
//  InTheQuietNight
//
//  Created by XianMingYou on 15/3/30.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "AttributedStringInitConfig+Constructor.h"
#import "UIFont+Fonts.h"

@implementation AttributedStringInitConfig (Constructor)

+ (NSDictionary *)heitiSC {
    
    AttributedStringInitConfig *config = [AttributedStringInitConfig new];
    config.textColor                   = [UIColor colorWithRed:0.600 green:0.490 blue:0.376 alpha:1];
    config.textFont                    = [UIFont HeitiSCWithFontSize:15.f];
    config.firstLineHeadIndent         = 15 * 2;

    return [config createAttributes];
}

@end

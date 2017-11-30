//
//  InfoInputViewController+CreateViews.m
//  Animations
//
//  Created by YouXianMing on 2017/11/27.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "InfoInputViewController+CreateViews.h"
#import "UIView+SetRect.h"
#import "UIColor+ForPublicUse.h"
#import "NSAttributedString+AttributedStringConfig.h"
#import "AttributedStringConfigHelper.h"
#import "UIFont+Fonts.h"
#import "RegexManager.h"

@implementation InfoInputViewController (CreateViews)

- (UIView *)createWhiteBGViewWithTop:(CGFloat)top itemCount:(NSInteger)count {
    
    UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, top, Width, count * 50.f)];
    view.backgroundColor = [UIColor whiteColor];
    
    // Top line.
    {
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        line.backgroundColor = [UIColor lineColor];
        [view addSubview:line];
    }
    
    // Bottom line.
    {
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        line.backgroundColor = [UIColor lineColor];
        line.bottom          = view.height;
        [view addSubview:line];
    }
    
    // Middle lines.
    for (int i = 1; i < count; i++) {
        
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(15, i * 50.f - 0.5f, Width - 15.f, 0.5f)];
        line.backgroundColor = [UIColor lineColor];
        [view addSubview:line];
    }
    
    return view;
}

- (NSAttributedString *)boldRedWithString:(NSString *)string {
    
    return [NSAttributedString attributedStringWithString:string config:^(NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[FontAttributeConfig            configWithFont:[UIFont boldSystemFontOfSize:15.f]]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor redColor]]];
    }];
}

- (NSAttributedString *)normalFontWithString:(NSString *)string {
    
    return [NSAttributedString attributedStringWithString:string config:^(NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[FontAttributeConfig             configWithFont:[UIFont HeitiSCWithFontSize:15.f]]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f]]];
    }];
}

- (NSAttributedString *)normalFontWithMonthString:(NSString *)string {
    
    return [NSMutableAttributedString mutableAttributedStringWithString:string config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        NSRange full = NSMakeRange(0, string.length);
        NSRange part = [string matchsWithRegexPattern:@"^\\d+"].firstObject.rangeValue;
        
        [configs addObject:[FontAttributeConfig            configWithFont:[UIFont HeitiSCWithFontSize:15.f]  range:full]];
        [configs addObject:[FontAttributeConfig            configWithFont:[UIFont boldSystemFontOfSize:15.f] range:part]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f] range:full]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor redColor]   colorWithAlphaComponent:0.75f] range:part]];
    }];
}

@end

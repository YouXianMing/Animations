//
//  InfoInputViewController+CreateViews.h
//  Animations
//
//  Created by YouXianMing on 2017/11/27.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "InfoInputViewController.h"

@interface InfoInputViewController (CreateViews)

- (UIView *)createWhiteBGViewWithTop:(CGFloat)top itemCount:(NSInteger)count;
- (NSAttributedString *)boldRedWithString:(NSString *)string;
- (NSAttributedString *)normalFontWithString:(NSString *)string;
- (NSAttributedString *)normalFontWithMonthString:(NSString *)string;

@end

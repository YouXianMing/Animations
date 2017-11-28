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

@end

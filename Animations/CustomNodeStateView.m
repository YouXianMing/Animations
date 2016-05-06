//
//  CustomNodeStateView.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomNodeStateView.h"

@implementation CustomNodeStateView

- (void)changeToState:(EInfiniteLoopNodeState)state animated:(BOOL)animated {

    [NSException raise:@"CustomNodeStateView error"
                format:@"You must overwrite this method."];
}

@end

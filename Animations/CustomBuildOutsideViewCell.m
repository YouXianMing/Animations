//
//  CustomBuildOutsideViewCell.m
//  Animations
//
//  Created by YouXianMing on 16/9/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomBuildOutsideViewCell.h"

@interface CustomBuildOutsideViewCell () {

    NSLock  *_lock;
    BOOL     _haveRun;
}

@end

@implementation CustomBuildOutsideViewCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _haveRun            = NO;
    _lock               = [[NSLock alloc] init];
}

- (void)loadContent {

    if (_haveRun == NO && [_lock tryLock]) {
        
        _haveRun = YES;
        [_lock unlock];
        
        if (self.buildOutsideViewCellDelegate && [self.buildOutsideViewCellDelegate respondsToSelector:@selector(customBuildOutsideViewCell:cellIdentifier:)]) {
            
            [self.buildOutsideViewCellDelegate customBuildOutsideViewCell:self cellIdentifier:self.dataAdapter.cellReuseIdentifier];
        }
    }
}

@end

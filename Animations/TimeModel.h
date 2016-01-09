//
//  TimeModel.h
//  TableViewTimer
//
//  Created by YouXianMing on 15/7/9.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSNumber  *countdownTime;

/**
 *  便利构造器
 *
 *  @param title         标题
 *  @param countdownTime 倒计时
 *
 *  @return 实例对象
 */
+ (instancetype)timeModelWithTitle:(NSString *)title countdownTime:(NSNumber *)countdownTime;

/**
 *  计数减1(countdownTime - 1)
 */
- (void)countDown;

/**
 *  将当前的countdownTime信息转换成字符串
 */
- (NSString *)currentTimeString;

@end

static inline  TimeModel * TimeModelWithTitle(NSString *title, NSNumber *countdownTime) {

    return [TimeModel timeModelWithTitle:title countdownTime:countdownTime];
}

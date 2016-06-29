//
//  SystemTimeInfomation.h
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemTimeInfomation : NSObject

@property (nonatomic, strong) NSDateFormatter  *dateFormatter;

+ (SystemTimeInfomation *)sharedInstance;

/**
 *  Date format, please set dateFormatterString like '**:**:**:**:**'.
 *
 *  @param dateFormatterString Date format string.
 */
- (void)setDateFormatterString:(NSString *)dateFormatterString;

/**
 *  Current time infomation.
 *
 *  @return Current time infomation.
 */
- (NSDictionary *)currentTimeInfomation;

@end

//
//  DailyListModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "VideoListModel.h"

@interface DailyListModel : NSObject

@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSMutableArray <VideoListModel *> *videoList;

#pragma Calculation Properties.

@property (nonatomic, strong) NSString *dateString;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


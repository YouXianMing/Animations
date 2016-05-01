//
//  WanDouJiaModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DailyListModel.h"

@interface WanDouJiaModel : NSObject

@property (nonatomic, strong) NSString *nextPageUrl;
@property (nonatomic, strong) NSNumber *nextPublishTime;
// @property (nonatomic, strong) Null *newestIssueType;
@property (nonatomic, strong) NSMutableArray <DailyListModel *> *dailyList;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


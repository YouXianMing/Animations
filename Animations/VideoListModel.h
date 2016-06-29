//
//  VideoListModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ConsumptionModel.h"
#import "ProviderModel.h"
#import "PlayInfoModel.h"

@interface VideoListModel : NSObject

// @property (nonatomic, strong) Null *author;
@property (nonatomic, strong) NSNumber *releaseTime;
@property (nonatomic, strong) NSString *title;
// @property (nonatomic, strong) Null *webAdTrack;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *idx;
// @property (nonatomic, strong) Null *favoriteAdTrack;
@property (nonatomic, strong) NSString *rawWebUrl;
@property (nonatomic, strong) NSString *webUrlForWeibo;
@property (nonatomic, strong) NSString *coverForFeed;
@property (nonatomic, strong) NSString *category;
// @property (nonatomic, strong) Null *waterMarks;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *coverForDetail;
@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSString *playUrl;
// @property (nonatomic, strong) Null *promotion;
// @property (nonatomic, strong) Null *coverForSharing;
// @property (nonatomic, strong) Null *adTrack;
// @property (nonatomic, strong) Null *campaign;
@property (nonatomic, strong) NSString *coverBlurred;
// @property (nonatomic, strong) Null *shareAdTrack;
@property (nonatomic, strong) ConsumptionModel *consumption;
@property (nonatomic, strong) ProviderModel *provider;
@property (nonatomic, strong) NSMutableArray <PlayInfoModel *> *playInfo;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


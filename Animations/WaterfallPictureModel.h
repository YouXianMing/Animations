//
//  WaterfallPictureModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CmtsModel.h"

@interface WaterfallPictureModel : NSObject

@property (nonatomic, strong) NSNumber *iht;
@property (nonatomic, strong) NSString *buylnk;
@property (nonatomic, strong) NSString *isrc;
@property (nonatomic, strong) NSString *ava;
@property (nonatomic, strong) NSNumber *common;
@property (nonatomic, strong) NSNumber *good;
@property (nonatomic, strong) NSNumber *albid;
@property (nonatomic, strong) NSNumber *sta;
@property (nonatomic, strong) NSNumber *repc;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *favc;
@property (nonatomic, strong) NSString *unm;
@property (nonatomic, strong) NSNumber *zanc;
@property (nonatomic, strong) NSNumber *ruid;
@property (nonatomic, strong) NSNumber *iwd;
@property (nonatomic, strong) NSNumber *photo_id;
@property (nonatomic, strong) NSNumber *coupon_price;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *albnm;
@property (nonatomic, strong) NSNumber *rid;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSMutableArray <CmtsModel *> *cmts;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


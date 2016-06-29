//
//  DataModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "EntitiesModel.h"
#import "SourceModel.h"

@interface DataModel : NSObject

@property (nonatomic, strong) NSNumber *machine_only;
@property (nonatomic, strong) NSString *dataId;
@property (nonatomic, strong) NSNumber *num_reposts;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSNumber *num_replies;
@property (nonatomic, strong) NSString *thread_id;
@property (nonatomic, strong) NSString *canonical_url;
@property (nonatomic, strong) NSString *pagination_id;
@property (nonatomic, strong) NSNumber *num_stars;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) EntitiesModel *entities;
@property (nonatomic, strong) SourceModel *source;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


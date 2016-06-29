//
//  EntitiesModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LinksModel.h"
#import "MentionsModel.h"
#import "HashtagsModel.h"

@interface EntitiesModel : NSObject

@property (nonatomic, strong) NSMutableArray <LinksModel *> *links;
@property (nonatomic, strong) NSMutableArray <MentionsModel *> *mentions;
@property (nonatomic, strong) NSMutableArray <HashtagsModel *> *hashtags;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


//
//  UserModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AvatarImageModel.h"
#import "CountsModel.h"
#import "DescriptionModel.h"
#import "CoverImageModel.h"

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *canonical_url;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) AvatarImageModel *avatar_image;
@property (nonatomic, strong) CountsModel *counts;
@property (nonatomic, strong) DescriptionModel *infomation;
@property (nonatomic, strong) CoverImageModel *cover_image;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


//
//  CountsModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CountsModel : NSObject

@property (nonatomic, strong) NSNumber *posts;
@property (nonatomic, strong) NSNumber *stars;
@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


//
//  DescriptionModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "EntitiesModel.h"

@interface DescriptionModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) EntitiesModel *entities;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


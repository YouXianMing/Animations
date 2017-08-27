//
//  ItemManagerModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ShopItemDataModel.h"

@interface ItemManagerModel : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) ShopItemDataModel *data;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


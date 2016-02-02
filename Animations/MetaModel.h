//
//  MetaModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MetaModel : NSObject

@property (nonatomic, strong) NSString *max_id;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString *min_id;
@property (nonatomic, strong) NSNumber *more;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


//
//  LinksModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LinksModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSNumber *len;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *amended_len;
@property (nonatomic, strong) NSNumber *pos;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


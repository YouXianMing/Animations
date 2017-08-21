//
//  DuitangPicModel.h
//  Animations
//
//  Created by YouXianMing on 2017/8/21.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuitangPicModel : NSObject

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *width;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

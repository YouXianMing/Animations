//
//  OffsetCellModel.h
//  Animations
//
//  Created by YouXianMing on 2020/6/18.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OffsetCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *coverForDetail;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

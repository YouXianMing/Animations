//
//  OffsetCellSectionDataModel.h
//  Animations
//
//  Created by YouXianMing on 2020/6/18.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OffsetCellModel.h"

@interface OffsetCellSectionDataModel : NSObject

@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSMutableArray <OffsetCellModel *> *list;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

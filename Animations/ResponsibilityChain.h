//
//  ResponsibilityChain.h
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponsibilityMessage.h"

@interface ResponsibilityChain : NSObject

/**
 The object to attach.
 */
@property (nonatomic, weak) id object;

/**
 Overwrite by subclass.

 @return Can pass through or not.
 */
- (ResponsibilityMessage *)canPassThrough;

@end

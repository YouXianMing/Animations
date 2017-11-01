//
//  ResponsibilityManager.h
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ResponsibilityChain.h"

@interface ResponsibilityManager : NSObject

/**
 Get all the chains.
 */
@property (nonatomic, strong, readonly) NSArray *chains;

/**
 Add chain to responsibilityManager, if the object doesn't have the value in 'responsibilityChain', it will crash.

 @param object The object that has value in 'responsibilityChain'.
 */
- (void)addChain:(NSObject *)object;

/**
 Remove chain from responsibilityManager, if the object doesn't have the value in 'responsibilityChain', it will crash.

 @param object The object that has value in 'responsibilityChain'.
 */
- (void)removeChain:(NSObject *)object;

/**
 Check all the responsibilityChains.

 @return The check message.
 */
- (ResponsibilityMessage *)checkResponsibilityChain;

@end

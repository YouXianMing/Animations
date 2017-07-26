//
//  NSObject+WeakList.h
//  ConverView
//
//  Created by YouXianMing on 2017/7/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WeakList)

/**
 Store a weak object in NSMapTable.

 @param object Weak object.
 @param identifier The identifier.
 */
- (void)setWeakObject:(id)object identifier:(NSString *)identifier;

/**
 Store a weak object in NSMapTable.

 @param object Weak object.
 @param idValue The id value.
 */
- (void)setWeakObject:(id)object idValue:(NSInteger)idValue;

/**
 Get a weak object from NSMapTable.

 @param identifier The identifier.
 @return Weak object or nil.
 */
- (id)weakObjectWithIdentifier:(NSString *)identifier;

/**
 Get a weak object from NSMapTable.

 @param idValue The id value.
 @return Weak object or nil.
 */
- (id)weakObjectWithIdValue:(NSInteger)idValue;

/**
 Remove a weak object with it's identifier.

 @param identifier The weak object's identifier.
 */
- (void)removeWeakObjectWithIdentifier:(NSString *)identifier;

/**
 Remove a weak object with it's id value.

 @param idValue The id value.
 */
- (void)removeWeakObjectWithIdValue:(NSInteger)idValue;

/**
 Get NSMapTable's all identifiers.

 @return All identifiers.
 */
- (NSArray <NSString *> *)allIdentifiers;

/**
 Get NSMapTable's all weak object.
 
 @return All weak object.
 */
- (NSArray <id> *)allWeakObjects;

@end

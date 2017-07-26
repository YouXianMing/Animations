//
//  NSObject+WeakList.m
//  ConverView
//
//  Created by YouXianMing on 2017/7/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "NSObject+WeakList.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMapTable *weakList_strongToWeakObjectsMapTable;
@property (nonatomic, strong) NSString   *weakList_identifier;

@end

@implementation NSObject (WeakList)

- (void)setWeakObject:(id)object identifier:(NSString *)identifier {
    
    [self.weakList_strongToWeakObjectsMapTable setObject:object forKey:identifier];
}

- (void)setWeakObject:(id)object idValue:(NSInteger)idValue {
    
    [self.weakList_strongToWeakObjectsMapTable setObject:object forKey:[NSString stringWithFormat:@"weakList_identifier_%ld", (long)idValue]];
}

- (id)weakObjectWithIdentifier:(NSString *)identifier {
    
    return [self.weakList_strongToWeakObjectsMapTable objectForKey:identifier];
}

- (id)weakObjectWithIdValue:(NSInteger)idValue {
    
    return [self.weakList_strongToWeakObjectsMapTable objectForKey:[NSString stringWithFormat:@"weakList_identifier_%ld", (long)idValue]];
}

- (void)removeWeakObjectWithIdentifier:(NSString *)identifier {
    
    [self.weakList_strongToWeakObjectsMapTable removeObjectForKey:identifier];
}

- (void)removeWeakObjectWithIdValue:(NSInteger)idValue {
    
    [self.weakList_strongToWeakObjectsMapTable removeObjectForKey:[NSString stringWithFormat:@"weakList_identifier_%ld", (long)idValue]];
}

- (NSArray <NSString *> *)allIdentifiers {
    
    NSEnumerator *enumerator = [self.weakList_strongToWeakObjectsMapTable keyEnumerator];
    
    NSMutableArray *keysArray = [NSMutableArray array];
    
    id value;
    while ((value = [enumerator nextObject])) {
        
        [keysArray addObject:value];
    }
    
    return [NSArray arrayWithArray:keysArray];
}

- (NSArray <id> *)allWeakObjects {
    
    NSEnumerator *enumerator = [self.weakList_strongToWeakObjectsMapTable objectEnumerator];
    
    NSMutableArray *keysArray = [NSMutableArray array];
    
    id value;
    while ((value = [enumerator nextObject])) {
        
        [keysArray addObject:value];
    }
    
    return [NSArray arrayWithArray:keysArray];
}

#pragma mark - Runtime

- (void)setWeakList_strongToWeakObjectsMapTable:(NSMapTable *)weakList_strongToWeakObjectsMapTable {
    
    objc_setAssociatedObject(self, @selector(weakList_strongToWeakObjectsMapTable),
                             weakList_strongToWeakObjectsMapTable,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMapTable *)weakList_strongToWeakObjectsMapTable {
    
    id mapTable = objc_getAssociatedObject(self, _cmd);
    
    if (mapTable == nil) {
        
        mapTable = [NSMapTable strongToWeakObjectsMapTable];
        [self setWeakList_strongToWeakObjectsMapTable:mapTable];
    }
    
    return mapTable;
}

- (void)setWeakList_identifier:(NSString *)weakList_identifier {
    
    objc_setAssociatedObject(self, @selector(weakList_identifier), weakList_identifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)weakList_identifier {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end

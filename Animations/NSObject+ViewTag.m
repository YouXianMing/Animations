//
//  NSObject+ViewTag.m
//  Tag
//
//  Created by YouXianMing on 16/8/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSObject+ViewTag.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMapTable *viewIdentifiersMapTable;
@property (nonatomic, strong) NSString   *viewIdentifier;

@end

@implementation NSObject (ViewTag)

- (void)setView:(UIView *)view identifier:(NSString *)identifier {
    
    [self configViewIdentifiersMapTable];
    
    view.viewIdentifier.length ? [self.viewIdentifiersMapTable removeObjectForKey:view.viewIdentifier] : 0;
    view.viewIdentifier = identifier;
    [self.viewIdentifiersMapTable setObject:view forKey:identifier];
}

- (id)viewWithIdentifier:(NSString *)identifier {
    
    [self configViewIdentifiersMapTable];
    
    return [self.viewIdentifiersMapTable objectForKey:identifier];
}

- (id)viewWithValue:(NSInteger)value {
    
    [self configViewIdentifiersMapTable];
    
    return [self.viewIdentifiersMapTable objectForKey:@(value).stringValue];
}


- (void)configViewIdentifiersMapTable {
    
    if (self.viewIdentifiersMapTable == nil) {
        
        self.viewIdentifiersMapTable = [NSMapTable strongToWeakObjectsMapTable];
    }
}

+ (id)viewWithIdentifier:(NSString *)identifier from:(id)object {
    
    return [object viewWithIdentifier:identifier];
}

- (void)attachTo:(id)object setIdentifier:(NSString *)identifier {
    
    [object setView:(id)self identifier:identifier];
}

- (void)attachTo:(id)object setValue:(NSInteger)value {
    
    [object setView:(id)self identifier:@(value).stringValue];
}

#pragma mark - runtime

- (void)setViewIdentifiersMapTable:(NSMapTable *)viewIdentifiersMapTable {
    
    objc_setAssociatedObject(self, @selector(viewIdentifiersMapTable), viewIdentifiersMapTable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMapTable *)viewIdentifiersMapTable {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewIdentifier:(NSString *)viewIdentifier {
    
    objc_setAssociatedObject(self, @selector(viewIdentifier), viewIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)viewIdentifier {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end

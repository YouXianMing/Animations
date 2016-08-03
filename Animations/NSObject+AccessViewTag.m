//
//  NSObject+AccessViewTag.m
//  ViewTag
//
//  Created by YouXianMing on 16/8/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSObject+AccessViewTag.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMapTable <NSString *, UIView *> *viewsWeakMap;
@property (nonatomic, strong) NSString   *viewIdString;

@end

@implementation NSObject (AccessViewTag)

- (void)supportAccessViews {

    if (self.viewsWeakMap == nil) {
        
        self.viewsWeakMap = [NSMapTable strongToWeakObjectsMapTable];
    }
}

- (void)setView:(UIView *)view withId:(NSString *)viewId {

    NSParameterAssert([view isKindOfClass:[UIView class]]);
    
    if (self.viewsWeakMap) {
    
        view.viewIdString ? [self.viewsWeakMap removeObjectForKey:view.viewIdString] : 0;
        view.viewIdString = viewId;
        [self.viewsWeakMap setObject:view forKey:viewId];
    }
}

- (id)viewWithId:(NSString *)viewId {

    if (self.viewsWeakMap) {
        
        return [self.viewsWeakMap objectForKey:viewId];
        
    } else {
    
        return nil;
    }
}

#pragma mark - setter & getter

- (void)setViewIdString:(NSString *)viewIdString {

    objc_setAssociatedObject(self, @selector(viewIdString), viewIdString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)viewIdString {

    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewsWeakMap:(NSMapTable<NSString *, UIView *> *)viewsWeakMap {

    objc_setAssociatedObject(self, @selector(viewsWeakMap), viewsWeakMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMapTable <NSString *, UIView *> *)viewsWeakMap {

    return objc_getAssociatedObject(self, _cmd);
}

@end

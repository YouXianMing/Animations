//
//  UIScrollView+RefreshObject.m
//  UIScrollView
//
//  Created by YouXianMing on 15/6/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIScrollView+RefreshObject.h"
#import <objc/runtime.h>

@implementation UIScrollView (RefreshObject)

#pragma mark - 添加属性

@dynamic refreshObject;

NSString * const _recognizerRefreshObject = @"recognizerRefreshObject";

- (void)setRefreshObject:(RefreshObject *)refreshObject {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerRefreshObject), refreshObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RefreshObject *)refreshObject {
    
    return objc_getAssociatedObject(self, (__bridge const void *)(_recognizerRefreshObject));
}

#pragma mark -

- (void)createRefreshObject:(RefreshObject *)refreshObject refreshObjectDelegate:(id)delegate {
    
    if (self.refreshObject == nil) {
        
        self.refreshObject            = refreshObject;
        self.refreshObject.delegate   = delegate;

        [self.refreshObject addObserverObject:self];
        [self.refreshObject addObserverWithScrollView];
    }
    
}

- (void)removeRefreshObject {
    
    self.refreshObject = nil;
}

- (void)beginRefresh {

    [self.refreshObject beginRefreshing];
}

- (void)endRefresh {

    [self.refreshObject endRefresh];
}

@end

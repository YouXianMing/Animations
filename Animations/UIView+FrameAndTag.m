//
//  UIView+FrameAndTag.m
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+FrameAndTag.h"

@interface UIView ()

@property (nonatomic, strong) NSNumber  *tagNumberValue;
@property (nonatomic, strong) NSMapTable <NSString *, UIView *> *viewsWeakMap;

@end

@implementation UIView (FrameAndTag)

- (void)supportAccessViewTagProtocol {
    
    self.viewsWeakMap = [NSMapTable strongToWeakObjectsMapTable];
}

+ (instancetype)viewWithTag:(NSInteger)tag from:(id <AccessViewTagProtocol>)object {
    
    return [object viewWithTag:tag];
}

- (void)setTag:(NSInteger)tag attachedTo:(id <AccessViewTagProtocol>)object {
    
    self.tagNumberValue ? [object removeReferenceWithTag:self.tagNumberValue.integerValue] : 0;
    self.tag            = tag;
    self.tagNumberValue = @(tag);
    [object setView:self withTag:tag];
}

+ (instancetype)viewWithFrame:(CGRect)frame
               insertIntoView:(UIView *)view
                          tag:(NSInteger)tag
                   attachedTo:(id <AccessViewTagProtocol>)object
                   setupBlock:(ViewSetupBlock)block {
    
    UIView *tmpView = [[[self class] alloc] initWithFrame:frame];
    [tmpView supportAccessViewTagProtocol];
    
    view   && [view isKindOfClass:[UIView class]]                     ? ([view addSubview:tmpView])              : 0;
    object && [object respondsToSelector:@selector(setView:withTag:)] ? ([tmpView setTag:tag attachedTo:object]) : 0;
    
    if (block) {
        
        block(tmpView);
    }
    
    return tmpView;
}

+ (instancetype)viewWithFrame:(CGRect)frame
               insertIntoView:(UIView *)view
                   setupBlock:(ViewSetupBlock)block {
    
    UIView *tmpView = [[[self class] alloc] initWithFrame:frame];
    [tmpView supportAccessViewTagProtocol];
    
    view && [view isKindOfClass:[UIView class]] ? ([view addSubview:tmpView]) : 0;
    
    if (block) {
        
        block(tmpView);
    }
    
    return tmpView;
}

+ (instancetype)lineViewInsertIntoView:(UIView *)view positionY:(CGFloat)positionY thick:(CGFloat)thick
                               leftGap:(CGFloat)leftGap rightGap:(CGFloat)rightGap color:(UIColor *)color {
    
    UIView *tmpView = [[[self class] alloc] initWithFrame:CGRectMake(leftGap, positionY, view.frame.size.width - leftGap - rightGap, thick)];
    color ? tmpView.backgroundColor = color : 0;
    [view addSubview:tmpView];
    
    return tmpView;
}

+ (instancetype)lineViewInsertIntoView:(UIView *)view positionX:(CGFloat)positionX thick:(CGFloat)thick
                                topGap:(CGFloat)topGap bottomGap:(CGFloat)bottomGap color:(UIColor *)color {
    
    UIView *tmpView = [[[self class] alloc] initWithFrame:CGRectMake(positionX, topGap, thick, view.frame.size.height - topGap - bottomGap)];
    color ? tmpView.backgroundColor = color : 0;
    [view addSubview:tmpView];
    
    return tmpView;
}

#pragma mark - Runtime property.

- (void)setTagNumberValue:(NSNumber *)tagNumberValue {
    
    objc_setAssociatedObject(self, @selector(tagNumberValue), tagNumberValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)tagNumberValue {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewsWeakMap:(NSMapTable<NSString *,UIView *> *)viewsWeakMap {
    
    objc_setAssociatedObject(self, @selector(viewsWeakMap), viewsWeakMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMapTable<NSString *,UIView *> *)viewsWeakMap {
    
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - AccessViewTagProtocol.

- (void)setView:(UIView *)view withTag:(NSInteger)tag {
    
    [self.viewsWeakMap setObject:view forKey:@(tag).stringValue];
}

- (id)viewWithTag:(NSInteger)tag {
    
    return [self.viewsWeakMap objectForKey:@(tag).stringValue];
}

- (void)removeReferenceWithTag:(NSInteger)tag {
    
    [self.viewsWeakMap removeObjectForKey:@(tag).stringValue];
}

@end

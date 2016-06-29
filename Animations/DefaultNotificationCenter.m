//
//  DefaultNotificationCenter.m
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "DefaultNotificationCenter.h"

@interface DefaultNotificationCenterModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic)         BOOL      effective;

@end

@implementation DefaultNotificationCenterModel

@end

@interface DefaultNotificationCenter ()

@property (nonatomic, strong) NSMutableArray <DefaultNotificationCenterModel *> *stringsArray;

@end

@implementation DefaultNotificationCenter

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.stringsArray = [NSMutableArray array];
    }
    
    return self;
}

+ (void)postEventToNotificationName:(NSString *)name object:(id)object {

    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

- (void)addNotificationName:(NSString *)name {

    // Check have the same name or not.
    __block BOOL haveTheSameName = NO;
    
    [self.stringsArray enumerateObjectsUsingBlock:^(DefaultNotificationCenterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.name isEqualToString:name]) {
            
            haveTheSameName = YES;
            *stop           = YES;
        }
    }];
    
    // Add notification.
    if (haveTheSameName == NO) {
        
        DefaultNotificationCenterModel *model = [DefaultNotificationCenterModel new];
        model.name                            = name;
        model.effective                       = YES;
        [self.stringsArray addObject:model];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEvent:) name:model.name object:nil];
    }
}

- (void)deleteNotificationName:(NSString *)name {
    
    // Check have the same name or not.
    __block BOOL      haveTheSameName = NO;
    __block NSInteger index           = 0;
    
    [self.stringsArray enumerateObjectsUsingBlock:^(DefaultNotificationCenterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.name isEqualToString:name]) {
            
            haveTheSameName = YES;
            index           = idx;
            *stop           = YES;
        }
    }];
    
    // Remove notification.
    if (haveTheSameName == YES) {
        
        DefaultNotificationCenterModel *model = self.stringsArray[index];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:model.name object:nil];
        [self.stringsArray removeObject:model];
    }
}

- (NSArray <NSString *> *)notificationNames {

    NSMutableArray *namesArray = [NSMutableArray array];
    [self.stringsArray enumerateObjectsUsingBlock:^(DefaultNotificationCenterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [namesArray addObject:obj.name];
    }];
    
    return [NSArray arrayWithArray:namesArray];
}

- (void)removeAllNotifications {

    [self.stringsArray enumerateObjectsUsingBlock:^(DefaultNotificationCenterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:obj.name object:nil];
    }];
    
    [self.stringsArray removeAllObjects];
}

- (void)notificationEvent:(id)obj {

    NSNotification *notification = obj;

    if (self.delegate && [self.delegate respondsToSelector:@selector(defaultNotificationCenter:name:object:)]) {
        
        [self.delegate defaultNotificationCenter:self name:notification.name object:notification.object];
    }
}

- (void)dealloc {

    [self removeAllNotifications];
}

@end

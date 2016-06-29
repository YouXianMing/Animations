//
//  DefaultNotificationCenter.h
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DefaultNotificationCenter;

@protocol DefaultNotificationCenterDelegate <NSObject>

@required

/**
 *  DefaultNotificationCenter's event.
 *
 *  @param notification DefaultNotificationCenter object.
 *  @param name         Event name.
 *  @param object       Event object, maybe nil.
 */
- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object;

@end

@interface DefaultNotificationCenter : NSObject

/**
 *  Post event to notification name.
 *
 *  @param name   Notification name.
 *  @param object Data.
 */
+ (void)postEventToNotificationName:(NSString *)name object:(id)object;

/**
 *  DefaultNotificationCenter's delegate.
 */
@property (nonatomic, weak) id <DefaultNotificationCenterDelegate>  delegate;

/**
 *  Add notification name.
 *
 *  @param name Notification name.
 */
- (void)addNotificationName:(NSString *)name;

/**
 *  Delete notification name.
 *
 *  @param name Notification name.
 */
- (void)deleteNotificationName:(NSString *)name;

/**
 *  Get all the notification names.
 *
 *  @return Notification names's array.
 */
- (NSArray <NSString *> *)notificationNames;

/**
 *  Remove all notifications.
 */
- (void)removeAllNotifications;

@end

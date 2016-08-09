//
//  NSObject+ViewTag.h
//  Tag
//
//  Created by YouXianMing on 16/8/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (ViewTag)

/**
 *  Get the view by the identifier.
 *
 *  @param identifier The identifier you set.
 *
 *  @return Kind of UIView object.
 */
- (id)viewWithIdentifier:(NSString *)identifier;

/**
 *  Attach to the object with you specified identifier.
 *
 *  @param object     The object you want to attached.
 *  @param identifier The identifier you set.
 */
- (void)attachTo:(id)object setIdentifier:(NSString *)identifier;

@end

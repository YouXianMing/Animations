//
//  NSObject+AccessViewTag.h
//  ViewTag
//
//  Created by YouXianMing on 16/8/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (AccessViewTag)

/**
 *  Support access view tag.
 */
- (void)supportAccessViews;

/**
 *  Set view with viewId string.
 *
 *  @param view   View.
 *  @param viewId View's id string.
 */
- (void)setView:(UIView *)view withId:(NSString *)viewId;

/**
 *  Get view from the id string.
 *
 *  @param viewId View's id string.
 *
 *  @return View.
 */
- (id)viewWithId:(NSString *)viewId;

@end

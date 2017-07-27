//
//  ItemStyle.h
//  ItemStyle
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemStyle : NSObject

/**
 The source object to use the style.
 */
@property (nonatomic, weak) id source;

/**
 Get the style object.
 
 @return The style object.
 */
+ (instancetype)style;

/**
 [- Must Overwrite by subclass -]
 
 Make the style effective.
 */
- (void)makeStyleEffective;

@end

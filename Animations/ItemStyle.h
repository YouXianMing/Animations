//
//  ItemStyle.h
//  ItemObject
//
//  Created by YouXianMing on 2016/12/25.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemStyle : NSObject

/**
 The source object.
 */
@property (nonatomic, weak) id item;

/**
 Make the style effective, override by subclass.
 */
- (void)makeEffect;

@end

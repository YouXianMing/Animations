//
//  StringAttribute.h
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StringAttributeProtocol.h"

@interface StringAttribute : NSObject <StringAttributeProtocol>

/**
 *  富文本设置的生效范围
 */
@property (nonatomic) NSRange  effectRange;

@end

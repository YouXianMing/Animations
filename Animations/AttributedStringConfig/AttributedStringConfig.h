//
//  AttributedStringConfig.h
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AttributedStringConfig : NSObject

@property (nonatomic, strong, readonly) NSString *attributeName;
@property (nonatomic, strong, readonly) id        attributeValue;
@property (nonatomic)                   NSRange   effectiveStringRange;

@end

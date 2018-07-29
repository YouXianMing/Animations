//
//  Item.h
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) id        object;
@property (nonatomic)                   NSInteger index;

+ (instancetype)itemWithObject:(id)object name:(NSString *)name;

@property (nonatomic, copy, readonly) NSMutableAttributedString *nameString;

@end

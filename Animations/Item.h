//
//  Item.h
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id        object;
@property (nonatomic)                   NSInteger index;

+ (instancetype)itemWithObject:(id)object name:(NSString *)name;

@property (nonatomic, strong, readonly) NSMutableAttributedString *nameString;

@end

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

+ (instancetype)itemWithName:(NSString *)name object:(id)object;

@property (nonatomic)                   NSInteger index;
@property (nonatomic, strong, readonly) NSMutableAttributedString *nameString;

- (void)createAttributedString;

@end

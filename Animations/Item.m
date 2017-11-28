//
//  Item.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "Item.h"
#import "UIFont+Fonts.h"
#import "AttributedStringConfigHelper.h"

@interface Item ()

@property (nonatomic, strong) NSMutableAttributedString *nameString;

@end

@implementation Item

+ (instancetype)itemWithObject:(id)object name:(NSString *)name {
    
    Item *item  = [[[self class] alloc] init];
    item.name   = name;
    item.object = object;
    
    return item;
}

- (NSMutableAttributedString *)nameString {
    
    if (_nameString == nil) {
        
        NSString *fullStirng = [NSString stringWithFormat:@"%02ld. %@", (long)self.index, self.name];
        
        NSMutableAttributedString *richString = [NSMutableAttributedString mutableAttributedStringWithString:fullStirng config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
            
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont HeitiSCWithFontSize:16.f] range:NSMakeRange(0, string.length)]];
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"GillSans-Italic" size:16.f] range:NSMakeRange(0, 3)]];
            [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.65f] range:NSMakeRange(0, string.length)]];
            [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor redColor] colorWithAlphaComponent:0.65f] range:NSMakeRange(0, 3)]];
        }];
        
        _nameString = richString;
    }
    
    return _nameString;
}

@end

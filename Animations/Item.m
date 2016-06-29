//
//  Item.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "Item.h"
#import "UIFont+Fonts.h"
#import "StringAttributeHelper.h"

@interface Item ()

@property (nonatomic, strong) NSMutableAttributedString *nameString;

@end

@implementation Item

+ (instancetype)itemWithName:(NSString *)name object:(id)object {

    Item *item  = [[[self class] alloc] init];
    item.name   = name;
    item.object = object;
    
    return item;
}

- (void)createAttributedString {

    NSString *fullStirng = [NSString stringWithFormat:@"%02ld. %@", (long)self.index, self.name];
    
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:fullStirng];
    
    {
        FontAttribute *fontAttribute = [FontAttribute new];
        fontAttribute.font           = [UIFont HeitiSCWithFontSize:16.f];
        fontAttribute.effectRange    = NSMakeRange(0, richString.length);
        [richString addStringAttribute:fontAttribute];
    }
    
    {
        FontAttribute *fontAttribute = [FontAttribute new];
        fontAttribute.font           = [UIFont fontWithName:@"GillSans-Italic" size:16.f];
        fontAttribute.effectRange    = NSMakeRange(0, 3);
        [richString addStringAttribute:fontAttribute];
    }
    
    {
        ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
        foregroundColorAttribute.color                     = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
        foregroundColorAttribute.effectRange               = NSMakeRange(0, richString.length);
        [richString addStringAttribute:foregroundColorAttribute];
    }
    
    {
        ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
        foregroundColorAttribute.color                     = [[UIColor redColor] colorWithAlphaComponent:0.65f];
        foregroundColorAttribute.effectRange               = NSMakeRange(0, 3);
        [richString addStringAttribute:foregroundColorAttribute];
    }
    
    self.nameString = richString;
}

@end

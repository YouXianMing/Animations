//
//  FontInfomation.m
//  YouXianMing
//
//  Created by XianMingYou on 15/2/11.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "FontInfomation.h"

static NSMutableDictionary *_systemFontDictionary = nil; // 系统字体信息

@implementation FontInfomation

+ (void)initialize {
    
    if (self == [FontInfomation class]) {
        
        _systemFontDictionary = [[NSMutableDictionary alloc] init];
        
        // 获取系统字体族
        [FontInfomation getSystemFontList];
    }
}

+ (void)getSystemFontList {
    
    NSArray *familyNames = [UIFont familyNames];
    
    for( NSString *familyName in familyNames) {
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [_systemFontDictionary setObject:fontNames forKey:familyName];
    }
}

+ (NSDictionary *)systomFontNameList {
    
    return [NSDictionary dictionaryWithDictionary:_systemFontDictionary];
}

@end

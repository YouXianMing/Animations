//
//  RegexManager.m
//  Regex
//
//  Created by YouXianMing on 2017/7/5.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "RegexManager.h"

@interface RegexManager ()

@property (nonatomic, strong) NSRegularExpression        *regex;
@property (nonatomic)         NSUInteger                  numberOfMatches;
@property (nonatomic, strong) NSMutableArray <NSValue *> *matchs;

@end

@implementation RegexManager

- (instancetype)start {
    
    NSParameterAssert(self.pattern);
    self.regex = [NSRegularExpression regularExpressionWithPattern:self.pattern options:self.options error:nil];
    
    return self;
}

- (NSUInteger)numberOfMatches {
    
    NSParameterAssert(self.string);
    return [self.regex numberOfMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length)];
}

- (NSMutableArray<NSValue *> *)matchs {
    
    NSParameterAssert(self.string);
    NSArray<NSTextCheckingResult *> *array = [self.regex matchesInString:self.string options:0 range:NSMakeRange(0, self.string.length)];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSTextCheckingResult *result in array) {
        
        [tmpArray addObject:[NSValue valueWithRange:result.range]];
    }
    
    return tmpArray;
}

- (NSString *)replacingWithTemplate:(NSString *)string {
    
    NSParameterAssert(self.string);
    NSParameterAssert(string);
    
    return [self.regex stringByReplacingMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) withTemplate:string];
}

+ (instancetype)regexManagerWithString:(NSString *)string pattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    
    RegexManager *manger = [[[self class] alloc] init];
    manger.string        = string;
    manger.pattern       = pattern;
    manger.options       = options;
    
    return manger;
}

+ (instancetype)regexManagerWithString:(NSString *)string pattern:(NSString *)pattern {
    
    RegexManager *manger = [[[self class] alloc] init];
    manger.string        = string;
    manger.pattern       = pattern;
    
    return manger;
}

@end

@implementation NSString (RegexManager)

- (BOOL)existWithRegexPattern:(NSString *)pattern {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern] start] numberOfMatches] > 0 ? YES : NO;
}

- (BOOL)existWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern options:options] start] numberOfMatches] > 0 ? YES : NO;
}

- (NSMutableArray <NSValue *> *)matchsWithRegexPattern:(NSString *)pattern {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern] start] matchs];
}

- (NSMutableArray <NSValue *> *)matchsWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern options:options] start] matchs];
}

- (NSMutableArray <NSString *> *)matchStringsArrayWithRegexPattern:(NSString *)pattern {
    
    // Get all rangeValues.
    NSMutableArray <NSValue *> *rangeValues  = [[[RegexManager regexManagerWithString:self pattern:pattern] start] matchs];
    
    // Store match strings.
    NSMutableArray *matchStrings = [NSMutableArray array];
    [rangeValues enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [matchStrings addObject:[self substringWithRange:obj.rangeValue]];
    }];
    
    return matchStrings;
}

- (NSMutableArray <NSString *> *)matchStringsArrayWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    
    // Get all rangeValues.
    NSMutableArray <NSValue *> *rangeValues  = [[[RegexManager regexManagerWithString:self pattern:pattern options:options] start] matchs];
    
    // Store match strings.
    NSMutableArray *matchStrings = [NSMutableArray array];
    [rangeValues enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [matchStrings addObject:[self substringWithRange:obj.rangeValue]];
    }];
    
    return matchStrings;
}

- (NSString *)replacingWithPattern:(NSString *)pattern template:(NSString *)templ {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern] start] replacingWithTemplate:templ];
}

- (NSString *)replacingWithPattern:(NSString *)pattern template:(NSString *)templ options:(NSRegularExpressionOptions)options {
    
    return [[[RegexManager regexManagerWithString:self pattern:pattern options:options] start] replacingWithTemplate:templ];
}

@end

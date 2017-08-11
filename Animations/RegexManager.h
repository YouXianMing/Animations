//
//  RegexManager.h
//  Regex
//
//  Created by YouXianMing on 2017/7/5.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexManager : NSObject

/**
 The source string.
 */
@property (nonatomic, strong) NSString *string;

/**
 The regex pattern.
 */
@property (nonatomic, strong) NSString *pattern;

/**
 The search's option.
 */
@property (nonatomic) NSRegularExpressionOptions options;

/**
 Start to search.
 
 @return RegexManager's instance.
 */
- (instancetype)start;

/**
 The search's result, NSRange's values array.
 */
@property (nonatomic, strong, readonly) NSMutableArray <NSValue *> *matchs;

/**
 The search's result, number of matches.
 */
@property (nonatomic, readonly) NSUInteger numberOfMatches;

/**
 The replacing's result.
 
 @param string The templete.
 @return The result string.
 */
- (NSString *)replacingWithTemplate:(NSString *)string;

/**
 [ Constructor ]
 
 @param string The source string.
 @param pattern The regex pattern.
 @param options The search's option.
 @return RegexManager's instance.
 */
+ (instancetype)regexManagerWithString:(NSString *)string pattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

/**
 [ Constructor ]
 
 @param string The source string.
 @param pattern The regex pattern.
 @return RegexManager's instance.
 */
+ (instancetype)regexManagerWithString:(NSString *)string pattern:(NSString *)pattern;

@end

#pragma mark - RegexManager's NSString category.

@interface NSString (RegexManager)

- (BOOL)existWithRegexPattern:(NSString *)pattern;
- (BOOL)existWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

- (NSMutableArray <NSValue *> *)matchsWithRegexPattern:(NSString *)pattern;
- (NSMutableArray <NSValue *> *)matchsWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

- (NSMutableArray <NSString *> *)matchStringsArrayWithRegexPattern:(NSString *)pattern;
- (NSMutableArray <NSString *> *)matchStringsArrayWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

- (NSString *)replacingWithPattern:(NSString *)pattern template:(NSString *)templ;
- (NSString *)replacingWithPattern:(NSString *)pattern template:(NSString *)templ options:(NSRegularExpressionOptions)options;

@end


//
//  StringRangeManager.m
//  NSString
//
//  Created by YouXianMing on 16/5/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "StringRangeManager.h"

@interface StringRangeManager ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSString *>  *parts;
@property (nonatomic)         NSRange contentRange;

@end

@implementation StringRangeManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.parts = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSArray *)rangesFromPartName:(NSString *)partName options:(NSStringCompareOptions)mask {
    
    NSParameterAssert(partName);
    
    NSArray  *array = nil;
    NSString *part  = self.parts[partName];
    
    if (part) {
        
        array = [self.content rangesOfString:part options:0 serachRange:NSMakeRange(0, self.content.length)];
    }
    
    return array;
}

+ (instancetype)stringRangeManagerWithContent:(NSString *)content parts:(NSDictionary *)parts {
    
    StringRangeManager *manager = [[[self class] alloc] init];
    manager.content             = content;
    manager.parts               = [NSMutableDictionary dictionaryWithDictionary:parts];
    
    return manager;
}

- (NSRange)contentRange {
    
    return NSMakeRange(0, _content.length);
}

@end

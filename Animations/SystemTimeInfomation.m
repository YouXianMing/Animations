//
//  SystemTimeInfomation.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "SystemTimeInfomation.h"

static SystemTimeInfomation  *_sharedSingleton = nil;

@interface SystemTimeInfomation ()

@property (nonatomic, strong) NSString *dateFormatString;

@end

@implementation SystemTimeInfomation

- (instancetype)init {
    
    [NSException raise:@"SystemTimeInfomation"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    [NSException raise:@"SystemTimeInfomation"
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    
    return nil;
}

+ (SystemTimeInfomation *)sharedInstance {

    if (self != [SystemTimeInfomation class]) {
        
        [NSException raise:@"SystemTimeInfomation"
                    format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedSingleton = [[SystemTimeInfomation alloc] initInstance];
    });
    
    return _sharedSingleton;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

- (NSDictionary *)currentTimeInfomation {
    
    if (_dateFormatter == nil) {
        
        if (self.dateFormatString == nil) {
            
            self.dateFormatString = @"HH:mm:ss";
        }
        
        _dateFormatter            = [[NSDateFormatter alloc] init];
        _dateFormatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _dateFormatter.dateFormat = self.dateFormatString;
        
    } else {
        
        if (self.dateFormatString == nil) {
            
            self.dateFormatString = @"HH:mm:ss";
        }
    
        _dateFormatter.dateFormat = self.dateFormatString;
    }
    
    NSString *timerNow    = [_dateFormatter stringFromDate:[NSDate date]];
    NSArray  *timeArray   = [timerNow componentsSeparatedByString:@":"];
    NSArray  *formatArray = [_dateFormatter.dateFormat componentsSeparatedByString:@":"];
    
    NSMutableDictionary *timeDictionary = [NSMutableDictionary dictionary];
    for (int i = 0; i < timeArray.count; i++) {
        
        [timeDictionary setObject:timeArray[i] forKey:formatArray[i]];
    }
    
    return timeDictionary;
}

- (void)setDateFormatterString:(NSString *)dateFormatterString {

    self.dateFormatString = dateFormatterString;
}

@end

//
//  UIViewController+RuntimeReplace.m
//  Animations
//
//  Created by YouXianMing on 2018/7/5.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "UIViewController+RuntimeReplace.h"
#import "Runtime_Method.h"
#import <asl.h>

typedef enum : NSUInteger {
    
    kEnterControllerType = 1000,
    kLeaveControllerType,
    kDeallocType,
    
} EDebugTag;

#define _Flag_NSLog(fmt,...) {                                        \
do                                                                  \
{                                                                   \
NSString *str = [NSString stringWithFormat:fmt, ##__VA_ARGS__];   \
printf("%s\n",[str UTF8String]);                                  \
}                                                                   \
while (0);                                                          \
}

#ifdef DEBUG
#define ControllerLog(fmt, ...) _Flag_NSLog((@"" fmt), ##__VA_ARGS__)
#else
#define ControllerLog(...)
#endif

@implementation UIViewController (RuntimeReplace)

+ (void)debug_runtime_replace {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 交换方法runtime_replace_viewDidAppear:与viewDidAppear:
        {
            Runtime_IMP *imp_1 = [Runtime_IMP impWithClass:UIViewController.class
                                                      name:@selector(runtime_replace_viewDidAppear:)
                                             isClassMethod:NO];
            
            Runtime_IMP *imp_2 = [Runtime_IMP impWithClass:UIViewController.class
                                                      name:@selector(viewDidAppear:)
                                             isClassMethod:NO];
            
            [Runtime_Method exchangeMethodIMP:imp_1 withIMP:imp_2];
        }
        
        // 交换方法runtime_replace_viewDidDisappear:与viewDidDisappear:
        {
            Runtime_IMP *imp_1 = [Runtime_IMP impWithClass:UIViewController.class
                                                      name:@selector(runtime_replace_viewDidDisappear:)
                                             isClassMethod:NO];
            
            Runtime_IMP *imp_2 = [Runtime_IMP impWithClass:UIViewController.class
                                                      name:@selector(viewDidDisappear:)
                                             isClassMethod:NO];
            
            [Runtime_Method exchangeMethodIMP:imp_1 withIMP:imp_2];
        }
    });
}

- (void)runtime_replace_viewDidAppear:(BOOL)animated {
    
    [self runtime_replace_viewDidAppear:animated];
    [self debugWithString:@"[➡️] Did entered to" debugTag:kEnterControllerType];
}

- (void)runtime_replace_viewDidDisappear:(BOOL)animated {
    
    [self runtime_replace_viewDidDisappear:animated];
    [self debugWithString:@"[⛔️] Did left from" debugTag:kLeaveControllerType];
}

#pragma mark - Debug message.

- (void)debugWithString:(NSString *)string debugTag:(EDebugTag)tag {

    if ([self isKindOfClass:[UINavigationController class]]) {
        
        NSDateFormatter *outputFormatter  = [[NSDateFormatter alloc] init] ;
        outputFormatter.dateFormat        = @"HH:mm:ss.SSS";
        
        NSString        *classString = [NSString stringWithFormat:@" %@ %@ [ Nav - %@ ] ", [outputFormatter stringFromDate:[NSDate date]], string, [self class]];
        NSMutableString *flagString  = [NSMutableString string];
        
        for (int i = 0; i < classString.length; i++) {
            
            if (i == 0 || i == classString.length - 1) {
                
                [flagString appendString:@"+"];
                continue;
            }
            
            switch (tag) {
                    
                case kEnterControllerType:
                    [flagString appendString:@">"];
                    break;
                    
                case kLeaveControllerType:
                    [flagString appendString:@"<"];
                    break;
                    
                case kDeallocType:
                    [flagString appendString:@" "];
                    break;
                    
                default:
                    break;
            }
        }
        
        NSString *showSting = [NSString stringWithFormat:@"\n%@\n%@\n%@\n", flagString, classString, flagString];
        ControllerLog(@"%@", showSting);
        
    } else {
        
        NSDateFormatter *outputFormatter  = [[NSDateFormatter alloc] init] ;
        outputFormatter.dateFormat        = @"HH:mm:ss.SSS";
        
        NSString        *classString = [NSString stringWithFormat:@" %@ %@ [%@] ", [outputFormatter stringFromDate:[NSDate date]], string, [self class]];
        NSMutableString *flagString  = [NSMutableString string];
        
        for (int i = 0; i < classString.length; i++) {
            
            if (i == 0 || i == classString.length - 1) {
                
                [flagString appendString:@"+"];
                continue;
            }
            
            switch (tag) {
                    
                case kEnterControllerType:
                    [flagString appendString:@">"];
                    break;
                    
                case kLeaveControllerType:
                    [flagString appendString:@"<"];
                    break;
                    
                case kDeallocType:
                    [flagString appendString:@" "];
                    break;
                    
                default:
                    break;
            }
        }
        
        NSString *showSting = [NSString stringWithFormat:@"\n%@\n%@\n%@\n", flagString, classString, flagString];
        ControllerLog(@"%@", showSting);
    }
}

@end

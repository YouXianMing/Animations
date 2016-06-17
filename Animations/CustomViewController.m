//
//  CustomViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"
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
asl_log(NULL, NULL, ASL_LEVEL_NOTICE, "%s", [str UTF8String]);    \
}                                                                   \
while (0);                                                          \
}

#ifdef DEBUG
#define ControllerLog(fmt, ...) _Flag_NSLog((@"" fmt), ##__VA_ARGS__)
#else
#define ControllerLog(...)
#endif

@interface CustomViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMapTable <NSString *, UIView *> *viewsWeakMap;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.viewsWeakMap                         = [NSMapTable strongToWeakObjectsMapTable];
    self.width                                = [UIScreen mainScreen].bounds.size.width;
    self.height                               = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor                 = [UIColor whiteColor];
}

- (void)useInteractivePopGestureRecognizer {
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popViewControllerAnimated:(BOOL)animated {
    
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
#ifdef DEBUG
    
    [self debugWithString:@"Did entered to" debugTag:kEnterControllerType];
    
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    
#ifdef DEBUG
    
    [self debugWithString:@"Did left from" debugTag:kLeaveControllerType];
    
#endif
}

- (void)dealloc {
    
#ifdef DEBUG
    
    [self debugWithString:@"Did released the" debugTag:kDeallocType];
    
#endif
}

#pragma mark - Overwrite setter & getter.

@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}

#pragma mark - Debug message.

- (void)debugWithString:(NSString *)string debugTag:(EDebugTag)tag {
    
    NSDateFormatter *outputFormatter  = [[NSDateFormatter alloc] init] ;
    outputFormatter.dateFormat        = @"HH:mm:ss.SSS";
    
    NSString        *classString = [NSString stringWithFormat:@" %@ %@ [%@] ",
                                    [outputFormatter stringFromDate:[NSDate date]],
                                    string,
                                    [self class]];
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

#pragma mark - AccessViewTagProtocol

- (void)setView:(UIView *)view withTag:(NSInteger)tag {
    
    [_viewsWeakMap setObject:view forKey:@(tag).stringValue];
}

- (id)viewWithTag:(NSInteger)tag {
    
    return [_viewsWeakMap objectForKey:@(tag).stringValue];
}

@end

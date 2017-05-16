//
//  BaseCustomViewController.m
//  BaseStructrue
//
//  Created by YouXianMing on 2017/5/15.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "BaseCustomViewController.h"
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

@interface BaseCustomViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *viewsConfig;

@end

@implementation BaseCustomViewController

NSString * const titleViewId       = @"titleViewId";
NSString * const loadingAreaViewId = @"loadingAreaViewId";
NSString * const windowAreaViewId  = @"windowAreaViewId";
NSString * const contentViewId     = @"contentViewId";
NSString * const backgroundViewId  = @"backgroundViewId";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initViewsConfigs];
    [self makeViewsConfig:self.viewsConfig];
    [self buildConfigViews];
    [self setupSubViews];
}

- (void)initViewsConfigs {
    
    self.viewsConfig = [[NSMutableDictionary alloc] init];
    CGFloat width    = [UIScreen mainScreen].bounds.size.width;
    CGFloat height   = [UIScreen mainScreen].bounds.size.height;
    
    // backgroundView config.
    {
        ControllerBaseViewConfig *config   = [ControllerBaseViewConfig new];
        config.exist                       = YES;
        config.frame                       = CGRectMake(0, 0, width, height);
        config.backgroundColor             = [UIColor whiteColor];
        self.viewsConfig[backgroundViewId] = config;
    }
    
    // contentView config.
    {
        ControllerBaseViewConfig *config = [ControllerBaseViewConfig new];
        config.exist                     = YES;
        config.frame                     = CGRectMake(0, 64, width, height - 64);
        config.backgroundColor           = [UIColor clearColor];
        self.viewsConfig[contentViewId]  = config;
    }
    
    // titleView config.
    {
        ControllerBaseViewConfig *config = [ControllerBaseViewConfig new];
        config.exist                     = YES;
        config.frame                     = CGRectMake(0, 0, width, 64.f);
        config.backgroundColor           = [UIColor clearColor];
        self.viewsConfig[titleViewId]    = config;
    }
    
    // loadingAreaView config.
    {
        ControllerBaseViewConfig *config    = [ControllerBaseViewConfig new];
        config.exist                        = YES;
        config.frame                        = CGRectMake(0, 64, width, height - 64.f);
        config.backgroundColor              = [UIColor clearColor];
        self.viewsConfig[loadingAreaViewId] = config;
    }
    
    // windowAreaView config.
    {
        ControllerBaseViewConfig *config   = [ControllerBaseViewConfig new];
        config.exist                       = YES;
        config.frame                       = CGRectMake(0, 0, width, height);
        config.backgroundColor             = [UIColor clearColor];
        self.viewsConfig[windowAreaViewId] = config;
    }
}

- (void)buildConfigViews {
    
    // backgroundView
    {
        ControllerBaseViewConfig *config = self.viewsConfig[backgroundViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            [self.view addSubview:view];
            self.backgroundView  = view;
        }
    }
    
    // contentView
    {
        ControllerBaseViewConfig *config = self.viewsConfig[contentViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            [self.view addSubview:view];
            self.contentView     = view;
        }
    }
    
    // titleView
    {
        ControllerBaseViewConfig *config = self.viewsConfig[titleViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            [self.view addSubview:view];
            self.titleView       = view;
        }
    }
    
    // loadingAreaView
    {
        ControllerBaseViewConfig *config = self.viewsConfig[loadingAreaViewId];
        if (config && config.exist) {
            
            ShowLoadingView *view = [[ShowLoadingView alloc] initWithFrame:config.frame];
            view.backgroundColor  = config.backgroundColor;
            [self.view addSubview:view];
            self.loadingAreaView  = view;
        }
    }
    
    // windowAreaView
    {
        ControllerBaseViewConfig *config = self.viewsConfig[windowAreaViewId];
        if (config && config.exist) {
            
            ShowLoadingView *view = [[ShowLoadingView alloc] initWithFrame:config.frame];
            view.backgroundColor  = config.backgroundColor;
            [self.view addSubview:view];
            self.windowAreaView   = view;
        }
    }
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
    
    [self debugWithString:@"[➡️] Did entered to" debugTag:kEnterControllerType];
    
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    
#ifdef DEBUG
    
    [self debugWithString:@"[⛔️] Did left from" debugTag:kLeaveControllerType];
    
#endif
}

- (void)dealloc {
    
#ifdef DEBUG
    
    [self debugWithString:@"[❌] Did released the" debugTag:kDeallocType];
    
#endif
}

#pragma mark - Debug message.

- (void)debugWithString:(NSString *)string debugTag:(EDebugTag)tag {
    
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

#pragma mark - Overwrite setter & getter.

@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}

#pragma mark - Overwrite by subclass.

- (void)makeViewsConfig:(NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *)viewsConfig {
    
}

- (void)setupSubViews {
    
}

@end

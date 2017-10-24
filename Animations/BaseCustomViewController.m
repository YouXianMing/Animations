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
    [self setupDataSource];
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

#pragma mark - Overwrite by subclass.

- (void)makeViewsConfig:(NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *)viewsConfig {
    
}

- (void)setupSubViews {
    
}

- (void)setupDataSource {
    
}

@end

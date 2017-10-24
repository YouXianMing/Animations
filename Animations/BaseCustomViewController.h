//
//  BaseCustomViewController.h
//  BaseStructrue
//
//  Created by YouXianMing on 2017/5/15.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomViewController.h"
#import "ShowLoadingView.h"
#import "ControllerBaseViewConfig.h"

@interface BaseCustomViewController : CustomViewController

extern NSString * const windowAreaViewId;
extern NSString * const loadingAreaViewId;
extern NSString * const titleViewId;
extern NSString * const contentViewId;
extern NSString * const backgroundViewId;

//  level            view            frame
//  ---------------------------------------------------------------
//
//  highest          windowView      0 x  0 x width x height
//
//  higher           loadingView     0 x 64 x width x (height - 64)
//
//  high             titleView       0 x  0 x width x 64
//
//  high             contentView     0 x 64 x width x (height - 64)
//
//  normal           backgroundView  0 x  0 x width x height
//

@property (nonatomic, strong) ShowLoadingView  *windowAreaView;
@property (nonatomic, strong) ShowLoadingView  *loadingAreaView;
@property (nonatomic, strong) UIView           *titleView;
@property (nonatomic, strong) UIView           *contentView;
@property (nonatomic, strong) UIView           *backgroundView;

#pragma mark - Overwrite by subClass.

/**
 *  Overwrite to config subViews.
 *
 *  @param viewsConfig Configs.
 */
- (void)makeViewsConfig:(NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *)viewsConfig;

/**
 *  Setup data source.
 */
- (void)setupDataSource;

/**
 *  Overwrite to setup titleView, contentView etc.
 */
- (void)setupSubViews;

@end

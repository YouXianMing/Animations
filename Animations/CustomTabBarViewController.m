//
//  CustomTabBarViewController.m
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@property (nonatomic, strong) UIView            *tabBarView;
@property (nonatomic, weak)   UIViewController  *currentViewController;

@end

@implementation CustomTabBarViewController

- (instancetype)init {
    
    if (self = [super init]) {
        
        _tabBarHeight        = 49.f;
        _firstLoadIndex      = 0;
        self.viewControllers = [NSMutableArray array];
    }
    
    return self;
}

- (void)makeViewsConfig:(NSMutableDictionary<NSString *,ControllerBaseViewConfig *> *)viewsConfig {
    
    // 加载区域View
    {
        ControllerBaseViewConfig *config = viewsConfig[loadingAreaViewId];
        config.exist                     = NO;
    }
    
    // window加载区域View
    {
        ControllerBaseViewConfig *config = viewsConfig[windowAreaViewId];
        config.exist                     = NO;
    }
    
    // 标题View
    {
        ControllerBaseViewConfig *config = viewsConfig[titleViewId];
        config.exist                     = NO;
    }
    
    // 背景View
    {
        ControllerBaseViewConfig *config = viewsConfig[backgroundViewId];
        config.exist                     = NO;
    }
    
    // 内容View(只显示内容View)
    {
        ControllerBaseViewConfig *config = viewsConfig[contentViewId];
        config.exist                     = YES;
        config.frame                     = self.view.bounds;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Add tabBarView.
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - _tabBarHeight,
                                                               self.view.frame.size.width, _tabBarHeight)];
    [self.view addSubview:self.tabBarView];
    
    // Add controllers by subClass.
    [self addChildViewControllers:self.viewControllers];
    
    // Build items.
    [self buildItems];
    
    // Add ChildViewController.
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        UIViewController *customViewController = self.viewControllers[i];
        [self addChildViewController:customViewController];
    }
    
    // Load first show controller.
    [self.viewControllers[_firstLoadIndex] didMoveToParentViewController:self];
    [self.contentView addSubview:self.viewControllers[_firstLoadIndex].view];
    self.currentViewController = self.viewControllers[_firstLoadIndex];
    [self didSelectedIndex:_firstLoadIndex];
}

- (void)buildItems {
    
    // Overwrite by subClass.
}

- (void)addChildViewControllers:(NSMutableArray <UIViewController *> *)controllers {
    
    // Overwrite by subClass.
}

- (BOOL)willSelectIndex:(NSInteger)index {
    
    if (self.tabBarViewControllerDelegate && [self.tabBarViewControllerDelegate respondsToSelector:@selector(customTabBarController:shouldSelectViewController:selectedIndex:)]) {
        
        return [self.tabBarViewControllerDelegate customTabBarController:self shouldSelectViewController:self.viewControllers[index] selectedIndex:index];
        
    } else {
        
        return YES;
    }
}

- (void)didSelectedIndex:(NSInteger)index {
    
    if (self.tabBarViewControllerDelegate && [self.tabBarViewControllerDelegate respondsToSelector:@selector(customTabBarController:didSelectViewController:selectedIndex:)]) {
        
        [self.tabBarViewControllerDelegate customTabBarController:self didSelectViewController:self.viewControllers[index] selectedIndex:index];
    }
    
    if ([self.currentViewController isEqual:self.viewControllers[index]]) {
        
        return;
    }
    
    [self transitionFromViewController:self.currentViewController toViewController:self.viewControllers[index] duration:0
                               options:UIViewAnimationOptionTransitionNone
                            animations:nil completion:^(BOOL finished) {
                                
                                self.currentViewController = self.viewControllers[index];
                            }];
}

- (void)hideTabBarView:(BOOL)hide animated:(BOOL)animated {
    
    CGRect  frame    = self.tabBarView.frame;
    CGFloat duration = 0.5f;
    
    if (hide) {
        
        if (animated) {
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                self.tabBarView.frame = CGRectMake(0, self.view.bounds.size.height, frame.size.width, frame.size.height);
                self.tabBarView.alpha = 0.f;
                
            } completion:nil];
            
        } else {
            
            self.tabBarView.frame = CGRectMake(0, self.view.bounds.size.height, frame.size.width, frame.size.height);
            self.tabBarView.alpha = 0.f;
        }
        
    } else {
        
        if (animated) {
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                self.tabBarView.frame = CGRectMake(0, self.view.bounds.size.height - frame.size.height,
                                                   frame.size.width, frame.size.height);
                self.tabBarView.alpha = 1.f;
                
            } completion:nil];
            
        } else {
            
            self.tabBarView.frame = CGRectMake(0, self.view.bounds.size.height - frame.size.height,
                                               frame.size.width, frame.size.height);
            self.tabBarView.alpha = 1.f;
        }
    }
}

@end

//
//  NodeModelRootNavigationController.m
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "NodeModelRootNavigationController.h"

@interface NodeModelRootNavigationController ()

@property (nonatomic, strong) NodeModel *rootNodeModel;

@end

@implementation NodeModelRootNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
}

- (instancetype)initWithRootViewController:(NodeModelViewController *)rootViewController rootNodeModel:(NodeModel *)rootNodeModel {
    
    self                         = [super initWithRootViewController:rootViewController];
    self.rootNodeModel           = rootNodeModel;
    rootViewController.nodeModel = rootNodeModel;
    
    return self;
}

- (void)setup {

    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.f]}];
    
    [self.navigationBar setBackgroundImage:[self imageWithFrame:CGRectMake(0, 0, 10, 10) backgroundColor:[[UIColor cyanColor] colorWithAlphaComponent:0.45f]]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setShadowImage:[self imageWithFrame:CGRectMake(0, 0, 10, 10) backgroundColor:[UIColor clearColor]]];
}

#pragma mark - 重载父类进行改写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //先进入子Controller
    [super pushViewController:viewController animated:animated];
    
    //替换掉leftBarButtonItem
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
}

- (UIBarButtonItem *)customLeftBackButton {
    
    UIImage *image       = [UIImage imageNamed:@"NodeModelViewControllerBack_black"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

- (UIImage *)imageWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    UIImage *image       = nil;
    UIView *view         = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

//
//  AppDelegate.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationsListViewController.h"
#import "CustomNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     Swift version Animations - https://github.com/YouXianMing/Swift-Animations
     
     Lateast no warning version : Xcode Version 8.0 (8A218a)
     
     QQ    705786299
     Email YouXianMing1987@126.com
     
     http://www.cnblogs.com/YouXianMing/
     https://github.com/YouXianMing
     https://github.com/YouXianMing/YoCelsius
     
     AppStore : https://itunes.apple.com/us/app/yocelsius/id967721892?l=zh&ls=1&mt=8
     Video    : http://my.jikexueyuan.com/YouXianMing/record/
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AnimationsListViewController *viewController       = [AnimationsListViewController new];
    CustomNavigationController   *navigationController = [[CustomNavigationController alloc] initWithRootViewController:viewController
                                                                                                 setNavigationBarHidden:YES];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor    = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end

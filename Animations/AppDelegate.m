//
//  AppDelegate.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationsListController.h"
#import "AnimationsListViewNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     Swift version Animations - https://github.com/YouXianMing/Swift-Animations
     
     Lateast no warning version : Xcode 9.3 (9E145)
     
     QQ    705786299
     Email YouXianMing1987@126.com
     
     http://www.cnblogs.com/YouXianMing/
     https://github.com/YouXianMing
     https://github.com/YouXianMing/YoCelsius
     
     独立开发作品 (感兴趣的朋友支持一下^_^) : https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1390862464&mt=8
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AnimationsListController               *viewController       = [AnimationsListController new];
    AnimationsListViewNavigationController *navigationController = [[AnimationsListViewNavigationController alloc] initWithRootViewController:viewController
                                                                                                                       setNavigationBarHidden:YES];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor    = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end

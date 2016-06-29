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
     
     最新编译无警告版本 Xcode Version 7.3.1 (7D1014)
     
     QQ   705786299
     邮箱  YouXianMing1987@126.com
     博客  http://www.cnblogs.com/YouXianMing/
     源码  https://github.com/YouXianMing
     项目  https://github.com/YouXianMing/YoCelsius
     
     苹果下载地址： https://itunes.apple.com/us/app/yocelsius/id967721892?l=zh&ls=1&mt=8
     本人讲解视频： http://my.jikexueyuan.com/YouXianMing/record/
     
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

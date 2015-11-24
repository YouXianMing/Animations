//
//  AppDelegate.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationsListViewController.h"
#import "UIColor+CustomColors.h"
#import "CustomNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AnimationsListViewController *animationsListViewController = [AnimationsListViewController new];
    CustomNavigationController   *navigationController         = \
        [[CustomNavigationController alloc] initWithRootViewController:animationsListViewController setNavigationBarHidden:YES];
    
    self.window.rootViewController = navigationController;
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.tintColor          = [UIColor customBlueColor];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: Font_Avenir(20),
                                                           NSForegroundColorAttributeName: [UIColor customGrayColor]}];
    
    return YES;
}

@end

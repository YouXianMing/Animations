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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AnimationsListViewController *animationsListViewController = [AnimationsListViewController new];
    UINavigationController       *navigationController         = \
        [[CustomNavigationController alloc] initWithRootViewController:animationsListViewController];
    
    self.window.rootViewController = navigationController;
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.tintColor          = [UIColor customBlueColor];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: Font_Avenir(20),
                                                           NSForegroundColorAttributeName: [UIColor customGrayColor]}];
    
    return YES;
}

@end

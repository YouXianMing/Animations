//
//  CustomNavigationController.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@property (nonatomic, strong) NSMapTable <NSString *, UIView *> *viewsWeakMap;

@end

@implementation CustomNavigationController

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.viewsWeakMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return self;
}

- (instancetype)initWithRootViewController:(CustomViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden {

    CustomNavigationController *ncController = [[[self class] alloc] initWithRootViewController:rootViewController];
    [ncController setNavigationBarHidden:hidden animated:NO];
    [rootViewController useInteractivePopGestureRecognizer];
    
    return ncController;
}

#pragma mark - AccessViewTagProtocol

- (void)setView:(UIView *)view withTag:(NSInteger)tag {
    
    [_viewsWeakMap setObject:view forKey:@(tag).stringValue];
}

- (id)viewWithTag:(NSInteger)tag {
    
    return [_viewsWeakMap objectForKey:@(tag).stringValue];
}

@end

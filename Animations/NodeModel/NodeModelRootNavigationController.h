//
//  NodeModelRootNavigationController.h
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeModelViewController.h"
#import "NodeModel.h"

@interface NodeModelRootNavigationController : UINavigationController

/**
 *  初始化
 *
 *  @param rootViewController NodeModelViewController控制器
 *  @param rootNodeModel      根节点
 *
 *  @return 导航栏控制器
 */
- (instancetype)initWithRootViewController:(NodeModelViewController *)rootViewController
                             rootNodeModel:(NodeModel *)rootNodeModel;

@end

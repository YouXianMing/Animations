//
//  GridItemModel.h
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridItemModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)gridItemModelWithTitle:(NSString *)title icon:(NSString *)icon;

@end

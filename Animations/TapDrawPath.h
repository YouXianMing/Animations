//
//  TapDrawPath.h
//  TapDrawImageView
//
//  Created by YouXianMing on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TapDrawPath : NSObject

@property (nonatomic, strong)  UIBezierPath  *path;
@property (nonatomic, strong)  UIColor       *fillColor;
@property (nonatomic, strong)  UIColor       *strokeColor;
@property (nonatomic)          CGFloat        lineWidth;

@end

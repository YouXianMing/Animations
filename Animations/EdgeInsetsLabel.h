//
//  EdgeInsetsLabel.h
//  TechCode
//
//  Created by YouXianMing on 16/5/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdgeInsetsLabel : UILabel

@property(nonatomic, assign) UIEdgeInsets edgeInsets;

- (void)sizeToFitWithText:(NSString *)text;

@end

//
//  CutOutClearView.h
//  Animations
//
//  Created by YouXianMing on 16/7/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutOutClearView : UIView

/**
 *  The total fill color, you can used it as the view's background color.
 */
@property (nonatomic, strong) UIColor  *fillColor;

/**
 *  The paths area color.
 */
@property (nonatomic, strong) UIColor  *areaColor;

/**
 *  Path array.
 */
@property (nonatomic, strong) NSArray  <UIBezierPath *>  *paths;

@end

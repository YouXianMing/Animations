//
//  CAShapeLayerConfigure.h
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayerConfigure : NSObject

/**
 *  Stroke width
 */
@property (nonatomic) CGFloat           lineWidth;

/**
 *  Stroke color
 */
@property (nonatomic, strong) UIColor  *strokeColor;

/**
 *  Fill color
 */
@property (nonatomic, strong) UIColor  *fillColor;

/**
 *  Config the CAShapeLayer
 *
 *  @param shapeLayer CAShapeLayer
 */
- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer;

@end

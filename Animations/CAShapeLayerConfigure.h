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

@property (nonatomic) CGFloat           lineWith;
@property (nonatomic, strong) UIColor  *strokeColor;
@property (nonatomic, strong) UIColor  *fillColor;

/**
 *  对CALayer进行配置
 *
 *  @param shapeLayer 被配置的CAShapeLayer
 */
- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer;

@end

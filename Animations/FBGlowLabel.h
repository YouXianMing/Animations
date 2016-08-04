//
//  FBGlowLabel.h
//
//  Created by YouXianMing on 16/8/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//
//  https://github.com/lyokato/fbglowlabel
//

#import <UIKit/UIKit.h>

@interface FBGlowLabel : UILabel

/**
 *  Glow size, default is 0.f.
 */
@property (nonatomic) CGFloat glowSize;

/**
 *  Glow color, default is clear color.
 */
@property (nonatomic, strong) UIColor *glowColor;

/**
 *  Inner glow size, default is 0.f.
 */
@property (nonatomic) CGFloat innerGlowSize;

/**
 *  Inner glow color, default is clear color.
 */
@property (nonatomic, strong) UIColor *innerGlowColor;

@end


//
//  CutOutMaskView.h
//  Animations
//
//  Created by YouXianMing on 16/7/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutOutMaskView : UIView

@property (nonatomic, retain) UIColor             *fillColor;
@property (nonatomic, retain) NSArray <NSValue *> *framesToCutOut;

- (void)makeEffective;

@end

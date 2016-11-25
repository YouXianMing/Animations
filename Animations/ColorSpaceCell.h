//
//  ColorSpaceCell.h
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"

// backgroundColor, lineColor, leftGap, rightGap

@interface ColorSpaceCell : CustomCell

+ (NSDictionary *)backgroundColor:(UIColor *)backgroundColor lineColor:(UIColor *)lineColor leftGap:(NSNumber *)leftGap rightGap:(NSNumber *)rightGap;

@end

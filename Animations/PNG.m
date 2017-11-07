//
//  PNG.m
//  PNGIconsCompressTool
//
//  Created by YouXianMing on 2017/11/7.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "PNG.h"

@implementation PNG

+ (PNG *)_1x {
    
    PNG *png     = [PNG new];
    png.multiply = 1;
    
    return png;
}

+ (PNG *)_2x {
    
    PNG *png     = [PNG new];
    png.multiply = 2;
    
    return png;
}

+ (PNG *)_3x {
    
    PNG *png     = [PNG new];
    png.multiply = 3;
    
    return png;
}

- (PNG *)pt:(CGFloat)pt name:(NSString *)name {
    
    self.fileName = name;
    self.basePt   = pt;
    return self;
}

@end


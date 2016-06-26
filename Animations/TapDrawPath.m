//
//  TapDrawPath.m
//  TapDrawImageView
//
//  Created by YouXianMing on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TapDrawPath.h"

@implementation TapDrawPath

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.fillColor   = [UIColor whiteColor];
        self.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
        self.lineWidth   = 0.5f;
    }
    
    return self;
}

@end

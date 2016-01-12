//
//  WxHxD.m
//  ZiPeiYi
//
//  Created by YouXianMing on 15/12/9.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "WxHxD.h"

static EiPhoneType _phone;
static CGFloat     _width;
static CGFloat     _height;

@implementation WxHxD

+ (void)setup {

    _width  = [UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
    
    if (_width == 320.f && _height == 480.f) {
        
        _phone = iPhone4_4s;
        
    } else if (_width == 320.f && _height == 568.f) {
    
        _phone = iPhone5_5s;
        
    } else if (_width == 375.f && _height == 667.f) {
        
        _phone = iPhone6;
        
    } else if (_width == 414.f && _height == 736.f) {
        
        _phone = iPhone6_plus;
        
    } else {
    
        _phone = unKnow;
    }
}

+ (EiPhoneType)iPhoneType {

    return _phone;
}

+ (CGFloat)width {

    return _width;
}

+ (CGFloat)height {

    return _height;
}

@end

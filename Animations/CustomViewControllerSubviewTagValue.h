//
//  CustomViewControllerSubviewTagValue.h
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#ifndef CustomViewControllerSubviewTagValue_h
#define CustomViewControllerSubviewTagValue_h

//  level            view             tag            Interaction
//  ----------------------------------------------------------------------
//
//  highest          windowView       kWindowView      NO
//
//  higher           loadingView      kLoadingView     NO
//
//  high             titleView        kTitleView       YES
//
//  high             contentView      kContentView     YES
//
//  normal           backgroundView   kContentView     YES
//
//  low              view             -                YES

typedef enum : NSUInteger {
    
    kWindowView = 1000,
    kLoadingView      ,
    
    kTitleView        ,
    kContentView      ,
    kBackgroundView   ,
    
} EViewControllerSubViewTag;

#endif /* CustomViewControllerSubviewTagValue_h */


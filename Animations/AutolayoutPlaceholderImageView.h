//
//  AutolayoutPlaceholderImageView.h
//  TechcodeEn_iPad
//
//  Created by YouXianMing on 2017/10/26.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutolayoutPlaceholderImageView : UIView

/**
 *  Picture's url string.
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  The placeholder's image.
 */
@property (nonatomic, strong) UIImage  *placeholderImage;

/**
 *  Default is UIViewContentModeScaleAspectFill.
 */
@property (nonatomic) UIViewContentMode placeholderImageContentMode;

/**
 *  Default is UIViewContentModeScaleAspectFill.
 */
@property (nonatomic) UIViewContentMode contentImageContentMode;

@end

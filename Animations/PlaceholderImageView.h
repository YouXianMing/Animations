//
//  PlaceholderImageView.h
//  SDWebImageViewPlaceHorder
//
//  Created by YouXianMing on 16/8/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderImageView : UIView

/**
 *  Picture's url string.
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  The placeholder's image.
 */
@property (nonatomic, strong) UIImage  *placeholderImage;

/**
 *  The normal image, if you use this, the placeholderImage & urlString will lose efficacy.
 */
@property (nonatomic, strong) UIImage  *normalImage;

/**
 *  Default is UIViewContentModeScaleAspectFill.
 */
@property (nonatomic) UIViewContentMode placeholderImageContentMode;

/**
 *  Default is UIViewContentModeScaleAspectFill.
 */
@property (nonatomic) UIViewContentMode contentImageContentMode;

@end

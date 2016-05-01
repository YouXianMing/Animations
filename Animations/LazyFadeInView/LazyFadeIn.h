//
//  LazyFadeIn.h
//  LazyFadeInView
//
//  Created by Tu You on 14-4-21.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LazyFadeIn <NSObject>

//! @abstract The number of layers lazy loading. Defaults to 6.
@property (assign, nonatomic, readwrite) NSUInteger numberOfLayers;

//! @abstract The interval of layers fading. Defaults to 0.03
@property (assign, nonatomic, readwrite) CFTimeInterval interval;

//! @abstract The font of text. Defaults to [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]
@property (strong, nonatomic, readwrite) UIFont *textFont;

//! @abstract The color of text. Defaults to white color
@property (strong, nonatomic, readwrite) UIColor *textColor;

//! @abstract Text. Defaults to nil
@property (strong, nonatomic, readwrite) NSString *text;

//! @abstract The attributes of text. Defaults to nil.
@property (strong, nonatomic, readwrite) NSDictionary *attributes;

@end


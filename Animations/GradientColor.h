//
//  GradientColor.h
//  CGContextObject
//
//  Created by YouXianMing on 15/11/12.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GradientColor : NSObject

/**
 *  An opaque type that represents a Quartz gradient.
 */
@property (nonatomic, readonly) CGGradientRef   gradientRef;

/**
 *  The location for each color provided in components. Each location must be a CGFloat value in the range of 0 to 1, inclusive. If 0 and 1 are not in the locations array, Quartz uses the colors provided that are closest to 0 and 1 for those locations.
 If locations is NULL, the first color in colors is assigned to location 0, the last color incolors is assigned to location 1, and intervening colors are assigned locations that are at equal intervals in between.
 */
@property (nonatomic) CGFloat  *locations;

/**
 *  The color components for each color that defines the gradient. The components should be in the color space specified by space. If you are unsure of the number of components, you can call the function CGColorSpaceGetNumberOfComponents.
 The number of items in this array should be the product of count and the number of components in the color space. For example, if the color space is an RGBA color space and you want to use two colors in the gradient (one for a starting location and another for an ending location), then you need to provide 8 values in components—red, green, blue, and alpha values for the first color, followed by red, green, blue, and alpha values for the second color.
 */
@property (nonatomic) CGFloat  *components;

/**
 *  The number of locations provided in the locations parameters.
 */
@property (nonatomic) size_t    count;

/**
 *  Create GradientColor
 *
 *  @param locations  The location for each color provided in components.
 *  @param components The color components for each color that defines the gradient.
 *  @param count      The number of locations provided in the locations parameters.
 *
 *  @return GradientColor object
 */
+ (instancetype)gradientColorWithLocations:(CGFloat[])locations components:(CGFloat[])components count:(size_t)count;

@end

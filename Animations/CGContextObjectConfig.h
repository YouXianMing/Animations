//
//  CGContextObjectConfig.h
//  CGContextObject
//
//  Created by YouXianMing on 15/11/12.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import "RGBColor.h"

/**
 *  Get the CGFloat's array.
 *
 *  @param count Array's count.
 *
 *  @return CGFloat's array.
 */
NS_INLINE CGFloat * CGFloatArrayWithCount(NSUInteger count) {
    
    return (CGFloat *)malloc(count * sizeof(CGFloat));
}

@interface CGContextObjectConfig : NSObject

/**
 *  Styles for rendering the endpoint of a stroked line.
 */
@property (nonatomic)          CGLineCap      lineCap;

/**
 *  Junction types for stroked lines.
 */
@property (nonatomic)          CGLineJoin     lineJoin;

/**
 *  Line width
 */
@property (nonatomic)          CGFloat        lineWidth;

#pragma mark - stroke & fill color

/**
 *  Line color
 */
@property (nonatomic, strong)  RGBColor      *strokeColor;

/**
 *  Sroke color
 */
@property (nonatomic, strong)  RGBColor      *fillColor;

#pragma mark - line dash pattern

/**
 *  Line dash pattern [Example]
 *
 *  - one type -
 *
 *  CGFloat lengths[] = {10, 10};
 *
 *  self.lengths      = lengths;
 *  self.phase        = 0;
 *  self.count        = 2;
 *
 *  - default -
 *
 *  self.lengths      = nil;
 *  self.phase        = 0;
 *  self.count        = 0;
 */

/**
 *  A value that specifies how far into the dash pattern the line starts, in units of the user space. For example, passing a value of 3 means the line is drawn with the dash pattern starting at three units from its beginning. Passing a value of 0 draws a line starting with the beginning of a dash pattern.
 */
@property (nonatomic) CGFloat   phase;

/**
 *  An array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the dash pattern—or NULL for no dash pattern.
 */
@property (nonatomic) CGFloat  *lengths;

/**
 *  If the lengths parameter specifies an array, pass the number of elements in the array. Otherwise, pass 0.
 */
@property (nonatomic) size_t    count;

@end

//
//  ShowTextModel.h
//  Animations
//
//  Created by YouXianMing on 16/4/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowTextModel : NSObject

@property (nonatomic, strong)   NSString   *inputString;
@property (nonatomic, readonly) CGFloat     expendStringHeight;
@property (nonatomic, readonly) CGFloat     normalStringHeight;

/**
 *  Calculate the expendStringHeight height.
 */
- (void)calculateTheExpendStringHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width;

/**
 *  Calculate the normal height.
 */
- (void)calculateTheNormalStringHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width;

@end

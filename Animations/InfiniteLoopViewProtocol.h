//
//  InfiniteLoopViewProtocol.h
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol InfiniteLoopViewProtocol <NSObject>

@required

/**
 *  Get the data object.
 *
 *  @return The data object.
 */
- (id)dataObject;

/**
 *  Get the Image url string.
 *
 *  @return Image url string.
 */
- (NSString *)imageUrlString;

@end

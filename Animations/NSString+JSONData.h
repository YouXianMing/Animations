//
//  NSString+JSONData.h
//  Networking
//
//  Created by YouXianMing on 15/5/21.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONData)

/**
 *  将JSON字符串转换为列表格式(字典或者数组)
 *
 *  @return 字典或者数组
 */
- (id)toListProperty;

@end

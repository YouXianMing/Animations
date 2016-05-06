//
//  InfiniteLoopModel.h
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfiniteLoopViewProtocol.h"

@interface InfiniteLoopModel : NSObject <InfiniteLoopViewProtocol>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;

+ (instancetype)infiniteLoopModelWithImageUrl:(NSString *)url
                                        title:(NSString *)title;

@end

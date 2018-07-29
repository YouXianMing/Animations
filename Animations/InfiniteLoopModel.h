//
//  InfiniteLoopModel.h
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfiniteLoopViewProtocol.h"
#import "InfiniteLoopCellClassProtocol.h"

@interface InfiniteLoopModel : NSObject <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol>

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;

+ (instancetype)infiniteLoopModelWithImageUrl:(NSString *)url
                                        title:(NSString *)title;

@property (nonatomic, strong) NSString *infiniteLoopCellReuseIdentifier;
@property (nonatomic)         Class     infiniteLoopCellClass;

@end

//
//  ImageModel.h
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfiniteLoopViewProtocol.h"

@interface ImageModel : NSObject <InfiniteLoopViewProtocol>

@property (nonatomic, strong) NSString *imageUrl;

+ (instancetype)imageModelWithImageUrl:(NSString *)url;

@end

//
//  InfiniteLoopModel.m
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "InfiniteLoopModel.h"

@implementation InfiniteLoopModel

+ (instancetype)infiniteLoopModelWithImageUrl:(NSString *)url
                                        title:(NSString *)title {

    InfiniteLoopModel *model = [[[self class] alloc] init];
    model.imageUrl           = url;
    model.title              = title;
    
    return model;
}

#pragma mark - InfiniteLoopViewProtocol's method.

- (id)dataObject {
    
    return self;
}

- (NSString *)imageUrlString {
    
    return _imageUrl;
}

#pragma mark - InfiniteLoopCellClassProtocol's method.

- (NSString *)cellReuseIdentifier {
    
    return _infiniteLoopCellReuseIdentifier;
}

- (Class)cellClass {
    
    return _infiniteLoopCellClass;
}

@end

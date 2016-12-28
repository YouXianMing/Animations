//
//  LoopViewCell.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoopViewCell.h"
#import "InfiniteLoopView.h"
#import "UIView+SetRect.h"
#import "PlaceholderImageView.h"
#import "UIImageView+WebCache.h"

@interface LoopViewCell ()

@property (nonatomic, strong) PlaceholderImageView *imageView;

@end

@implementation LoopViewCell

- (void)setupCollectionViewCell {
    
    self.layer.masksToBounds = YES;
}

- (void)buildSubView {
    
    self.imageView                     = [[PlaceholderImageView alloc] initWithFrame:self.bounds];
    self.imageView.placeholderImage    = [UIImage imageNamed:@"详情默认图"];
    [self addSubview:self.imageView];
}

- (void)loadContent {
        
    self.imageView.urlString = [self.dataModel imageUrlString];
}

@end

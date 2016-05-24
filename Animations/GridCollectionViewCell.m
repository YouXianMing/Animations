//
//  GridCollectionViewCell.m
//  UICollectionView
//
//  Created by YouXianMing on 16/5/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GridCollectionViewCell.h"

@implementation GridCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        [self setupCell];
        [self buildSubViews];
    }
    
    return self;
}

- (void)setupCell {

}

- (void)buildSubViews {

}

- (void)loadContent {

}

- (CGFloat)width {

    return self.contentView.frame.size.width;
}

- (CGFloat)height {

    return self.contentView.frame.size.height;
}

@end

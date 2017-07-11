//
//  HorizontalCollectionItemView.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/10.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCollectionView.h"

@interface HorizontalCollectionItemView : CustomCollectionView

/**
 Item's space, default is 0.
 */
@property (nonatomic) CGFloat itemSpace;

/**
 Content's edge, default is 
 */
@property (nonatomic) UIEdgeInsets contentEdge;

@end

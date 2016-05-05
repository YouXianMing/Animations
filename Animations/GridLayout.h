//
//  GridLayout.h
//  GridFlowLayoutExample
//
//  Created by YouXianMing on 16/5/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridManager.h"

@protocol GridLayoutDelegate <NSObject>

@required

- (CGFloat)itemWidthWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface GridLayout : UICollectionViewLayout

@property (nonatomic, weak)   id  <GridLayoutDelegate>  delegate;
@property (nonatomic, strong) GridManager              *manager;

@end

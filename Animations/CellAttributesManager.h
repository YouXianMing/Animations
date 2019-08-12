//
//  CellAttributesManager.h
//  AjMall
//
//  Created by YouXianMing on 2019/8/12.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionViewFlowLayout.h>

@interface CellAttributesManager : NSObject

@property (nonatomic, readonly) NSMutableArray <NSMutableArray <UICollectionViewLayoutAttributes *> *> *attributesArray;

- (void)buildAnAttributesArray;

- (void)addAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end

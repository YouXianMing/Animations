//
//  UITableView+CellClass.h
//  Animations
//
//  Created by YouXianMing on 16/6/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomCell;
@class CellDataAdapter;

@interface CellClassType : NSObject

@property (nonatomic, strong) NSString *classString;
@property (nonatomic, strong) NSString *reuseIdentifier;

/**
 *  Create a object that contain the classString and the reuseIdentifier.
 *
 *  @param classString     Class string.
 *  @param reuseIdentifier Cell reuseIdentifier
 *
 *  @return CellClassType Object.
 */
+ (instancetype)cellClassTypeWithClassString:(NSString *)classString reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  The classString is the same with the reuseIdentifier.
 *
 *  @param classString Class string.
 *
 *  @return CellClassType Object.
 */
+ (instancetype)cellClassTypeWithClassString:(NSString *)classString;

@end

NS_INLINE CellClassType *cellClass(NSString *classString, NSString *reuseIdentifier) {
    
    return [CellClassType cellClassTypeWithClassString:classString reuseIdentifier:reuseIdentifier.length <= 0 ? classString : reuseIdentifier];
}

@interface UITableView (CellClass)

/**
 *  Register cells class.
 *
 *  @param cellClasses CellClassType object's array.
 */
- (void)registerCellsClass:(NSArray <CellClassType *> *)cellClasses;

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath;
- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller;

@end


// Copyright (c) 2014 Giovanni Lodi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/**
 *  Simple UICollectionViewFlowLayout that aligns the cells to the left rather than justify them
 *
 *  Based on http://stackoverflow.com/questions/13017257/how-do-you-determine-spacing-between-cells-in-uicollectionview-flowlayout
 */

typedef enum : NSUInteger {
    
    // Cells aligned use system config, default value.
    UICollectionViewAlignedType_System = 0,
    
    // Cells aligned from left to right.
    UICollectionViewAlignedType_LTR,
    
    // Cells aligned from right to left.
    UICollectionViewAlignedType_RTL,
    
} UICollectionViewAlignedType;

#import <UIKit/UIKit.h>
@class UICollectionViewAlignedLayout;

@protocol UICollectionViewAlignedLayoutDelegate <NSObject>

@optional

/// 设定指定的section中cell的排列方式(实现了此代理方法后,属性alignedType的设定会失效)
/// @param collectionView collectionView
/// @param collectionViewLayout UICollectionViewAlignedLayout对象
/// @param section The specified section
- (UICollectionViewAlignedType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewAlignedLayout *)collectionViewLayout alignedTypeAtSection:(NSInteger)section;

@end

@interface UICollectionViewAlignedLayout : UICollectionViewFlowLayout

/// 设定cells的排列方向(如果实现了代理方法中的 'collectionView:layout:alignedTypeAtSection:', 则此属性设定无效)
@property (nonatomic) UICollectionViewAlignedType alignedType;

@property (nonatomic, weak) id <UICollectionViewAlignedLayoutDelegate> alignedLayoutDelegate;

@end

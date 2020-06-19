
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

#import "UICollectionViewAlignedLayout.h"

#pragma mark - UICollectionViewLayoutAttributes

@interface UICollectionViewLayoutAttributes (AlignedLayout)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset layoutWidth:(CGFloat)layoutWidth;
- (void)rightAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset layoutWidth:(CGFloat)layoutWidth;

@end

@implementation UICollectionViewLayoutAttributes (AlignedLayout)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset layoutWidth:(CGFloat)layoutWidth {
    
    CGRect frame   = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame     = frame;
}

- (void)rightAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset layoutWidth:(CGFloat)layoutWidth {
    
    CGRect frame   = self.frame;
    frame.origin.x = layoutWidth + sectionInset.left - frame.size.width;
    self.frame     = frame;
}

@end

@implementation UICollectionViewAlignedLayout

#pragma mark - UICollectionViewLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 获取系统计算好的 UICollectionViewLayoutAttributes 数组
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    
    // 修改后元素的数组
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
            
            // 判断是不是cell
            if (!attributes.representedElementKind) {
                
                // 获取需要处理cell的编号
                NSUInteger index = [updatedAttributes indexOfObject:attributes];
                
                // 对cell进行处理
                updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
            }
        }
    }

    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
            
    // 当前属性
    UICollectionViewLayoutAttributes *currentItemAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    // 获取当前的cells的排列方式
    UICollectionViewAlignedType alignedType = self.alignedType;
    if (self.alignedLayoutDelegate && [self.alignedLayoutDelegate respondsToSelector:@selector(collectionView:layout:alignedTypeAtSection:)]) {
        
        alignedType = [self.alignedLayoutDelegate collectionView:self.collectionView layout:self alignedTypeAtSection:indexPath.section];
    }
    
    // 如果设定了当前section不需要排列,则返回原值
    if (alignedType == UICollectionViewAlignedType_System) {
        
        return currentItemAttributes;
    }
    
    // 获取section的边距
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];

    BOOL    isFirstItemInSection = (indexPath.item == 0 ? YES : NO);
    CGFloat layoutWidth          = CGRectGetWidth(self.collectionView.frame) - (sectionInset.left + sectionInset.right);

    // 如果是当前section的第一个cell,则计算完后直接返回
    if (isFirstItemInSection) {
        
        if (alignedType == UICollectionViewAlignedType_LTR) {
            
            [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset layoutWidth:layoutWidth];
            
        } else {
        
            [currentItemAttributes rightAlignFrameWithSectionInset:sectionInset layoutWidth:layoutWidth];
        }
        
        return currentItemAttributes;
    }

    NSIndexPath *previousIndexPath       = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    CGRect       previousFrame           = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat      previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGFloat      previousFrameLeftPoint  = previousFrame.origin.x;
    
    CGRect currentFrame          = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left, currentFrame.origin.y, layoutWidth, currentFrame.size.height);
    
    // 判断上一个cell是不是处在当前行(如果不是,说明当前的cell是当前行的第一个cell)
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);

    if (isFirstItemInRow) {
        
        if (alignedType == UICollectionViewAlignedType_LTR) {

            [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset layoutWidth:layoutWidth];
            
        } else {
            
            [currentItemAttributes rightAlignFrameWithSectionInset:sectionInset layoutWidth:layoutWidth];
        }
        
        return currentItemAttributes;
    }
    
    // 更新当前cell的frame值
    CGRect frame   = currentItemAttributes.frame;
    frame.origin.x = alignedType == UICollectionViewAlignedType_LTR ?
    previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section] :
    previousFrameLeftPoint - [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section] - frame.size.width;
    currentItemAttributes.frame = frame;
    
    return currentItemAttributes;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        
        id <UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
        
    } else {
        
        return self.minimumInteritemSpacing;
    }
}

/// 根据cell的编号获取section的边距
/// @param index cell的编号
- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
    
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        
        // 如果通过代理实现了secton的边距,则使用该边距
        id <UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
        
    } else {
        
        // 没有通过代理实现section的边距,则使用collectionView设定的统一的边距
        return self.sectionInset;
    }
}

@end

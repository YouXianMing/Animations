//
//  GridManager.m
//  GridLayoutManager
//
//  Created by YouXianMing on 16/5/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GridManager.h"

@interface GridManager ()

@property (nonatomic, strong) NSMutableArray *currentRowXValues;
@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, strong) NSMutableArray *frames;

@end

@implementation GridManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.currentRowXValues = [NSMutableArray array];
        self.elements          = [NSMutableArray array];
        self.frames            = [NSMutableArray array];
    }
    
    return self;
}

- (void)reset {

    [self.currentRowXValues removeAllObjects];
    [self.elements removeAllObjects];
    [self.frames removeAllObjects];
}

- (void)prepare {

    for (int i = 0; i < self.rowHeights.count; i++) {
        
        [self.currentRowXValues addObject:@(_edgeInsets.left)];
    }
}

- (CGSize)contentSize {

    CGFloat width  = 0;
    CGFloat height = 0;
    
    for (int i = 0; i < _currentRowXValues.count; i++) {
        
        CGFloat currentX = [_currentRowXValues[i] floatValue];
        width < currentX ? width = currentX : 0;
    }
    
    width += _edgeInsets.right;
    height = [self yPositionByRow:_rowHeights.count - 1] + _rowHeights.lastObject.floatValue + _edgeInsets.bottom;
    
    return CGSizeMake(width, height);
}

- (void)addElement:(NSNumber *)width {

    [_elements addObject:width];
    
    // Get the minX & minRow.
    CGFloat   minX   = CGFLOAT_MAX;
    NSInteger minRow = 0;
    for (int row = 0; row < _currentRowXValues.count; row++) {
        
        CGFloat currentX = [_currentRowXValues[row] floatValue];
        
        if (minX > currentX) {
            
            minX   = currentX;
            minRow = row;
        }
    }
    
    // Create frame.
    CGRect frame = CGRectMake(minX == _edgeInsets.left ? minX : (minX += _gap),
                              [self yPositionByRow:minRow], width.floatValue, _rowHeights[minRow].floatValue);
    [_frames addObject:NSStringFromCGRect(frame)];
    
    // Update minX.
    [_currentRowXValues replaceObjectAtIndex:minRow withObject:@(minX + width.floatValue)];
}

- (CGFloat)yPositionByRow:(NSInteger)row {
    
    CGFloat y = 0;
    
    for (int i = 0; i < row + 1; i++) {
        
        if (i == 0) {
            
            y += _edgeInsets.top;
            continue;
        }
        
        y += [_rowHeights[i - 1] floatValue] + _gap;
    }
    
    return y;
}

- (NSArray *)allElements {

    return _elements;
}

- (CGRect)frameByIndex:(NSInteger)index {

    return CGRectFromString(_frames[index]);
}

- (NSArray *)allFrames {

    return _frames;
}

@end

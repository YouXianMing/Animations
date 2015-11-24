//
//  YXEasing.m
//  Prize
//
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "YXEasing.h"

@implementation YXEasing

+ (NSArray *)calculateFrameFromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount {
    
    // 设置帧数量
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frameCount];
    
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (frameCount - 1);
	for(size_t frame = 0; frame < frameCount; ++frame, t += dt) {
        
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat value = fromValue + func(t) * (toValue - fromValue);
        
        // 将计算结果存储进数组中
		[values addObject:[NSNumber numberWithFloat:(float)value]];
	}
    
    // 数组中存储的数据为 NSNumber float 型
    return values;
}

+ (NSArray *)calculateFrameFromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount {
    
    // 设置帧数量
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frameCount];
	
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (frameCount - 1);
	for(size_t frame = 0; frame < frameCount; ++frame, t += dt) {
        
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat x = fromPoint.x + func(t) * (toPoint.x - fromPoint.x);
		CGFloat y = fromPoint.y + func(t) * (toPoint.y - fromPoint.y);
        
        // 将计算结果存储进数组中
		[values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
	}
    
    // 数组中存储的数据为 NSValue CGPoint 型
    return values;
}

+ (NSArray *)calculateFrameFromSize:(CGSize)fromSize
                             toSize:(CGSize)toSize
                               func:(AHEasingFunction)func
                         frameCount:(size_t)frameCount {
    
    // 设置帧数量
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:frameCount];
	
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (frameCount - 1);
	for(size_t frame = 0; frame < frameCount; ++frame, t += dt) {
        
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat w = fromSize.width + func(t) * (toSize.width - fromSize.width);
		CGFloat h = fromSize.height + func(t) * (toSize.height - fromSize.height);

        // 将计算结果存储进数组中
		[values addObject:[NSValue valueWithCGSize:CGSizeMake(w, h)]];
    }
    
    // 数组中存储的数据为 NSValue CGSize 型
    return values;
}

@end

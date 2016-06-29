//
//  TranformFadeView.m
//  TransformationFadeView
//
//  Created by XianMingYou on 15/4/16.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "TranformFadeView.h"

typedef enum : NSUInteger {
    
    kSubViewTag = 0x1000,
    
} ETranformFadeViewValue;

@interface TranformFadeView ()

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView    *imageView;

/**
 *  所有的maskView
 */
@property (nonatomic, strong) UIView         *allMaskView;

/**
 *  maskView的个数
 */
@property (nonatomic)         NSInteger       maskViewCount;

/**
 *  存储maskView的编号
 */
@property (nonatomic, strong) NSMutableArray *countArray;

@end

@implementation TranformFadeView

/**
 *  初始化并添加图片
 *
 *  @param frame frame值
 */
- (void)initImageViewWithFrame:(CGRect)frame {
    
    self.imageView                     = [[UIImageView alloc] initWithFrame:frame];
    self.imageView.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initImageViewWithFrame:self.bounds];
    }
    
    return self;
}

- (void)buildMaskView {
    
    // 如果没有,就返回空
    if (self.horizontalCount < 1 || self.verticalCount < 1) {
        
        return;
    }
    
    // 承载所有的maskView
    self.allMaskView = [[UIView alloc] initWithFrame:self.bounds];
    self.maskView    = self.allMaskView;
    
    // 计算出每个view的尺寸
    CGFloat height         = self.frame.size.height;
    CGFloat width          = self.frame.size.width;
    CGFloat maskViewHeight = self.verticalCount   <= 1 ? height : (height / self.verticalCount);
    CGFloat maskViewWidth  = self.horizontalCount <= 1 ? width  : (width  / self.horizontalCount);
    
    // 用以计数
    int count = 0;
    
    // 先水平循环,再垂直循环
    for (int horizontal = 0; horizontal < self.horizontalCount; horizontal++) {
        
        for (int vertical = 0; vertical < self.verticalCount; vertical++) {
        
            CGRect frame = CGRectMake(maskViewWidth  * horizontal,
                                      maskViewHeight * vertical,
                                      maskViewWidth,
                                      maskViewHeight);
            
            UIView *maskView         = [[UIView alloc] initWithFrame:frame];
            maskView.frame           = frame;
            maskView.tag             = kSubViewTag + count;
            maskView.backgroundColor = [UIColor blackColor];
            
            [self.allMaskView addSubview:maskView];
            
            count++;
        }
    }
    
    self.maskViewCount = count;
    
    // 存储
    self.countArray  = [NSMutableArray array];
    for (int i = 0; i < self.maskViewCount; i++) {
        
        [self.countArray addObject:@(i)];
    }
}

/**
 *  策略模式一
 *
 *  @param inputNumber 输入
 *
 *  @return 输出
 */
- (NSInteger)strategyNormal:(NSInteger)inputNumber {
    
    NSNumber *number = self.countArray[inputNumber];
    return number.integerValue;
}

- (void)fadeAnimated:(BOOL)animated {
    
    if (animated == YES) {
        
        for (int i = 0; i < self.maskViewCount; i++) {
            
            UIView *tmpView = [self maskViewWithTag:[self strategyNormal:i]];
            [UIView animateWithDuration:(self.fadeDuradtion <= 0.f ? 1.f : self.fadeDuradtion)
                                  delay:i * (self.animationGapDuration <= 0.f ? 0.2f : self.animationGapDuration)
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 tmpView.alpha = 0.f;
                                 
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
        
    } else {
        
        for (int i = 0; i < self.maskViewCount; i++) {
            
            UIView *tmpView = [self maskViewWithTag:i];
            tmpView.alpha   = 0.f;
        }
    }
}

- (void)showAnimated:(BOOL)animated {
    
    if (animated == YES) {
        
        for (int i = 0; i < self.maskViewCount; i++) {
            
            UIView *tmpView = [self maskViewWithTag:[self strategyNormal:i]];
            
            [UIView animateWithDuration:(self.fadeDuradtion <= 0.f ? 1.f : self.fadeDuradtion)
                                  delay:i * (self.animationGapDuration <= 0.f ? 0.2f : self.animationGapDuration)
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 tmpView.alpha = 1.f;
                                 
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
        
    } else {
        
        for (int i = 0; i < self.maskViewCount; i++) {
            
            UIView *tmpView = [self maskViewWithTag:i];
            tmpView.alpha   = 1.f;
        }
    }
}

/**
 *  根据tag值获取maskView
 *
 *  @param tag maskView的tag值
 *
 *  @return tag值对应的maskView
 */
- (UIView *)maskViewWithTag:(NSInteger)tag {
    
    return [self.maskView viewWithTag:tag + kSubViewTag];
}

#pragma mark - setter & getter.

@synthesize contentMode = _contentMode;

- (void)setContentMode:(UIViewContentMode)contentMode {
    
    _contentMode               = contentMode;
    self.imageView.contentMode = contentMode;
}

- (UIViewContentMode)contentMode {
    
    return _contentMode;
}

@synthesize image = _image;

- (void)setImage:(UIImage *)image {
    
    _image               = image;
    self.imageView.image = image;
}

- (UIImage *)image {
    
    return _image;
}

@end

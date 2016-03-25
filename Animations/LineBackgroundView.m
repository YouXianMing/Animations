//
//  LineBackgroundView.m
//  LineBackgroundView
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LineBackgroundView.h"

// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

@interface LineBackgroundView ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation LineBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)buildView {
    
    if (self.lineGap <= 0 && self.lineWidth <= 0) {
        
        return;
    }
    
    // 获取长度
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat containerViewWidth = (width + height) * 0.75;
    
    // 初始化containView
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  containerViewWidth,
                                                                  containerViewWidth)];
    self.containerView.layer.borderWidth = 1.f;
    self.containerView.center            = CGPointMake(self.bounds.size.width / 2.f,
                                                       self.bounds.size.height / 2.f);
    
    NSInteger lineViewCount = containerViewWidth / (self.lineGap + self.lineWidth);
    for (int count = 0; count < lineViewCount + 1; count++) {
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(count * (self.lineGap + self.lineWidth),
                                                                    0,
                                                                    self.lineWidth,
                                                                    containerViewWidth)];
        
        if (self.lineColor) {
            
            tempView.backgroundColor = self.lineColor;
            
        } else {
            
            tempView.backgroundColor = [UIColor blackColor];
            
        }

        [self.containerView addSubview:tempView];
    }
    
    self.containerView.transform = CGAffineTransformRotate(self.containerView.transform, RADIAN(45));
    [self addSubview:self.containerView];
}

+ (instancetype)createViewWithFrame:(CGRect)frame
                          lineWidth:(CGFloat)width
                            lineGap:(CGFloat)lineGap
                          lineColor:(UIColor *)color {
    
    LineBackgroundView *bgView = [[LineBackgroundView alloc] initWithFrame:frame];
    bgView.lineWidth           = width;
    bgView.lineGap             = lineGap;
    bgView.lineColor           = color;
    [bgView buildView];

    return bgView;
}

@end

//
//  InfiniteLoopViewBuilder.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "InfiniteLoopViewBuilder.h"
#import "InfiniteLoopView.h"

@interface InfiniteLoopViewBuilder () <InfiniteLoopViewDelegate>

@property (nonatomic, strong) InfiniteLoopView *loopView;
@property (nonatomic, strong) UIView           *nodeViewsContentView;
@property (nonatomic, strong) UIView           *contentView;

@end

@implementation InfiniteLoopViewBuilder

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // Set the default values.
        self.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
        self.scrollTimeInterval = 4.f;
        self.position           = kNodeViewBottom;
        self.sampleNodeViewSize = CGSizeMake(10, 10);
        
        // Init loopView.
        self.loopView          = [[InfiniteLoopView alloc] initWithFrame:self.bounds];
        self.loopView.delegate = self;
        [self addSubview:self.loopView];
        
        // Init contentView.
        self.contentView                        = [[UIView alloc] initWithFrame:self.bounds];
        self.contentView.userInteractionEnabled = NO;
        [self addSubview:self.contentView];
        
        // Init nodeViewsContentView.
        self.nodeViewsContentView                        = [[UIView alloc] init];
        self.nodeViewsContentView.alpha                  = 0.f;
        self.nodeViewsContentView.userInteractionEnabled = NO;
        [self addSubview:self.nodeViewsContentView];
    }
    
    return self;
}

- (void)infiniteLoopView:(InfiniteLoopView *)infiniteLoopView
                    data:(id <InfiniteLoopViewProtocol>)data
           selectedIndex:(NSInteger)index
                    cell:(CustomInfiniteLoopCell *)cell {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopViewBuilder:data:selectedIndex:cell:)]) {
        
        [self.delegate infiniteLoopViewBuilder:self data:data selectedIndex:index cell:cell];
    }
}

- (void)infiniteLoopView:(InfiniteLoopView *)infiniteLoopView didScrollCurrentPage:(NSInteger)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopViewBuilder:didScrollCurrentPage:)]) {
        
        [self.delegate infiniteLoopViewBuilder:self didScrollCurrentPage:index];
    }
    
    [self.nodeViewsContentView.subviews enumerateObjectsUsingBlock:^(__kindof CustomNodeStateView * _Nonnull obj,
                                                                     NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (index == idx) {
            
            [obj changeToState:kInfiniteLoopHighlightedState animated:YES];
            
        } else {
            
            [obj changeToState:kInfiniteLoopNormalState animated:YES];
        }
    }];
}

- (void)startLoopAnimated:(BOOL)animated {
    
    if (self.nodeViewTemplate == nil) {

        [NSException raise:@"InfiniteLoopViewBuilder error"
                    format:@"You must set the property nodeViewTemplate."];
    }
    
    [self.loopView reset];
    self.loopView.models             = self.models;
    self.loopView.scrollDirection    = self.scrollDirection;
    self.loopView.scrollTimeInterval = self.scrollTimeInterval;
    [self.loopView prepare];
    animated == YES ? [self.loopView startLoopAnimation] : 0;
    
    [self managerNodeViewsContentView];
}

- (void)managerNodeViewsContentView {
    
    // Remove all subViews.
    [self.nodeViewsContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    if (self.models.count) {
        
        // NodeViewsContentView add subView.
        CGFloat width                   = self.sampleNodeViewSize.width;
        CGFloat height                  = self.sampleNodeViewSize.height;
        self.nodeViewsContentView.alpha = 1.f;
        
        if (self.position == kNodeViewBottom || self.position == kNodeViewBottomLeft || self.position == kNodeViewBottomRight ||
            self.position == kNodeViewTop    || self.position == kNodeViewTopLeft    || self.position == kNodeViewTopRight) {
        
            self.nodeViewsContentView.frame = CGRectMake(0, 0, width * self.models.count, height);
            
            self.position == kNodeViewBottom ?
            self.nodeViewsContentView.centerX = self.middleX,
            self.nodeViewsContentView.bottom  = self.height - self.edgeInsets.bottom : 0;
            
            self.position == kNodeViewBottomLeft ?
            self.nodeViewsContentView.x      = self.edgeInsets.left,
            self.nodeViewsContentView.bottom = self.height - self.edgeInsets.bottom : 0;
            
            self.position == kNodeViewBottomRight ?
            self.nodeViewsContentView.right  = self.width - self.edgeInsets.right,
            self.nodeViewsContentView.bottom = self.height - self.edgeInsets.bottom : 0;
            
            self.position == kNodeViewTop ?
            self.nodeViewsContentView.centerX = self.middleX,
            self.nodeViewsContentView.top     = 0 + self.edgeInsets.top : 0;
            
            self.position == kNodeViewTopLeft ?
            self.nodeViewsContentView.x = self.edgeInsets.left,
            self.nodeViewsContentView.y = self.edgeInsets.top : 0;
            
            self.position == kNodeViewTopRight ?
            self.nodeViewsContentView.right = self.width - self.edgeInsets.right,
            self.nodeViewsContentView.y     = self.edgeInsets.top : 0;
            
            for (int i = 0; i < self.models.count; i++) {
                
                CustomNodeStateView *stateView = [[self.nodeViewTemplate.class alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
                [self.nodeViewsContentView addSubview:stateView];
                
                if (i == 0) {
                    
                    [stateView changeToState:kInfiniteLoopHighlightedState animated:NO];
                    
                } else {
                    
                    [stateView changeToState:kInfiniteLoopNormalState animated:NO];
                }
            }
            
        } else if (self.position == kNodeViewLeft  || self.position == kNodeViewLeftTop  || self.position == kNodeViewLeftBottom ||
                   self.position == kNodeViewRight || self.position == kNodeViewRightTop || self.position == kNodeViewRightBottom) {
        
            self.nodeViewsContentView.frame = CGRectMake(0, 0, width, height  * self.models.count);
            
            self.position == kNodeViewLeft ?
            self.nodeViewsContentView.centerY = self.middleY,
            self.nodeViewsContentView.x       = self.edgeInsets.left : 0;
            
            self.position == kNodeViewLeftTop ?
            self.nodeViewsContentView.y = self.edgeInsets.top,
            self.nodeViewsContentView.x = self.edgeInsets.left : 0;
            
            self.position == kNodeViewLeftBottom ?
            self.nodeViewsContentView.bottom = self.height - self.edgeInsets.bottom,
            self.nodeViewsContentView.x      = self.edgeInsets.left : 0;
            
            self.position == kNodeViewRight ?
            self.nodeViewsContentView.centerY = self.middleY,
            self.nodeViewsContentView.right   = self.width - self.edgeInsets.right : 0;
            
            self.position == kNodeViewRightTop ?
            self.nodeViewsContentView.y     = self.edgeInsets.top,
            self.nodeViewsContentView.right = self.width - self.edgeInsets.right : 0;
            
            self.position == kNodeViewRightBottom ?
            self.nodeViewsContentView.bottom = self.height - self.edgeInsets.bottom,
            self.nodeViewsContentView.right  = self.width - self.edgeInsets.right : 0;
            
            for (int i = 0; i < self.models.count; i++) {
                
                CustomNodeStateView *stateView = [[self.nodeViewTemplate.class alloc] initWithFrame:CGRectMake(0, i * height, width, height)];
                [self.nodeViewsContentView addSubview:stateView];
                
                if (i == 0) {
                    
                    [stateView changeToState:kInfiniteLoopHighlightedState animated:NO];
                    
                } else {
                    
                    [stateView changeToState:kInfiniteLoopNormalState animated:NO];
                }
            }
        }
        
    } else {
        
        self.nodeViewsContentView.alpha = 0.f;
    }
}

@end

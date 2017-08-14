//
//  InfiniteLoopViewController.m
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "InfiniteLoopViewController.h"
#import "InfiniteLoopViewBuilder.h"
#import "LoopViewCell.h"
#import "LoopTypeTwoCell.h"
#import "NodeStateView.h"
#import "ImageModel.h"
#import "CircleNodeStateView.h"
#import "InfiniteLoopModel.h"

@interface InfiniteLoopViewController () <InfiniteLoopViewBuilderEventDelegate>

@end

@implementation InfiniteLoopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    {
        NSArray *strings = @[@"http://img.wdjimg.com/image/video/d999011124c9ed55c2dd74e0ccee36ea_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2ddcad6dcc38c5ca88614b7c5543199a_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/6d6ccfd79ee1deac2585150f40915c09_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2111a863ea34825012b0c5c9dec71843_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/b4085a983cedd8a8b1e83ba2bd8ecdd8_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2d59165e816151350a2b683b656a270a_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/dc2009ee59998039f795fbc7ac2f831f_0_0.jpeg"];
        
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < strings.count; i++) {
            
            ImageModel *model                     = [ImageModel imageModelWithImageUrl:strings[i]];
            
            // Setup model.
            model.infiniteLoopCellClass           = [LoopViewCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
            //model.infiniteLoopCellReuseIdentifier = @"LoopViewCell";
            [models addObject:model];
        }
        
        InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 4.f)];
        loopView.nodeViewTemplate         = [CircleNodeStateView new];
        loopView.delegate                 = self;
        loopView.sampleNodeViewSize       = CGSizeMake(8, 6);
        loopView.position                 = kNodeViewBottomRight;
        loopView.edgeInsets               = UIEdgeInsetsMake(0, 0, 7, 5);
        loopView.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        //[loopView startLoopAnimated:YES];
        loopView.autoScroll = YES;
        loopView.autoScrollDuringTimeInterval = 1.5;
        [self.contentView addSubview:loopView];
        loopView.titleGroup = @[@"你好",@"我好",@"YES I can",@"no problem",@"大家好",@"helloworld",@"Animations",@"为爱守候"];
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            loopView.frame = CGRectMake(0, 0, Width, self.contentView.height / 10.f);
        //        });
    }
    
    
    {
        
        
        InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, self.contentView.height / 4.f+20,
                                                                                                      Width, self.contentView.height / 10.f)];
        loopView.nodeViewTemplate   = [NodeStateView new];
        loopView.delegate           = self;
        loopView.scrollTimeInterval = 5.f;
        loopView.scrollDirection    = UICollectionViewScrollDirectionVertical;
        loopView.sampleNodeViewSize = CGSizeMake(8, 20);
        loopView.position           = kNodeViewRightBottom;
        loopView.edgeInsets         = UIEdgeInsetsMake(0, 0, 2, 2);
        loopView.autoScroll = YES;
        [loopView startLoopAnimated:YES];
        loopView.autoScrollDuringTimeInterval = 3;
        [self.contentView addSubview:loopView];
        
        
        
        NSArray *strings = @[@"http://img.wdjimg.com/image/video/b8ff75ba333183e0fa92efc4a52ffda0_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/d160e33391a555127be999d1d6273a17_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/b8ff75ba333183e0fa92efc4a52ffda0_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/735e73eb85a47b5f2a661aa02ad1fed2_0_0.jpeg"];
        
        NSArray *titles  = @[@"We call a custom helper",
                             @"The animation collection",
                             @"iOS design pattern",
                             @"A weather app"];
        
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < strings.count; i++) {
            
            InfiniteLoopModel *model = [InfiniteLoopModel infiniteLoopModelWithImageUrl:strings[i] title:titles[i]];
            
            // Setup model.
            model.infiniteLoopCellClass           = [LoopTypeTwoCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopTypeTwoCell_%d", i];
            
            [models addObject:model];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            loopView.models             = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            loopView.frame = CGRectMake(0, self.contentView.height / 4.f+20,
                                        Width, self.contentView.height / 4.f);
        });
    }
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell {
    
    NSLog(@"index:%ld - %@ %@", (long)index, data, cell);
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index {
    
    NSLog(@"currentPage:%ld", (long)index);
}

@end

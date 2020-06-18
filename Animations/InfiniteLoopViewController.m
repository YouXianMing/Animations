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
        NSArray *strings = @[@"https://hbimg.huabanimg.com/95c1a74073e3fd69c9e7af637632fde7027b4d6a86124-g1qYW4_fw658",
                             @"https://hbimg.huabanimg.com/41e430a58e083b5df8b29828194d4c8cf6b8080e17e35-gRW2z5_fw658",
                             @"https://hbimg.huabanimg.com/463cda475956270d6d605ebacd865a80169a57967579f-0pe50Y_fw658",
                             @"https://hbimg.huabanimg.com/fae81cd6c474e36586a2b9327eecaf9bca46fa068c812-sdLSnP_fw658",
                             @"https://hbimg.huabanimg.com/648bc2e1a6350a1d48b331168000697696cdf4b136928-dgFED1_fw658",
                             @"https://hbimg.huabanimg.com/7de62a3fa6b4c98a9128ff73071e596cf7de898226d30-uDl8i5_fw658",
                             @"https://hbimg.huabanimg.com/85359db24a13794021bc6c3f609ce640f8a248f7b868c-PhP0iD_fw658",
                             @"https://hbimg.huabanimg.com/dae0e0a17d430af8f129113d12488f73f64043481ced1-FL88bJ_fw658",];
        
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < strings.count; i++) {
            
            ImageModel *model                     = [ImageModel imageModelWithImageUrl:strings[i]];
            
            // Setup model.
            model.infiniteLoopCellClass           = [LoopViewCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
            [models addObject:model];
        }
        
        InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f)];
        loopView.nodeViewTemplate         = [CircleNodeStateView new];
        loopView.delegate                 = self;
        loopView.scrollTimeInterval       = 3.f;
        loopView.sampleNodeViewSize       = CGSizeMake(8, 6);
        loopView.position                 = kNodeViewBottomRight;
        loopView.edgeInsets               = UIEdgeInsetsMake(0, 0, 7, 5);
        loopView.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        [loopView startLoopAnimated:YES];
        [self.contentView addSubview:loopView];
        
        UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, loopView.width, 20)];
        blackView.bottom          = loopView.height;
        blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [loopView.contentView addSubview:blackView];
    }
    
    {
        NSArray *strings = @[@"https://hbimg.huabanimg.com/95c1a74073e3fd69c9e7af637632fde7027b4d6a86124-g1qYW4_fw658",
                             @"https://hbimg.huabanimg.com/41e430a58e083b5df8b29828194d4c8cf6b8080e17e35-gRW2z5_fw658",
                             @"https://hbimg.huabanimg.com/463cda475956270d6d605ebacd865a80169a57967579f-0pe50Y_fw658",
                             @"https://hbimg.huabanimg.com/fae81cd6c474e36586a2b9327eecaf9bca46fa068c812-sdLSnP_fw658",];
        
        NSArray *titles  = @[@"Black hole",
                             @"我们的征途是星辰大海",
                             @"Battle!",
                             @"Join the army"];
        
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < strings.count; i++) {
            
            InfiniteLoopModel *model = [InfiniteLoopModel infiniteLoopModelWithImageUrl:strings[i] title:titles[i]];
            
            // Setup model.
            model.infiniteLoopCellClass           = [LoopTypeTwoCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopTypeTwoCell_%d", i];

            [models addObject:model];
        }
        
        InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, self.contentView.height / 2.f,
                                                                                                      Width, self.contentView.height / 2.f)];
        loopView.nodeViewTemplate   = [NodeStateView new];
        loopView.delegate           = self;
        loopView.scrollTimeInterval = 5.f;
        loopView.scrollDirection    = UICollectionViewScrollDirectionVertical;
        loopView.sampleNodeViewSize = CGSizeMake(8, 20);
        loopView.position           = kNodeViewRightBottom;
        loopView.edgeInsets         = UIEdgeInsetsMake(0, 0, 2, 2);
        loopView.models             = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        [loopView startLoopAnimated:YES];
        [self.contentView addSubview:loopView];
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

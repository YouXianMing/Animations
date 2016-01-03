//
//  AnimationsListViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "AnimationsListViewController.h"
#import "UIColor+CustomColors.h"
#import "UIView+SetRect.h"
#import "UIView+GlowView.h"
#import "ListItemCell.h"
#import "LineBackgroundView.h"
#import "Item.h"
#import "GCD.h"

#import "ButtonPressViewController.h"
#import "PopStrokeController.h"
#import "CAShapeLayerPathController.h"
#import "TransformFadeViewController.h"
#import "PopNumberController.h"
#import "CircleAnimationViewController.h"
#import "ScrollImageViewController.h"
#import "ScrollBlurImageViewController.h"
#import "TableViewTapAnimationController.h"
#import "POPSpringParameterController.h"
#import "HeaderViewTapAnimationController.h"
#import "CountDownTimerController.h"
#import "ClockViewController.h"
#import "TableViewCellSlideAnimationController.h"
#import "DrawWaveViewController.h"
#import "LabelScaleViewController.h"
#import "ShimmerController.h"
#import "EmitterSnowController.h"
#import "ScratchImageViewController.h"
#import "LiveImageViewController.h"
#import "SDWebImageController.h"
#import "AlertViewController.h"
#import "WaterfallLayoutController.h"

@interface AnimationsListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic)         BOOL         tableViewLoadData;

@property (nonatomic, strong) NSArray     *items;

@end

@implementation AnimationsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureDataSource];
    
    [self configureTableView];
    
    [self configureTitleView];
    
    [self useInteractivePopGestureRecognizer];
}

- (void)configureTitleView {
    
    LineBackgroundView *lineBackgroundView = [LineBackgroundView createViewWithFrame:CGRectMake(0, 0, self.width, 64)
                                                                           LineWidth:4
                                                                             lineGap:4
                                                                           lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015]];
    [self.titleView addSubview:lineBackgroundView];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = Font_Avenir_Light(28);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor customGrayColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Animations"];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor customBlueColor]
                             range:NSMakeRange(1, 1)];
    
    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    
    // Title view.
    UIView *titleView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    headlinelabel.center  = titleView.middlePoint;
    [titleView addSubview:headlinelabel];
    [self.titleView addSubview:titleView];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [titleView addSubview:line];

    // Start glow.
    headlinelabel.glowRadius            = @(2.f);
    headlinelabel.glowOpacity           = @(1.f);
    headlinelabel.glowColor             = [[UIColor customRedColor] colorWithAlphaComponent:0.95f];
    
    headlinelabel.glowDuration          = @(1.f);
    headlinelabel.hideDuration          = @(3.f);
    headlinelabel.glowAnimationDuration = @(2.f);
    
    [headlinelabel createGlowLayer];
    [headlinelabel insertGlowLayer];
    
    [GCDQueue executeInMainQueue:^{
        
            [headlinelabel startGlowLoop];
        
    } afterDelaySecs:2.f];
}

- (void)configureDataSource {

    self.items = @[[Item itemWithName:@"POP-按钮动画" object:[ButtonPressViewController class]],
                   [Item itemWithName:@"POP-Stroke动画" object:[PopStrokeController class]],
                   [Item itemWithName:@"CAShapeLayer的path动画" object:[CAShapeLayerPathController class]],
                   [Item itemWithName:@"图片碎片化mask动画" object:[TransformFadeViewController class]],
                   [Item itemWithName:@"POP-数值动画" object:[PopNumberController class]],
                   [Item itemWithName:@"Easing-圆环动画" object:[CircleAnimationViewController class]],
                   [Item itemWithName:@"UIScrollView视差效果动画" object:[ScrollImageViewController class]],
                   [Item itemWithName:@"UIScrollView视差模糊效果" object:[ScrollBlurImageViewController class]],
                   [Item itemWithName:@"UITableView状态切换效果" object:[TableViewTapAnimationController class]],
                   [Item itemWithName:@"POP-Spring动画参数详解" object:[POPSpringParameterController class]],
                   [Item itemWithName:@"UITableView展开缩放动画" object:[HeaderViewTapAnimationController class]],
                   [Item itemWithName:@"UITableView显示倒计时" object:[CountDownTimerController class]],
                   [Item itemWithName:@"时钟动画效果" object:[ClockViewController class]],
//                   [Item itemWithName:@"TableViewCell滑动动画" object:[TableViewCellSlideAnimationController class]],
                   [Item itemWithName:@"绘制波形图动画" object:[DrawWaveViewController class]],
                   [Item itemWithName:@"UILabel缩放动画" object:[LabelScaleViewController class]],
                   [Item itemWithName:@"Facebook辉光动画" object:[ShimmerController class]],
                   [Item itemWithName:@"粒子动画-雪花" object:[EmitterSnowController class]],
                   [Item itemWithName:@"刮奖效果" object:[ScratchImageViewController class]],
                   [Item itemWithName:@"图片切换效果" object:[LiveImageViewController class]],
                   [Item itemWithName:@"SDWebImage加载图片" object:[SDWebImageController class]],
                   [Item itemWithName:@"抽象的AlertView" object:[AlertViewController class]],
                   [Item itemWithName:@"瀑布流效果" object:[WaterfallLayoutController class]]];
}

#pragma mark - tableView 相关
- (void)configureTableView {
    
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.rowHeight      = 50.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ListItemCell class] forCellReuseIdentifier:listItemCellString];
    
    [self.contentView addSubview:self.tableView];
    
    [GCDQueue executeInMainQueue:^{

        // Load data.
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < self.items.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        
        self.tableViewLoadData = YES;
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];

    } afterDelaySecs:0.25f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.tableViewLoadData == NO) {
        
        return 0;
        
    } else {
    
        return self.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:listItemCellString];
    cell.indexPath     = indexPath;
    cell.data          = self.items[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Item             *item       = self.items[indexPath.row];
    UIViewController *controller = [item.object new];
    controller.title             = item.name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = YES;
}

@end

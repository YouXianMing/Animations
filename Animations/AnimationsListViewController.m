//
//  AnimationsListViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "AnimationsListViewController.h"
#import "UIView+AnimationsListViewController.h"
#import "UIView+SetRect.h"
#import "UIView+GlowView.h"
#import "UITableView+CellClass.h"
#import "ListItemCell.h"
#import "BackgroundLineView.h"
#import "Item.h"
#import "GCD.h"
#import "PushAnimator.h"
#import "PopAnimator.h"
#import "UIFont+Fonts.h"

#import "ButtonPressViewController.h"
#import "PopStrokeController.h"
#import "CAShapeLayerPathController.h"
#import "TransformFadeViewController.h"
#import "CAGradientViewController.h"
#import "PopNumberController.h"
#import "CircleAnimationViewController.h"
#import "ScrollImageViewController.h"
#import "ScrollBlurImageViewController.h"
#import "TableViewTapAnimationController.h"
#import "POPSpringParameterController.h"
#import "HeaderViewTapAnimationController.h"
#import "CountDownTimerController.h"
#import "ClockViewController.h"
#import "DrawWaveViewController.h"
#import "LabelScaleViewController.h"
#import "ShimmerController.h"
#import "EmitterSnowController.h"
#import "ScratchImageViewController.h"
#import "LiveImageViewController.h"
#import "SDWebImageController.h"
#import "AlertViewController.h"
#import "WaterfallLayoutController.h"
#import "MixedColorProgressViewController.h"
#import "PageFlipEffectController.h"
#import "CATransform3DM34Controller.h"
#import "PressAnimationButtonController.h"
#import "BezierPathViewController.h"
#import "MusicBarAnimationController.h"
#import "ColorProgressViewController.h"
#import "SpringEffectController.h"
#import "CASpringAnimationController.h"
#import "AdditiveAnimationController.h"
#import "TableViewLoadDataController.h"
#import "MotionEffectViewController.h"
#import "GifPictureController.h"
#import "SCViewShakerController.h"
#import "ScrollViewAnimationController.h"
#import "TapCellAnimationController.h"
#import "TextKitLoadImageController.h"
#import "ReplicatorLineViewController.h"
#import "DrawMarqueeViewController.h"
#import "LazyFadeInViewController.h"
#import "OffsetCellViewController.h"
#import "SystemFontInfoController.h"
#import "iCarouselViewController.h"
#import "GridFlowLayoutViewController.h"
#import "InfiniteLoopViewController.h"
#import "BaseControlViewController.h"
#import "SpringScaleViewController.h"
#import "TapPathDrawViewController.h"
#import "QRCodeViewController.h"
#import "MaskShapeViewController.h"
#import "WaterWaveViewController.h"

@interface AnimationsListViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic)         BOOL            tableViewLoadData;

@property (nonatomic, strong) NSMutableArray  <CellDataAdapter *> *items;

@end

@implementation AnimationsListViewController

- (void)setup {

    [super setup];
    
    [self rootViewControllerSetup];
    
    [self configureDataSource];
    
    [self configureTableView];
    
    [self configureTitleView];
}

#pragma mark - RootViewController setup.

- (void)rootViewControllerSetup {
    
    // [IMPORTANT] Enable the Push transitioning.
    self.navigationController.delegate = self;
    
    // [IMPORTANT] Set the RootViewController's push delegate.
    [self useInteractivePopGestureRecognizer];
}

#pragma mark - Push or Pop event.

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        return [PushAnimator new];
        
    } else if (operation == UINavigationControllerOperationPop) {
        
        return [PopAnimator new];
        
    } else {
        
        return nil;
    }
}

#pragma mark - Config TitleView.

- (void)configureTitleView {
    
    BackgroundLineView *lineView = [BackgroundLineView backgroundLineViewWithFrame:CGRectMake(0, 0, self.width, 64)
                                                                         lineWidth:4 lineGap:4
                                                                         lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015]
                                                                            rotate:M_PI_4];
    [self.titleView addSubview:lineView];
    
    // Title label.
    UILabel *headlinelabel          = [UIView animationsListViewControllerNormalHeadLabel];
    UILabel *animationHeadLineLabel = [UIView animationsListViewControllerHeadLabel];
    
    // Title view.
    UIView *titleView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    headlinelabel.center          = titleView.middlePoint;
    animationHeadLineLabel.center = titleView.middlePoint;
    [titleView addSubview:headlinelabel];
    [titleView addSubview:animationHeadLineLabel];
    [self.titleView addSubview:titleView];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [titleView addSubview:line];
    
    // Start glow.
    animationHeadLineLabel.glowRadius            = @(2.f);
    animationHeadLineLabel.glowOpacity           = @(1.f);
    animationHeadLineLabel.glowColor             = [[UIColor colorWithRed:0.203  green:0.598  blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    
    animationHeadLineLabel.glowDuration          = @(1.f);
    animationHeadLineLabel.hideDuration          = @(3.f);
    animationHeadLineLabel.glowAnimationDuration = @(2.f);
    
    [animationHeadLineLabel createGlowLayer];
    [animationHeadLineLabel insertGlowLayer];
    
    [GCDQueue executeInMainQueue:^{
        
        [animationHeadLineLabel startGlowLoop];
        
    } afterDelaySecs:2.f];
}

#pragma mark - Config DataSource.

- (void)configureDataSource {
    
    NSArray *array = @[[Item itemWithName:@"POP-按钮动画" object:[ButtonPressViewController class]],
                       [Item itemWithName:@"POP-Stroke动画" object:[PopStrokeController class]],
                       [Item itemWithName:@"CAShapeLayer的path动画" object:[CAShapeLayerPathController class]],
                       [Item itemWithName:@"图片碎片化mask动画" object:[TransformFadeViewController class]],
                       [Item itemWithName:@"CAGradientLayer动画" object:[CAGradientViewController class]],
                       [Item itemWithName:@"POP-数值动画" object:[PopNumberController class]],
                       [Item itemWithName:@"Easing-圆环动画" object:[CircleAnimationViewController class]],
                       [Item itemWithName:@"UIScrollView视差效果动画" object:[ScrollImageViewController class]],
                       [Item itemWithName:@"UIScrollView视差模糊效果" object:[ScrollBlurImageViewController class]],
                       [Item itemWithName:@"UITableView状态切换效果" object:[TableViewTapAnimationController class]],
                       [Item itemWithName:@"POP-Spring动画参数详解" object:[POPSpringParameterController class]],
                       [Item itemWithName:@"UITableView展开缩放动画" object:[HeaderViewTapAnimationController class]],
                       [Item itemWithName:@"UITableView显示倒计时" object:[CountDownTimerController class]],
                       [Item itemWithName:@"时钟动画效果" object:[ClockViewController class]],
                       [Item itemWithName:@"绘制波形图动画" object:[DrawWaveViewController class]],
                       [Item itemWithName:@"UILabel缩放动画" object:[LabelScaleViewController class]],
                       [Item itemWithName:@"Facebook辉光动画" object:[ShimmerController class]],
                       [Item itemWithName:@"粒子动画-雪花" object:[EmitterSnowController class]],
                       [Item itemWithName:@"刮奖效果" object:[ScratchImageViewController class]],
                       [Item itemWithName:@"图片切换效果" object:[LiveImageViewController class]],
                       [Item itemWithName:@"SDWebImage加载图片" object:[SDWebImageController class]],
                       [Item itemWithName:@"抽象的AlertView" object:[AlertViewController class]],
                       [Item itemWithName:@"瀑布流效果" object:[WaterfallLayoutController class]],
                       [Item itemWithName:@"UILabel混色显示" object:[MixedColorProgressViewController class]],
                       [Item itemWithName:@"翻页效果" object:[PageFlipEffectController class]],
                       [Item itemWithName:@"CATransform3D m34" object:[CATransform3DM34Controller class]],
                       [Item itemWithName:@"按钮特效" object:[PressAnimationButtonController class]],
                       [Item itemWithName:@"心电图动画效果" object:[BezierPathViewController class]],
                       [Item itemWithName:@"音乐波形图动画" object:[MusicBarAnimationController class]],
                       [Item itemWithName:@"彩色进度条" object:[ColorProgressViewController class]],
                       [Item itemWithName:@"果冻效果" object:[SpringEffectController class]],
                       [Item itemWithName:@"CASpringAnimation" object:[CASpringAnimationController class]],
                       [Item itemWithName:@"Additive属性动画" object:[AdditiveAnimationController class]],
                       [Item itemWithName:@"加载网络数据" object:[TableViewLoadDataController class]],
                       [Item itemWithName:@"MotionEffect效果" object:[MotionEffectViewController class]],
                       [Item itemWithName:@"加载GIF图片" object:[GifPictureController class]],
                       [Item itemWithName:@"震动效果" object:[SCViewShakerController class]],
                       [Item itemWithName:@"ScrollView动画" object:[ScrollViewAnimationController class]],
                       [Item itemWithName:@"Cell点击动画" object:[TapCellAnimationController class]],
                       [Item itemWithName:@"TextKit简单示例" object:[TextKitLoadImageController class]],
                       [Item itemWithName:@"线性重复动画" object:[ReplicatorLineViewController class]],
                       [Item itemWithName:@"跑马灯效果" object:[DrawMarqueeViewController class]],
                       [Item itemWithName:@"文本渐变动画效果" object:[LazyFadeInViewController class]],
                       [Item itemWithName:@"Cell图片视差动画" object:[OffsetCellViewController class]],
                       [Item itemWithName:@"系统字体列表" object:[SystemFontInfoController class]],
                       [Item itemWithName:@"旋转木马效果" object:[iCarouselViewController class]],
                       [Item itemWithName:@"水平方向瀑布流" object:[GridFlowLayoutViewController class]],
                       [Item itemWithName:@"无限轮播图" object:[InfiniteLoopViewController class]],
                       [Item itemWithName:@"BaseControl按钮合集" object:[BaseControlViewController class]],
                       [Item itemWithName:@"POP-缩放" object:[SpringScaleViewController class]],
                       [Item itemWithName:@"点击区域的绘制" object:[TapPathDrawViewController class]],
                       [Item itemWithName:@"QR-Code" object:[QRCodeViewController class]],
                       [Item itemWithName:@"不规则形状的Mask" object:[MaskShapeViewController class]],
                       [Item itemWithName:@"水波纹效果" object:[WaterWaveViewController class]]];
    
    self.items = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
    
        Item *item = array[i];
        item.index = i + 1;
        [item createAttributedString];

        [self.items addObject:[ListItemCell dataAdapterWithCellReuseIdentifier:nil data:item cellHeight:0 type:0]];
    }
}

#pragma mark - TableView Related.

- (void)configureTableView {
    
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.rowHeight      = 50.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerCellsClass:@[cellClass(@"ListItemCell", nil)]];
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
    
    return self.tableViewLoadData ? self.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:_items[indexPath.row] indexPath:indexPath controller:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];    
}

#pragma mark - Overwrite system methods.

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
//    self.enableInteractivePopGestureRecognizer = YES;
}

@end

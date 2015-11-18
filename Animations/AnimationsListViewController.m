//
//  AnimationsListViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "AnimationsListViewController.h"
#import "UIColor+CustomColors.h"
#import "UIView+GlowView.h"
#import "ListItemCell.h"
#import "Item.h"
#import "GCD.h"

#import "ButtonPressViewController.h"
#import "PopStrokeController.h"
#import "CAShapeLayerPathController.h"
#import "TransformFadeViewController.h"
#import "PopNumberController.h"

@interface AnimationsListViewController ()

@property (nonatomic, strong) NSArray  *items;

@end

@implementation AnimationsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureTitleView];
    
    [self configureDataSource];
    
    [self configureTableView];
}

- (void)configureTitleView {
    
    self.title = @"Animations";
    
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = Font_Avenir_Light(28);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor customGrayColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor customBlueColor]
                             range:NSMakeRange(1, 1)];
    
    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    
    [self.navigationItem setTitleView:headlinelabel];
    
    headlinelabel.glowRadius            = @(4.f);
    headlinelabel.glowOpacity           = @(0.8f);
    headlinelabel.glowColor             = [[UIColor customRedColor] colorWithAlphaComponent:0.75f];
    
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
                   [Item itemWithName:@"POP-数值动画" object:[PopNumberController class]]];
}

#pragma mark - tableView 相关
- (void)configureTableView {

    self.tableView.rowHeight      = 50.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ListItemCell class] forCellReuseIdentifier:listItemCellString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:listItemCellString];
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

@end

//
//  SlideAnimationCell.m
//  Animations
//
//  Created by YouXianMing on 15/12/4.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "SlideAnimationCell.h"
#import "UIView+SetRect.h"

@interface SlideAnimationCell ()

@property (nonatomic, strong) UIView     *blackView;
@property (nonatomic, strong) UILabel    *label;

@end

@implementation SlideAnimationCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 注册通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationEvent:)
                                                 name:DATA_CELL
                                               object:nil];
}

- (void)buildSubview {

    self.label      = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 300, CELL_HEIGHT)];
    self.label.font = Font_Avenir(30.f);
    [self addSubview:self.label];
    
    self.blackView                 = [[UIView alloc] initWithFrame:CGRectMake(10 + 50, 80, 150, 2)];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.blackView];
}

- (void)notificationEvent:(id)sender {
    
    NSDictionary *data    = sender;
    CGFloat       offsetY = [[data valueForKey:@"object"] floatValue] - self.indexPath.row * CELL_HEIGHT;
    
    if (self.indexPath.row == 4) {
        
        NSLog(@"%f", offsetY);
    }
    
    if (offsetY >= 0 && offsetY <= CELL_HEIGHT) {
        
        // 根据百分比计算
        CGFloat percent  = 1 - offsetY / CELL_HEIGHT;
        
        // 设置值
        self.label.alpha = percent;
        self.blackView.x = 10 + percent * 50;
        
    } else if (offsetY >= - CELL_HEIGHT * 5 && offsetY <= - CELL_HEIGHT * 4) {
        
        // 根据百分比计算
        CGFloat percent  = (offsetY + CELL_HEIGHT) / CELL_HEIGHT + 4;
        
        // 设置值
        self.label.alpha = percent;
        self.blackView.x = 10 + 50 + (1 - percent) * 50;
        
    } else {
        
        // 复位
        self.label.alpha = 1.f;
        self.blackView.x = 10 + 50;
    }
}

- (void)loadContent {

    NSString *showString = self.dataAdapter.data;
    self.label.text      = showString;
}

- (void)dealloc {
    
    // 移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DATA_CELL object:nil];
}

@end

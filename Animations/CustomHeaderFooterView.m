//
//  CustomHeaderFooterView.m
//  Animations
//
//  Created by YouXianMing on 15/11/30.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomHeaderFooterView.h"

@implementation CustomHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color {

    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {

}

- (void)loadContent {

}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {

    NSString *identifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifier];
}

+ (void)registerToTableView:(UITableView *)tableView {

    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
}

@end

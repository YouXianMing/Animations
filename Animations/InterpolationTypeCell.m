//
//  InterpolationTypeCell.m
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "InterpolationTypeCell.h"
#import "InterpolationTypeDrawView.h"
#import "UIView+SetRect.h"

@interface InterpolationTypeCell ()

@property (nonatomic, strong) InterpolationTypeDrawView *drawView;

@end

@implementation InterpolationTypeCell

- (void)buildSubview {
    
    self.drawView = [[InterpolationTypeDrawView alloc] initWithFrame:CGRectMake(0, 0, Width, [InterpolationTypeCell cellHeightWithData:nil])];
    [self.contentView addSubview:self.drawView];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 200;
}

@end

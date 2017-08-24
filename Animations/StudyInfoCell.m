//
//  StudyInfoCell.m
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "StudyInfoCell.h"
#import "StudyInfoDrawView.h"
#import "UIView+SetRect.h"

@interface StudyInfoCell ()

@property (nonatomic, strong) StudyInfoDrawView *drawView;

@end

@implementation StudyInfoCell

- (void)buildSubview {
    
    self.drawView = [[StudyInfoDrawView alloc] initWithFrame:CGRectMake(0, 0, Width, [StudyInfoCell cellHeightWithData:nil])];
    [self.contentView addSubview:self.drawView];
}

- (void)loadContent {
    
    self.drawView.model = self.data;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 200;
}

@end

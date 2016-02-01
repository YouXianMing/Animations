//
//  StudentInfoCell.m
//  HeaderViewTapAnimation
//
//  Created by YouXianMing on 15/9/16.
//  Copyright (c) 2015年 ZiPeiYi. All rights reserved.
//

#import "StudentInfoCell.h"
#import "StudentModel.h"
#import "UIView+SetRect.h"

@interface StudentInfoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;

@end

@implementation StudentInfoCell

- (void)loadContent {

    StudentModel *model = self.data;
    
    self.nameLabel.text = model.name;
    self.ageLabel.text  = model.age.stringValue;
}

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.nameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 60)];
    self.nameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:20.f];
    [self addSubview:self.nameLabel];
    
    self.ageLabel               = [[UILabel alloc] initWithFrame:CGRectMake(Width - 220, 0, 200, 60)];
    self.ageLabel.textAlignment = NSTextAlignmentRight;
    self.ageLabel.font          = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:20.f];
    [self addSubview:self.ageLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5f, Width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1f];
    [self addSubview:line];
}

- (void)showSelectedAnimation {
    
    UIView *tmpView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 60)];
    tmpView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.15f];
    tmpView.alpha           = 0.f;
    
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            tmpView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}


@end

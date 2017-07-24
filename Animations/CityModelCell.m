//
//  CityModelCell.m
//  TreeTableView
//
//  Created by YouXianMing on 2017/7/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CityModelCell.h"
#import "CityModel.h"
#import "IconEdgeInsetsLabel.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"

@interface CityModelCell ()

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *expendedColor;
@property (nonatomic, strong) UIColor *finalColor;

@property (nonatomic, strong) UIView              *leftSideView;
@property (nonatomic, strong) IconEdgeInsetsLabel *label;

@end

@implementation CityModelCell

- (void)setupCell {
    
    [super setupCell];
    
    self.normalColor   = [[UIColor redColor] colorWithAlphaComponent:0.95f];
    self.expendedColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.finalColor    = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
}

- (void)buildSubview {
    
    self.leftSideView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 16.f)];
    self.leftSideView.backgroundColor = [UIColor blackColor];
    
    self.label           = [[IconEdgeInsetsLabel alloc] initWithFrame:CGRectZero];
    self.label.font      = [UIFont HYQiHeiWithFontSize:18.f];
    self.label.direction = kIconAtLeft;
    self.label.gap       = 5.f;
    self.label.iconView  = self.leftSideView;
    [self.contentView addSubview:self.label];
}

- (void)loadContent {
 
    CityModel *model = self.data;
    
    [self.label sizeToFitWithText:model.text];
    self.label.centerY = 25.f;
    self.label.left    = 15.f + model.level * 35.f;
    
    if (model.submodelsCount) {
        
        self.label.textColor              = [UIColor darkTextColor];
        self.leftSideView.backgroundColor = model.extend ? self.normalColor : self.expendedColor;
        self.contentView.backgroundColor  = model.extend ? [[UIColor lightGrayColor] colorWithAlphaComponent:0.15] : [UIColor whiteColor];
        
    } else {
        
        self.label.textColor              = [UIColor lightGrayColor];
        self.leftSideView.backgroundColor = self.finalColor;
        self.contentView.backgroundColor  = [UIColor whiteColor];
    }
}

- (void)selectedEvent {
    
    CityModel *model = self.data;
    
    if (model.submodelsCount) {
        
        self.label.textColor = [UIColor darkTextColor];
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.leftSideView.backgroundColor = model.extend ? self.expendedColor : self.normalColor;
            self.contentView.backgroundColor  = model.extend ? [UIColor whiteColor] : [[UIColor lightGrayColor] colorWithAlphaComponent:0.15];
            
        } completion:nil];
        
    } else {
        
        self.label.textColor              = [UIColor lightGrayColor];
        self.leftSideView.backgroundColor = self.finalColor;
        self.contentView.backgroundColor  = [UIColor whiteColor];
    }
}

@end


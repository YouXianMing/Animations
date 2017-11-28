//
//  SelectItemView.h
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectItemView;

@protocol SelectItemViewDelegate <NSObject>

@required

- (void)selectItemViewTapEvent:(SelectItemView *)selectItemView;

@end

@interface SelectItemView : UIView

@property (nonatomic, weak)   id <SelectItemViewDelegate>  delegate;
@property (nonatomic, strong) NSString                    *title;
@property (nonatomic, strong) NSAttributedString          *content;

@end

//
//  TapDrawImageView.h
//  TapDrawImageView
//
//  Created by YouXianMing on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapDrawPathManager.h"
@class TapDrawImageView;

static NSString *tapDrawImageViewNormalState    = @"normalState";
static NSString *tapDrawImageViewHighlightState = @"highlightState";
static NSString *tapDrawImageDisableState       = @"disableState";

@protocol TapDrawImageViewDelegate <NSObject>

- (void)tapDrawImageView:(TapDrawImageView *)tapImageView selectedPathManager:(TapDrawPathManager *)pathManager;

@end

@interface TapDrawImageView : UIView

@property (nonatomic, weak)   id <TapDrawImageViewDelegate>  delegate;

@property (nonatomic, strong) NSMutableArray  <TapDrawPathManager *>  *pathManagers;

@end

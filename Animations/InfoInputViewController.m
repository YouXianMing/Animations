//
//  InfoInputViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "InfoInputViewController.h"
#import "HexColors.h"
#import "UIView+SetRect.h"
#import "InfoInputViewController+CreateViews.h"
#import "TextFiledTitleView.h"
#import "UIView+ConvertRect.h"
#import "SelectItemView.h"
#import "UIButton+Inits.h"
#import "UIImage+SolidColor.h"
#import "HexColors.h"
#import "NSObject+ItemStyle.h"
#import "SubmitItemStyle.h"
#import "ResponsibilityManager.h"
#import "RealNameChain.h"
#import "PhoneNumChain.h"
#import "CompanyNameChain.h"
#import "CompanyPeopleChain.h"
#import "CompanyPeopleRequiredChain.h"
#import "MessageView.h"

typedef enum : NSUInteger {
    
    kPosition_1 = 0,
    kPosition_2,
    kPosition_3,
    kPosition_4,
    
    kTextField_tag = 1000,
    
} ETagValue;

@interface InfoInputViewController () <UITextFieldDelegate, SelectItemViewDelegate, BaseMessageViewDelegate>

@property (nonatomic, strong) ResponsibilityManager *responsibilityManager;
@property (nonatomic, strong) UIScrollView          *scrollView;

@end

@implementation InfoInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.responsibilityManager = [ResponsibilityManager new];
    
    self.titleView.backgroundColor      = [UIColor whiteColor];
    self.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#F7F8F9"];
    self.scrollView                     = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.contentView addSubview:self.scrollView];
    
    CGFloat top = 10.f;
    
    // 姓名 + 手机号
    {
        UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:2];
        top                 += whiteBGView.height + 10.f;
        [self.scrollView addSubview:whiteBGView];
        
        {
            TextFiledTitleView *fieldView       = [[TextFiledTitleView alloc] initWithFrame:CGRectMake(0, kPosition_1 * 50.f, Width, 50.f)];
            fieldView.title                     = @"您的真实姓名";
            fieldView.placeHolder               = @"姓名";
            fieldView.field.delegate            = self;
            fieldView.field.responsibilityChain = [RealNameChain new];
            [self.responsibilityManager addChain:fieldView.field];
            [whiteBGView addSubview:fieldView];
        }
        
        {
            TextFiledTitleView *fieldView       = [[TextFiledTitleView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            fieldView.title                     = @"手机号";
            fieldView.placeHolder               = @"手机号";
            fieldView.field.delegate            = self;
            fieldView.field.keyboardType        = UIKeyboardTypeNumberPad;
            fieldView.field.responsibilityChain = [PhoneNumChain new];
            [self.responsibilityManager addChain:fieldView.field];
            [whiteBGView addSubview:fieldView];
        }
    }
    
    // 企业名称 + 企业人数
    {
        UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:2];
        top                 += whiteBGView.height + 10.f;
        [self.scrollView addSubview:whiteBGView];
        
        {
            TextFiledTitleView *fieldView       = [[TextFiledTitleView alloc] initWithFrame:CGRectMake(0, kPosition_1 * 50.f, Width, 50.f)];
            fieldView.title                     = @"企业名称";
            fieldView.placeHolder               = @"名称";
            fieldView.field.delegate            = self;
            fieldView.field.responsibilityChain = [CompanyNameChain new];
            [self.responsibilityManager addChain:fieldView.field];
            [whiteBGView addSubview:fieldView];
        }
        
        {
            TextFiledTitleView *fieldView       = [[TextFiledTitleView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            fieldView.title                     = @"企业人数";
            fieldView.placeHolder               = @"人数";
            fieldView.field.delegate            = self;
            fieldView.field.keyboardType        = UIKeyboardTypeNumberPad;
            fieldView.field.responsibilityChain = [CompanyPeopleChain new];
            [self.responsibilityManager addChain:fieldView.field];
            [whiteBGView addSubview:fieldView];
        }
    }
    
    // 需求工位数 + 工位类型 + 是否需要独立宽带 + 是否需要保洁服务
    {
        UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:4];
        top                 += whiteBGView.height + 10.f;
        [self.scrollView addSubview:whiteBGView];
        
        {
            TextFiledTitleView *fieldView       = [[TextFiledTitleView alloc] initWithFrame:CGRectMake(0, kPosition_1 * 50.f, Width, 50.f)];
            fieldView.title                     = @"需求工位数";
            fieldView.placeHolder               = @"工位数";
            fieldView.field.delegate            = self;
            fieldView.field.keyboardType        = UIKeyboardTypeNumberPad;
            fieldView.field.responsibilityChain = [CompanyPeopleRequiredChain new];
            [self.responsibilityManager addChain:fieldView.field];
            [whiteBGView addSubview:fieldView];
        }
        
        {
            SelectItemView *itemView = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            itemView.title           = @"工位类型";
            itemView.delegate        = self;
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_3 * 50.f, Width, 50.f)];
            itemView.title           = @"是否需要独立宽带";
            itemView.delegate        = self;
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_4 * 50.f, Width, 50.f)];
            itemView.title           = @"是否需要保洁服务";
            itemView.delegate        = self;
            [whiteBGView addSubview:itemView];
        }
    }
    
    // 希望入孵时间 + 预测孵化周期
    {
        UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:2];
        top                 += whiteBGView.height + 10.f;
        [self.scrollView addSubview:whiteBGView];
        
        {
            SelectItemView *itemView = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_1 * 50.f, Width, 50.f)];
            itemView.title           = @"希望入孵时间";
            itemView.delegate        = self;
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            itemView.title           = @"预测孵化周期";
            itemView.delegate        = self;
            [whiteBGView addSubview:itemView];
        }
    }
    
    UIButton *submit   = [[UIButton alloc] initWithFrame:CGRectMake(15.f, top + 85.f, Width - 30.f, 45.f)];
    submit.itemStyle   = [SubmitItemStyle style];
    submit.normalTitle = @"提交申请";
    [submit addTarget:self action:@selector(submitEvent)];
    [self.scrollView addSubview:submit];
    
    self.scrollView.contentSize = CGSizeMake(Width, submit.bottom + 15.f);
}

- (void)submitEvent {
    
    if ([self.responsibilityManager checkResponsibilityChain].checkSuccess == NO) {
        
        [MessageView showAutoHiddenMessageViewInKeyWindowWithMessageObject:MakeMessageViewObject(nil, [self.responsibilityManager checkResponsibilityChain].errorMessage)
                                                                  delegate:self
                                                                   viewTag:kTextField_tag];
        return;
    }
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView {
    
    if (messageView.tag == kTextField_tag) {
        
        UITextField *field = [self.responsibilityManager checkResponsibilityChain].object;
        CGPoint      point = [field.superview.superview frameOriginFromView:self.scrollView];
        
        [UIView animateWithDuration:0.35f animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
            
        } completion:^(BOOL finished) {
            
            [field becomeFirstResponder];
        }];
    }
}

#pragma mark - SelectItemViewDelegate

- (void)selectItemViewTapEvent:(SelectItemView *)selectItemView {
    
    NSLog(@"todo ----> %@", selectItemView);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
 
    CGPoint point = [textField.superview.superview frameOriginFromView:self.scrollView];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.scrollView.contentOffset.y + self.contentView.height > self.scrollView.contentSize.height) {
        
        [UIView animateWithDuration:0.4f animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.contentView.height);
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end

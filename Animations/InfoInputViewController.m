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
#import "SelectedItemChain.h"
#import "MessageView.h"
#import "OneItemPickerView.h"
#import "DateItemPickerView.h"
#import "DateFormatter.h"
#import "LoadingView.h"
#import "AlertView.h"
#import "GCD.h"

typedef enum : NSUInteger {
    
    kPosition_1 = 0,
    kPosition_2,
    kPosition_3,
    kPosition_4,
    
    kInputValue = 1000,
    kLoadingView,
    kAlertView,
    
} ETagValue;

@interface InfoInputViewController () <UITextFieldDelegate, SelectItemViewDelegate, BaseMessageViewDelegate, BaseShowPickerViewDelegate>

@property (nonatomic, strong) ResponsibilityManager *responsibilityManager;
@property (nonatomic, strong) UIScrollView          *scrollView;

@end

@implementation InfoInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 责任链,用来管理错误信息提示
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
            SelectItemView *itemView     = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            itemView.title               = @"工位类型";
            itemView.delegate            = self;
            itemView.responsibilityChain = [SelectedItemChain selectedItemChainWithErrorMessage:@"请选择工位类型"];
            [self.responsibilityManager addChain:itemView];
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView     = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_3 * 50.f, Width, 50.f)];
            itemView.title               = @"是否需要独立宽带";
            itemView.delegate            = self;
            itemView.responsibilityChain = [SelectedItemChain selectedItemChainWithErrorMessage:@"请选择是否需要独立宽带"];
            [self.responsibilityManager addChain:itemView];
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView     = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_4 * 50.f, Width, 50.f)];
            itemView.title               = @"是否需要保洁服务";
            itemView.delegate            = self;
            itemView.responsibilityChain = [SelectedItemChain selectedItemChainWithErrorMessage:@"请选择是否需要保洁服务"];
            [self.responsibilityManager addChain:itemView];
            [whiteBGView addSubview:itemView];
        }
    }
    
    // 希望入孵时间 + 预测孵化周期
    {
        UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:2];
        top                 += whiteBGView.height + 10.f;
        [self.scrollView addSubview:whiteBGView];
        
        {
            SelectItemView *itemView     = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_1 * 50.f, Width, 50.f)];
            itemView.title               = @"希望入孵时间";
            itemView.delegate            = self;
            itemView.responsibilityChain = [SelectedItemChain selectedItemChainWithErrorMessage:@"请选择您希望的入孵时间"];
            [self.responsibilityManager addChain:itemView];
            [whiteBGView addSubview:itemView];
        }
        
        {
            SelectItemView *itemView     = [[SelectItemView alloc] initWithFrame:CGRectMake(0, kPosition_2 * 50.f, Width, 50.f)];
            itemView.title               = @"预测孵化周期";
            itemView.delegate            = self;
            itemView.responsibilityChain = [SelectedItemChain selectedItemChainWithErrorMessage:@"请选择您预测的孵化周期"];
            [self.responsibilityManager addChain:itemView];
            [whiteBGView addSubview:itemView];
        }
    }
    
    UIButton *submit   = [[UIButton alloc] initWithFrame:CGRectMake(15.f, top + 150.f, Width - 30.f, 45.f)];
    submit.itemStyle   = [SubmitItemStyle style];
    submit.normalTitle = @"提交申请";
    [submit addTarget:self action:@selector(submitEvent)];
    [self.scrollView addSubview:submit];
    
    self.scrollView.contentSize = CGSizeMake(Width, submit.bottom + 15.f);
}

- (void)submitEvent {
    
    if ([self.responsibilityManager checkResponsibilityChain].checkSuccess == NO) {
        
        id message = MakeMessageViewObject(nil, [self.responsibilityManager checkResponsibilityChain].errorMessage);
        MessageView.build.autoHidden.withMessage(message).withDelegate(self).withTag(kInputValue).showInKeyWindow();
        return;
    }
    
    LoadingView *loadingView = LoadingView.build;
    loadingView.withTag(kLoadingView).withDelegate(self).showInKeyWindow();
    
    [GCDQueue executeInMainQueue:^{
        
        [loadingView hide];
        
    } afterDelaySecs:3.f];
}

- (void)scrollViewScrollInInnerArea {
    
    if (self.scrollView.contentOffset.y + self.contentView.height > self.scrollView.contentSize.height) {
        
        [UIView animateWithDuration:0.4f animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.contentView.height);
        }];
    }
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView {
    
    if (messageView.tag == kInputValue) {
        
        id object = [self.responsibilityManager checkResponsibilityChain].object;
        if ([object isKindOfClass:[UITextField class]]) {
            
            UITextField *field = object;
            CGPoint      point = [field.superview.superview frameOriginFromView:self.scrollView];
            
            [UIView animateWithDuration:0.35f animations:^{
                
                self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
                
            } completion:^(BOOL finished) {
                
                [field becomeFirstResponder];
            }];
            
        } else if ([object isKindOfClass:[SelectItemView class]]) {
            
            SelectItemView *itemView = object;
            CGPoint         point    = [itemView.superview frameOriginFromView:self.scrollView];
            
            [UIView animateWithDuration:0.35f animations:^{
                
                self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
                
            } completion:^(BOOL finished) {
                
                [self selectItemViewTapEvent:itemView];
            }];
        }
        
    } else if (messageView.tag == kLoadingView) {
        
        AlertView.build.withDelegate(self).withTag(kAlertView).withMessage(MakeAlertViewMessageObject(@"恭喜您提交成功", @[AlertViewRedStyle(@"确定")])).showInKeyWindow();
        
    } else if (messageView.tag == kAlertView) {
        
        [self popViewControllerAnimated:YES];
    }
}

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    [messageView hide];
}

#pragma mark - BaseShowPickerViewDelegate

- (void)baseShowPickerViewWillHide:(BaseShowPickerView *)showPickerView {
    
    [self scrollViewScrollInInnerArea];
}

- (void)baseShowPickerView:(BaseShowPickerView *)showPickerView didSelectedIndexs:(NSArray <NSNumber *> *)indexs items:(NSArray *)items {
    
    if ([showPickerView isKindOfClass:[OneItemPickerView class]]) {
        
        SelectItemView *itemView = showPickerView.object;
        itemView.content         = items.firstObject;
        
    } else if ([showPickerView isKindOfClass:[DateItemPickerView class]]) {
        
        SelectItemView *itemView = showPickerView.object;
        itemView.content         = [self normalFontWithString:[DateFormatter dateStringFromDate:items.firstObject outputDateStringFormatter:@"yyyy-MM-dd"]];
    }
}

#pragma mark - SelectItemViewDelegate

- (void)selectItemViewTapEvent:(SelectItemView *)selectItemView {
    
    [self.view endEditing:YES];
    
    // 移动到指定的位置
    CGPoint point = [selectItemView.superview frameOriginFromView:self.scrollView];
    [UIView animateWithDuration:0.4f animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
    }];
    
    // 显示pickerView
    id selectedItem = nil;
    id showDatas    = nil;
    
    if ([selectItemView.title isEqualToString:@"工位类型"]) {
        
        selectedItem = selectItemView.content;
        showDatas    = @[[self normalFontWithString:@"独立办公"], [self normalFontWithString:@"开放办公"]];
        
    } else if ([selectItemView.title isEqualToString:@"是否需要独立宽带"] || [selectItemView.title isEqualToString:@"是否需要保洁服务"]) {
        
        selectedItem = selectItemView.content;
        showDatas    = @[[self boldRedWithString:@"是"], [self normalFontWithString:@"否"]];
        
    } else if ([selectItemView.title isEqualToString:@"预测孵化周期"]) {
        
        selectedItem = selectItemView.content;
        showDatas    = @[[self normalFontWithMonthString:@"1 个月"],
                         [self normalFontWithMonthString:@"2 个月"],
                         [self normalFontWithMonthString:@"3 个月"],
                         [self normalFontWithMonthString:@"4 个月"],
                         [self normalFontWithMonthString:@"5 个月"],
                         [self normalFontWithMonthString:@"6 个月"],
                         [self normalFontWithMonthString:@"7 个月"],
                         [self normalFontWithMonthString:@"8 个月"],
                         [self normalFontWithMonthString:@"9 个月"],
                         [self normalFontWithMonthString:@"10 个月"],
                         [self normalFontWithMonthString:@"11 个月"],
                         [self normalFontWithMonthString:@"12 个月"]];
        
    } else if ([selectItemView.title isEqualToString:@"希望入孵时间"] && selectItemView.content.string.length) {
        
        selectedItem = [DateFormatter dateFormatterWithInputDateString:[selectItemView.content string] inputDateStringFormatter:@"yyyy-MM-dd"];
    }
    
    Class PickerViewClass = [selectItemView.title isEqualToString:@"希望入孵时间"] ? [DateItemPickerView class] : [OneItemPickerView class];
    
    if (arc4random() % 2) {
        
        // Normal Programming.
        [PickerViewClass showPickerViewWithDelegate:self tag:0 object:selectItemView info:selectItemView.title selectedItem:selectedItem showDatas:showDatas];
        
    } else {
        
        // Chain Programming.
        BaseShowPickerView *pickerView = [PickerViewClass build];
        pickerView.withDelegate(self).withObject(selectItemView).withInfo(selectItemView.title).withSelectedItem(selectedItem).withShowDatas(showDatas).prepareAndShowInKeyWindow();
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGPoint point = [textField.superview.superview frameOriginFromView:self.scrollView];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, point.y - 10.f);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self scrollViewScrollInInnerArea];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end

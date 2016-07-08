//
//  QRCodeView.h
//  QRCode
//
//  Created by YouXianMing on 16/7/7.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class QRCodeView;

@protocol QRCodeViewDelegate <NSObject>

@optional

/**
 *  获取QR的扫描结果
 *
 *  @param codeView   QRCodeView实体对象
 *  @param codeString 扫描字符串
 */
- (void)QRCodeView:(QRCodeView *)codeView codeString:(NSString *)codeString;

@end

@interface QRCodeView : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <QRCodeViewDelegate> delegate;

/**
 *  灯的状态,默认为关闭
 */
@property (nonatomic) AVCaptureTorchMode torchMode;

/**
 *  敏感区域,如果不设置,则为全部扫描区域
 */
@property (nonatomic) CGRect interestArea;

/**
 *  你用来添加自定义控件的view,尺寸与当前初始化的view一致
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  正在运行当中
 */
@property (nonatomic, readonly) BOOL  isRunning;

/**
 *  开始扫描
 *
 *  @return 如果成功,则返回YES,否则返回NO
 */
- (BOOL)start;

/**
 *  结束扫描
 */
- (void)stop;

@end

//
//  QRCodeView.m
//  QRCode
//
//  Created by YouXianMing on 16/7/7.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import "QRCodeView.h"

@interface QRCodeView () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) BOOL                                 isRunning;
@property (nonatomic, strong) UIView                      *videoView;

@property (nonatomic, strong) AVCaptureDeviceInput        *deviceInput;
@property (nonatomic, strong) AVCaptureDevice             *captureDevice;
@property (nonatomic, strong) AVCaptureSession            *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureMetadataOutput     *captureMetadataOutput;

@end

@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.videoView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.videoView];
        
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        _torchMode = AVCaptureTorchModeOff;
        
        [self addNotificationCenter];
    }
    
    return self;
}

#pragma mark - NSNotificationCenter related.

- (void)addNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                               object:nil];
}

- (void)removeNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                  object:nil];
}

- (void)notificationCenterEvent:(NSNotification *)sender {
    
    if (self.interestArea.size.width && self.interestArea.size.height) {
        
        self.captureMetadataOutput.rectOfInterest = [self.videoPreviewLayer metadataOutputRectOfInterestForRect:self.interestArea];
        
    } else {
        
        self.captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1);
    }
}

#pragma mark - Start & Stop.

- (BOOL)start {
    
    // 初始化输入流
    BOOL     result  = NO;
    NSError *error   = nil;
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    if (self.deviceInput == nil) {
        
        NSLog(@"%@", error);
        return result;
    }
    
    // 创建会话
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // 添加输入流
    [self.captureSession addInput:self.deviceInput];
    
    // 初始化输出流
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    // 添加输出流
    [self.captureSession addOutput:self.captureMetadataOutput];
    
    // 创建queue.
    [self.captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_queue_create(nil, nil)];
    self.captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // 创建输出对象
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.frame = self.contentView.bounds;
    [self.videoView.layer addSublayer:self.videoPreviewLayer];
    
    // 开始
    [self.captureSession startRunning];
    self.isRunning = YES;
    result         = YES;
    
    return result;
}

- (void)stop {
    
    [self.captureSession stopRunning];
    self.isRunning      = NO;
    self.captureSession = nil;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *metadata = metadataObjects.firstObject;
        NSString                            *result   = nil;
        
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            result = metadata.stringValue;
            
            if (_delegate && [_delegate respondsToSelector:@selector(QRCodeView:codeString:)]) {
                
                [_delegate QRCodeView:self codeString:result];
            }
        }
    }
}

#pragma mark - Setter & Getter.

- (void)setTorchMode:(AVCaptureTorchMode)torchMode {

    _torchMode = torchMode;
    
    if (_deviceInput && [self.captureDevice hasTorch]) {
        
        [self.captureDevice lockForConfiguration:nil];
        [self.captureDevice setTorchMode:torchMode];
        [self.captureDevice unlockForConfiguration];
    }
}

#pragma mark - System method.

- (void)dealloc {
    
    [self stop];
    [self removeNotificationCenter];
}

@end

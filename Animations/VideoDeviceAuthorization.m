//
//  VideoDeviceAuthorization.m
//  QRCode
//
//  Created by YouXianMing on 16/7/7.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import "VideoDeviceAuthorization.h"

@implementation VideoDeviceAuthorization

+ (AVAuthorizationStatus)authorizationStatus {
    
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

@end

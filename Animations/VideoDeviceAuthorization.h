//
//  VideoDeviceAuthorization.h
//  QRCode
//
//  Created by YouXianMing on 16/7/7.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoDeviceAuthorization : NSObject

/**
 *  视频设备的授权情况
 *
 *  @param AVAuthorizationStatusNotDetermined 用户还没有开始授权(用户还没有遇到需要授权的状态)
 *  @param AVAuthorizationStatusRestricted 用户关闭了授权,设备不可用
 *  @param AVAuthorizationStatusDenied 用户拒绝授权,设备不可用
 *  @param AVAuthorizationStatusAuthorized 用户已经授权,设备可用
 *
 *  @return 授权状态
 */
+ (AVAuthorizationStatus)authorizationStatus;

@end

/**
 *  视频设备的授权情况
 *
 *  @param AVAuthorizationStatusNotDetermined 用户还没有开始授权(用户还没有遇到需要授权的状态)
 *  @param AVAuthorizationStatusRestricted 用户关闭了授权,设备不可用
 *  @param AVAuthorizationStatusDenied 用户拒绝授权,设备不可用
 *  @param AVAuthorizationStatusAuthorized 用户已经授权,设备可用
 *
 *  @return 授权状态
 */
NS_INLINE AVAuthorizationStatus videoAuthorizationStatus() {

    return [VideoDeviceAuthorization authorizationStatus];
}

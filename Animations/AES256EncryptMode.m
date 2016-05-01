//
//  AES256EncryptMode.m
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AES256EncryptMode.h"
#import "NSData+CommonCrypto.h"

static NSString *password = @"AES256Encrypt";

@implementation AES256EncryptMode

- (NSData *)encryptData:(NSData *)data {
    
    return [data AES256EncryptedDataUsingKey:password error:nil];
}

- (NSData *)decryptData:(NSData *)data {
    
    return [data decryptedAES256DataUsingKey:password error:nil];
}

@end

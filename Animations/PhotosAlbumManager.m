//
//  PhotosAlbumManager.m
//  SaveImage
//
//  Created by YouXianMing on 16/7/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PhotosAlbumManager.h"

static PhotosAlbumManager *_sharedSingleton = nil;

@interface PhotosAlbumManager ()

@property (nonatomic, copy) PhotosAlbumManagerDidFinishSavingBlock savingBlock;

@end

@implementation PhotosAlbumManager

+ (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler {
    
    [PHPhotoLibrary requestAuthorization:handler];
}

- (void)saveImage:(UIImage *)image didFinishSavingBlock:(PhotosAlbumManagerDidFinishSavingBlock)block {

    self.savingBlock = block;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)content  {
    
    self.savingBlock(image, error, content);
    self.savingBlock = nil;
}

#pragma mark -

- (instancetype)init {
    
    [NSException raise:NSStringFromClass([PhotosAlbumManager class])
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    [NSException raise:NSStringFromClass([PhotosAlbumManager class])
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    
    return nil;
}

+ (PhotosAlbumManager *)manager {
    
    if (self != [PhotosAlbumManager class]) {
        
        [NSException raise:NSStringFromClass([PhotosAlbumManager class])
                    format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedSingleton = [[PhotosAlbumManager alloc] initInstance];
    });
    
    return _sharedSingleton;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

@end


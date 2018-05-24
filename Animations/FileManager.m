//
//  FileManager.m
//  FileManager
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (File *)scanRelativeFilePath:(NSString *)relativeFilePath maxTreeLevel:(NSInteger)maxTreeLevel {
    
    File *file = nil;
    
    // Get the real file path.
    NSString *filePath = [FileManager absoluteFilePathFromRelativeFilePath:relativeFilePath];
    
    // Check file exist.
    BOOL isDirectory = NO;
    BOOL isExist     = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    // If file exist, create file.
    if (isExist) {
        
        file = [FileManager cerateFileWithFilePath:filePath isDirectory:isDirectory];
        
        if (file.isDirectory) {
            
            [FileManager scanDir:file.filePath rootFile:file maxScanLevel:(maxTreeLevel <= 0 ? 0 : maxTreeLevel)];
        }
    }
    
    return file;
}

+ (BOOL)fileExistWithAbsoluteFilePath:(NSString *)absoluteFilePath {
    
    BOOL isDirectory = NO;
    BOOL isExist     = [[NSFileManager defaultManager] fileExistsAtPath:absoluteFilePath isDirectory:&isDirectory];
    
    return isExist;
}

+ (NSString *)bundleFileWithName:(NSString *)name {
    
    return [[NSBundle mainBundle] pathForResource:name ofType:nil];
}

+ (File *)cerateFileWithFilePath:(NSString *)filePath isDirectory:(BOOL)isDirectory {
    
    File *file        = [[File alloc] init];
    file.filePath     = filePath;
    file.fileName     = [filePath lastPathComponent];
    file.isDirectory  = isDirectory;
    file.level        = 0;
    file.fileUrl      = [[NSURL alloc] initFileURLWithPath:filePath isDirectory:isDirectory];
    
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    file.attributes   = dic;
    
    NSArray *componentsStrings = [file.fileName componentsSeparatedByString:@"."];
    if (componentsStrings.count >= 2) {
        
        NSString *lastString   = componentsStrings.lastObject;
        file.name              = [file.fileName substringWithRange:NSMakeRange(0, file.fileName.length - lastString.length - 1)];
        file.filenameExtension = lastString;
        
    } else {
        
        file.name = file.fileName;
    }
    
    if ([file.fileName characterAtIndex:0] == '.') {
        
        file.isHiden = YES;
    }
    
    return file;
}

+ (void)scanDir:(NSString *)dirPath rootFile:(File *)rootFile maxScanLevel:(NSInteger)maxLevel {
    
    if (maxLevel <= rootFile.level) {
        
        return;
    }
    
    NSFileManager *localFileManager = [[NSFileManager alloc] init];
    NSArray       *array            = [localFileManager contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *relatedPath in array) {
        
        NSString *fullPath = [rootFile.filePath stringByAppendingPathComponent:relatedPath];
        
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDirectory];
        
        File *file = [FileManager cerateFileWithFilePath:fullPath isDirectory:isDirectory];
        file.level = rootFile.level + 1;
        
        if (file.isDirectory) {
            
            [FileManager scanDir:file.filePath rootFile:file maxScanLevel:maxLevel];
        }
        
        [rootFile.subFiles addObject:file];
    }
}

+ (NSString *)absoluteFilePathFromRelativeFilePath:(NSString *)relativeFilePath {
    
    NSString *rootPath = nil;
    
    if (relativeFilePath.length) {
        
        if ([relativeFilePath characterAtIndex:0] == '~') {
            
            rootPath = [relativeFilePath stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:NSHomeDirectory()];
            
        } else if ([relativeFilePath characterAtIndex:0] == '-') {
            
            rootPath = [relativeFilePath stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[NSBundle mainBundle] bundlePath]];
            
        } else {
            
            rootPath = nil;
        }
        
    } else {
        
        rootPath = NSHomeDirectory();
    }
    
    return rootPath;
}

@end

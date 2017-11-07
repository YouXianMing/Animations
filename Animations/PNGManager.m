//
//  PNGManager.m
//  PNGIconsCompressTool
//
//  Created by YouXianMing on 2017/11/7.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "PNGManager.h"
#import "FileManager.h"
#import "RegexManager.h"

@implementation PNGManager

+ (void)createPNGsWithSourceImage:(UIImage *)sourceImage pngsBlock:(void (^)(NSMutableArray <PNG *> *pngs))pngsBlock {
    
    NSParameterAssert(sourceImage);
    NSParameterAssert(pngsBlock);
    
    NSMutableArray <PNG *> *pngs = [NSMutableArray array];
    pngsBlock(pngs);
    
    NSString *path = filePath(@"~/Documents/");
    [pngs enumerateObjectsUsingBlock:^(PNG *png, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableString *file = [NSMutableString string];
        
        // 去除字符串两边空格
        NSString *trimString = [png.fileName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        // 替换字符串中间的空格为_
        NSString *newString  = [trimString replacingWithPattern:@" +" template:@"_"];
        
        // 拼接文件名
        [file appendFormat:@"%@_%.1fpt", newString, png.basePt];
        if ([file existWithRegexPattern:@"[.]0pt$"]) {
            
            [file replaceCharactersInRange:NSMakeRange(file.length - 4, 4) withString:@"pt"];
        }
        
        if (png.multiply <= 1) {
            
            [file appendString:@".png"];
            
        } else {
            
            [file appendFormat:@"@%ldx.png",(long)png.multiply];
        }
        
        // 获取PNG图片
        NSData *imageData = UIImagePNGRepresentation([PNGManager imageWithImage:sourceImage
                                                                   scaledToSize:CGSizeMake(png.basePt * png.multiply,
                                                                                           png.basePt * png.multiply)]);
        
        // 写文件
        if ([imageData writeToFile:[path stringByAppendingString:file] atomically:YES]) {
            
            NSLog(@"[OK] %@", file);
            
        } else {
            
            NSLog(@"[ERROR] %@", file);
        }
    }];
    
    NSLog(@"生成文件所在路径:\n%@", path);
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end


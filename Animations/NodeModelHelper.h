//
//  NodeModelHelper.h
//  TextCapital
//
//  Created by YouXianMing on 15/11/11.
//  Copyright © 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//
//// Used in swift
//
//let data     = NSData(contentsOfURL: NSURL(string: "http://www.duitang.com/album/1733789/masn/p/0/100/")!)
//let jsonData = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! [String : AnyObject]
//NodeModelHelper.jsonData(jsonData, rootModelName: "ResposeData")

@interface NodeModelHelper : NSObject

/**
 *  获取json数据并推出控制器
 *
 *  @param jsonData      json数据
 *  @param rootModelName model名字
 */
+ (void)jsonData:(NSDictionary *)jsonData rootModelName:(NSString *)rootModelName;

/**
 *  生成json数据
 *
 *  @param jsonData json数据
 */
+ (void)ceateJsonData:(NSDictionary *)jsonData;

@end

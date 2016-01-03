//
//  NodeModel.m
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "NodeModel.h"

static NSPointerArray   *_pointerArray;

@interface NodeModel ()

@property (nonatomic, strong) NSMutableArray <PropertyInfomation *>  *properties;

@end

@implementation NodeModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.normalProperties        = [NSMutableDictionary dictionary];
        self.dictionaryTypeModelList = [NSMutableDictionary dictionary];
        self.arrayTypeModelList      = [NSMutableDictionary dictionary];
        
        self.properties = [NSMutableArray array];
    }
    
    return self;
}

- (void)accessDictionary:(NSDictionary *)dictionary {
    
    if (dictionary == nil) {
        
        return;
    }
    
    // 处理普通的属性
    {
        NSEnumerator *numerator = [dictionary keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            if ([dictionary[key] isKindOfClass:[NSString class]]) {
                
                self.normalProperties[key] = stringType;
                
            } else if ([dictionary[key] isKindOfClass:[NSNumber class]]) {
                
                self.normalProperties[key] = numberType;
                
            } else if ([dictionary[key] isKindOfClass:[NSNull class]]) {
                
                self.normalProperties[key] = nullType;
            }
        }
    }
    
    // 处理字典的属性
    {
        NSEnumerator *numerator = [dictionary keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            if ([dictionary[key] isKindOfClass:[NSDictionary class]]) {
                
                NodeModel *nodeModel = [[NodeModel alloc] init];
                nodeModel.level      = self.level + 1;
                nodeModel.listType   = key;
                nodeModel.modelName  = [key stringByAppendingString:@"Model"];
                
                NSString *firstC    = [nodeModel.modelName substringWithRange:NSMakeRange(0, 1)];
                firstC              = firstC.capitalizedString;
                nodeModel.modelName = [nodeModel.modelName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstC];
                
                [nodeModel accessDictionary:dictionary[key]];
                
                self.dictionaryTypeModelList[key] = nodeModel;
            }
        }
    }
    
    // 处理数组的属性
    {
        NSEnumerator *numerator = [dictionary keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            if ([dictionary[key] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = dictionary[key];
                
                if (array.count && [array[0] isKindOfClass:[NSDictionary class]]) {
                    
                    NodeModel *nodeModel = [[NodeModel alloc] init];
                    nodeModel.level      = self.level + 1;
                    nodeModel.listType   = key;
                    nodeModel.modelName  = [key stringByAppendingString:@"Model"];
                    
                    NSString *firstC    = [nodeModel.modelName substringWithRange:NSMakeRange(0, 1)];
                    firstC              = firstC.capitalizedString;
                    nodeModel.modelName = [nodeModel.modelName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstC];
                    
                    [nodeModel accessDictionary:array[0]];
                    
                    self.arrayTypeModelList[key] = nodeModel;
                    
                } else {
                
                    NodeModel *nodeModel = [[NodeModel alloc] init];
                    nodeModel.level      = self.level + 1;
                    nodeModel.listType   = key;
                    nodeModel.modelName  = [key stringByAppendingString:@"Model"];
                    
                    NSString *firstC    = [nodeModel.modelName substringWithRange:NSMakeRange(0, 1)];
                    firstC              = firstC.capitalizedString;
                    nodeModel.modelName = [nodeModel.modelName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstC];
                    
                    [nodeModel accessDictionary:nil];
                    
                    self.arrayTypeModelList[key] = nodeModel;
                }
            }
        }
    }
}

+ (instancetype)nodeModelWithDictionary:(NSDictionary *)dictionary
                              modelName:(NSString *)name
                                  level:(NSInteger)level {
    
    NodeModel *nodeModel = [[[self class] alloc] init];
    nodeModel.modelName  = name;
    nodeModel.level      = level;
    
    [nodeModel accessDictionary:dictionary];
    
    return nodeModel;
}

- (NSMutableArray<PropertyInfomation *> *)properties {
    
    if (_properties.count) {
        
        return _properties;
    }
    
    // 处理普通的属性
    {
        NSEnumerator *numerator = [self.normalProperties keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            NSString *stringValue = self.normalProperties[key];
            
            if ([stringValue isEqualToString:stringType]) {
                
                [_properties addObject:[PropertyInfomation propertyInfomationWithPropertyType:kNSString
                                                                                propertyValue:key]];
                
            } else if ([stringValue isEqualToString:numberType]) {
                
                [_properties addObject:[PropertyInfomation propertyInfomationWithPropertyType:kNSNumber
                                                                                propertyValue:key]];
                
            } else if ([stringValue isEqualToString:nullType]) {
                
                [_properties addObject:[PropertyInfomation propertyInfomationWithPropertyType:kNull
                                                                                propertyValue:key]];
            }
        }
    }
    
    // 处理字典的属性
    {
        NSEnumerator *numerator = [self.dictionaryTypeModelList keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            [_properties addObject:[PropertyInfomation propertyInfomationWithPropertyType:kNSDictionary
                                                                            propertyValue:self.dictionaryTypeModelList[key]]];
        }
    }
    
    // 处理字典的属性
    {
        NSEnumerator *numerator = [self.arrayTypeModelList keyEnumerator];
        NSString     *key       = nil;
        
        while (key = [numerator nextObject]) {
            
            [_properties addObject:[PropertyInfomation propertyInfomationWithPropertyType:kNSArray
                                                                            propertyValue:self.arrayTypeModelList[key]]];
        }
    }
    
    return _properties;
}

/**
 *  遍历节点
 */
- (void)traverseNode {

    [_pointerArray addPointer:(__bridge void * _Nullable)(self)];
    
    for (PropertyInfomation *info in self.properties) {
        
        if (info.propertyType == kNSArray || info.propertyType == kNSDictionary) {
            
            NodeModel *nodeModel = info.propertyValue;
            [nodeModel traverseNode];
        }
    }
}

/**
 *  所有子节点
 *
 *  @return 数组
 */
- (NSArray *)allSubNodes {

    _pointerArray = [NSPointerArray weakObjectsPointerArray];
    
    [self traverseNode];
    
    return _pointerArray.allObjects;
}

@end

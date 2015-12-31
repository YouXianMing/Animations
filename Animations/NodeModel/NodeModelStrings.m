//
//  NodeModelStrings.m
//  Create-JSON-Model
//
//  Created by YouXianMing on 15/11/11.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "NodeModelStrings.h"

@interface NodeModelStrings ()

@property (nonatomic, strong) NSDictionary *nodeModelStringsPlist;

@property (nonatomic, strong) NSString     *modelHeaderFileString;
@property (nonatomic, strong) NSString     *modelMFileString;

@property (nonatomic, strong) NSString     *modelSwiftTotalFileString;

@end

@implementation NodeModelStrings

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.nodeModelStringsPlist = [self accessModelPlist];
        self.modelHeaderFileString = self.nodeModelStringsPlist[@"modelHeaderFileString"];
        self.modelMFileString      = self.nodeModelStringsPlist[@"modelMFileString"];
        
        self.modelSwiftTotalFileString = self.nodeModelStringsPlist[@"SwiftTotalFile"];
    }
    
    return self;
}

+ (instancetype)nodeModelStringsWithNodeModel:(NodeModel *)nodeModel {
    
    NodeModelStrings *nodeModelStrings = [[self alloc] init];
    nodeModelStrings.nodeModel         = nodeModel;
    
    return nodeModelStrings;
}

/**
 *  获取plist文件
 *
 *  @return 字典
 */
- (NSDictionary *)accessModelPlist {
    
    NSString     *path = [[NSBundle mainBundle] pathForResource:@"NodeModelStrings.plist" ofType:nil];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return data;
}

- (void)createFile {
    
    [self createSwiftFile];
    [self createOBjectiveCFile];
}

- (void)createSwiftFile {

    // 替换文件名字
    NSString *fileName             = self.nodeModel.modelName;
    self.modelSwiftTotalFileString = [self.modelSwiftTotalFileString stringByReplacingOccurrencesOfString:@"[Swift-Model-Name]"
                                                                                               withString:fileName];
    // 替换头文件属性
    NSString *propetiesString = @"";
    for (PropertyInfomation *property in self.nodeModel.properties) {
        
        switch (property.propertyType) {
                
            case kNSString: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"    var %@  : String?\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSNumber: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"    var %@  : NSNumber?\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNull: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"    // key \"%@\" has null value.\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSDictionary: {
                
                NodeModel *nodeModel = property.propertyValue;
                NSString *tmpSting   = [NSString stringWithFormat:@"    var %@  : %@?\n", nodeModel.listType, nodeModel.modelName];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSArray:{
                
                NodeModel *nodeModel = property.propertyValue;
                NSString *tmpSting   = [NSString stringWithFormat:@"    var %@  : [%@]?\n", nodeModel.listType, nodeModel.modelName];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            default:
                break;
        }
    }
    self.modelSwiftTotalFileString = [self.modelSwiftTotalFileString stringByReplacingOccurrencesOfString:@"[Swift-Stored-Propety]"
                                                                                               withString:propetiesString];
    
    // 替换实现文件
    NSMutableString *mPropertyString = [NSMutableString string];
    for (PropertyInfomation *property in self.nodeModel.properties) {
                
        if (property.propertyType == kNSDictionary) {
            
            NodeModel *nodeModel      = property.propertyValue;
            NSString *listTypeString  = [NSString stringWithFormat:@"%@\n", self.nodeModelStringsPlist[@"SwiftDictionaryTypeString"]];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[Swift-Dictionary-Key]" withString:nodeModel.listType];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[Swift-Model-Name]" withString:nodeModel.modelName];
            
            [mPropertyString appendString:listTypeString];
        }
        
        if (property.propertyType == kNSArray) {
            
            NodeModel *nodeModel      = property.propertyValue;
            NSString *listTypeString  = [NSString stringWithFormat:@"%@\n", self.nodeModelStringsPlist[@"SwiftArrayTypeString"]];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[Swift-Array-Key]" withString:nodeModel.listType];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[Swift-Model-Name]" withString:nodeModel.modelName];
            
            [mPropertyString appendString:listTypeString];
        }
    }
    
    self.modelSwiftTotalFileString = [self.modelSwiftTotalFileString stringByReplacingOccurrencesOfString:@"[Swift-List-Type-Propety]"
                                                                                               withString:mPropertyString];
    
    [self.modelSwiftTotalFileString writeToFile:[self filePathWithFileName:[self.nodeModel.modelName stringByAppendingString:@".swift"]]
                            atomically:YES
                              encoding:NSUTF8StringEncoding
                                 error:nil];
}

- (void)createOBjectiveCFile {

    // 替换文件名字
    NSString *fileName         = self.nodeModel.modelName;
    self.modelHeaderFileString = [self.modelHeaderFileString stringByReplacingOccurrencesOfString:@"[ModelName-WaitForReplaced]"
                                                                                       withString:fileName];
    self.modelMFileString      = [self.modelMFileString stringByReplacingOccurrencesOfString:@"[ModelName-WaitForReplaced]"
                                                                                  withString:fileName];
    
    // 导入头文件字符串
    NSString *inputHeaderString = @"";
    for (PropertyInfomation *property in self.nodeModel.properties) {
        
        if (property.propertyType == kNSDictionary || property.propertyType == kNSArray) {
            
            NodeModel *node        = property.propertyValue;
            NSString *importString = [NSString stringWithFormat:@"#import \"%@.h\"\n", node.modelName];
            inputHeaderString      = [inputHeaderString stringByAppendingString:importString];
        }
    }
    self.modelHeaderFileString = [self.modelHeaderFileString stringByReplacingOccurrencesOfString:@"[FileHeaders-WaitForReplaced]"
                                                                                       withString:inputHeaderString];
    
    
    // 替换头文件属性
    NSString *propetiesString = @"";
    for (PropertyInfomation *property in self.nodeModel.properties) {
        
        switch (property.propertyType) {
                
            case kNSString: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSNumber: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"@property (nonatomic, strong) NSNumber *%@;\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNull: {
                
                NSString *tmpSting = [NSString stringWithFormat:@"// @property (nonatomic, strong) Null *%@;\n", property.propertyValue];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSDictionary: {
                
                NodeModel *nodeModel = property.propertyValue;
                NSString *tmpSting = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;\n", nodeModel.modelName, nodeModel.listType];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            case kNSArray:{
                
                NodeModel *nodeModel = property.propertyValue;
                NSString *tmpSting = [NSString stringWithFormat:@"@property (nonatomic, strong) NSMutableArray <%@ *> *%@;\n", nodeModel.modelName, nodeModel.listType];
                propetiesString = [propetiesString stringByAppendingString:tmpSting];
                
            } break;
                
            default:
                break;
        }
    }
    self.modelHeaderFileString = [self.modelHeaderFileString stringByReplacingOccurrencesOfString:@"[PropertiesList-WaitForReplaced]"
                                                                                       withString:propetiesString];
    
    
    // 替换实现文件
    NSMutableString *mPropertyString = [NSMutableString string];
    for (PropertyInfomation *property in self.nodeModel.properties) {
        
        if (property.propertyType == kNSArray) {
            
            NodeModel *nodeModel      = property.propertyValue;
            NSString *listTypeString  = [NSString stringWithFormat:@"%@\n", self.nodeModelStringsPlist[@"arrayTypeString"]];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[PropertyName]" withString:nodeModel.listType];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[PropertyClass]" withString:nodeModel.modelName];
            
            [mPropertyString appendString:listTypeString];
        }
        
        if (property.propertyType == kNSDictionary) {
            
            NodeModel *nodeModel      = property.propertyValue;
            NSString *listTypeString  = [NSString stringWithFormat:@"%@\n", self.nodeModelStringsPlist[@"dictionaryTypeString"]];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[PropertyName]" withString:nodeModel.listType];
            listTypeString = [listTypeString stringByReplacingOccurrencesOfString:@"[PropertyClass]" withString:nodeModel.modelName];
            
            [mPropertyString appendString:listTypeString];
        }
    }
    self.modelMFileString = [self.modelMFileString stringByReplacingOccurrencesOfString:@"[ListProperties-WaitForReplaced]"
                                                                             withString:mPropertyString];
    
    [self.modelHeaderFileString writeToFile:[self filePathWithFileName:[self.nodeModel.modelName stringByAppendingString:@".h"]]
                                 atomically:YES
                                   encoding:NSUTF8StringEncoding
                                      error:nil];
    
    [self.modelMFileString writeToFile:[self filePathWithFileName:[self.nodeModel.modelName stringByAppendingString:@".m"]]
                            atomically:YES
                              encoding:NSUTF8StringEncoding
                                 error:nil];

}

- (void)string:(NSString *)string replaceString:(NSString *)replaceString withString:(NSString *)newString {
    
    [string stringByReplacingOccurrencesOfString:replaceString
                                      withString:newString];
}

- (NSString *)filePathWithFileName:(NSString *)name {
    
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@", name]];
}

@end

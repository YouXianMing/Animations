//
//  StudyInfoModel.h
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedStringConfigHelper.h"
#import "UIFont+Fonts.h"
#import "HexColors.h"

@interface StudyTimeModel : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic)         CGFloat   percent;

@property (nonatomic, strong) NSMutableAttributedString  *percentString;
@property (nonatomic, strong) NSMutableAttributedString  *timeString;

@end

NS_INLINE StudyTimeModel *studyTimeModel(NSString *time, CGFloat percent) {
    
    StudyTimeModel *model = [StudyTimeModel new];
    model.time            = time;
    model.percent         = percent;
    
    model.percentString = [NSMutableAttributedString mutableAttributedStringWithString:[NSString stringWithFormat:@"%.f%%", model.percent * 100.f] config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:12.f] range:NSMakeRange(0, string.length)]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:6.f] range:NSMakeRange(string.length - 1, 1)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor colorWithHexString:@"#FFB03B"] range:NSMakeRange(0, string.length)]];
    }];
    
    model.timeString = [NSMutableAttributedString mutableAttributedStringWithString:time config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:8.f] range:NSMakeRange(0, string.length)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f] range:NSMakeRange(0, string.length)]];
    }];
    
    return model;
}

@interface StudyInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray <StudyTimeModel *> *times;

@end


//
//  CustomCityPickerViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CustomCityPickerViewController.h"
#import "PickerCityDataManager.h"
#import "FileManager.h"
#import "NSData+JSONData.h"
#import "CustomPickerView.h"
#import "PickerViewDataAdapter.h"
#import "UIView+SetRect.h"
#import "PickerProvinceView.h"
#import "PickerCityView.h"
#import "PickerAreaView.h"

@interface CustomCityPickerViewController () <CustomPickerViewDelegate>

@property (nonatomic, strong) NSArray <PickerProvinceModel *> *provinces;

@property (nonatomic, strong) CustomPickerView      *pickerView;
@property (nonatomic, strong) PickerViewDataAdapter *pickerViewDataAdapter;

@end

@implementation CustomCityPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Get data.
    NSData  *data      = [NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"city.json"]];
    NSArray *provinces = [data toListProperty];
    self.provinces     = [PickerCityDataManager provinceModelsWithArray:provinces];
    
    // Create CustomPickerView's dataAdapter.
    self.pickerViewDataAdapter = [PickerViewDataAdapter pickerViewDataAdapterWithComponentsBlock:^(NSMutableArray<PickerViewComponent *> *components) {
        
        // Province component.
        PickerViewComponent *provinceComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces enumerateObjectsUsingBlock:^(PickerProvinceModel *provinceModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerProvinceView class] data:provinceModel]];
            }];
            
        } componentWidth:Width / 3.f - 5.f];
        
        // City component.
        PickerViewComponent *cityComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces.firstObject.cities enumerateObjectsUsingBlock:^(PickerCityModel *cityModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerCityView class] data:cityModel]];
            }];
            
        } componentWidth:Width / 3.f - 5.f];
        
        // Area component.
        PickerViewComponent *areaComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces.firstObject.cities.firstObject.areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
            }];
            
        } componentWidth:Width / 3.f - 5.f];
        
        [components addObject:provinceComponent];
        [components addObject:cityComponent];
        [components addObject:areaComponent];
        
    } rowHeight:60.f];
    
    // Create CustomPickerView.
    self.pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)
                                                     delegate:self
                                         pickerViewHeightType:kCustomPickerViewHeightTypeMax
                                                  dataAdapter:self.pickerViewDataAdapter];
    self.pickerView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.pickerView];
}

#pragma mark - CustomPickerViewDelegate

- (void)customPickerView:(CustomPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        NSMutableArray *citys = [NSMutableArray array];
        [self.provinces[row].cities enumerateObjectsUsingBlock:^(PickerCityModel *cityModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [citys addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerCityView class] data:cityModel]];
        }];
        
        NSMutableArray *areas = [NSMutableArray array];
        [self.provinces[row].cities.firstObject.areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [areas addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
        }];
        
        pickerView.pickerViewDataAdapter.components[1].rows = citys;
        pickerView.pickerViewDataAdapter.components[2].rows = areas;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if (component == 1) {
        
        NSInteger       provinceIndex = [self.pickerView selectedRowInComponent:0];
        NSMutableArray *areas         = [NSMutableArray array];
        
        // Protect crash.
        if (self.provinces[provinceIndex].cities.count <= row) {
            
            row = self.provinces[provinceIndex].cities.count - 1;
        }
        
        [self.provinces[provinceIndex].cities[row].areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [areas addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
        }];
        
        pickerView.pickerViewDataAdapter.components[2].rows = areas;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    NSLog(@"%@", datas);
}

@end

//
//  CustomPickerViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/9/4.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CustomPickerViewController.h"
#import "UIView+SetRect.h"
#import "PickerCustomView.h"
#import "PickerViewDataAdapter.h"
#import "CustomPickerView.h"
#import "CategoryInfoView.h"
#import "ShopItemInfoView.h"
#import "FileManager.h"
#import "NSData+JSONData.h"
#import "ItemManagerModel.h"
#import "CustomPickerViewControllerUserDefaults.h"

@interface CustomPickerViewController () <CustomPickerViewDelegate>

@property (nonatomic, strong) CustomPickerView      *pickerView;
@property (nonatomic, strong) PickerViewDataAdapter *pickerViewDataAdapter;
@property (nonatomic, strong) ItemManagerModel      *itemManagerModel;

@end

@implementation CustomPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Get data.
    NSData *data          = [NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"liwushuo.json"]];
    self.itemManagerModel = [[ItemManagerModel alloc] initWithDictionary:[data toListProperty]];
    [self.itemManagerModel.data.categories removeObjectAtIndex:0];
    
    // Create CustomPickerView's dataAdapter.
    self.pickerViewDataAdapter = [PickerViewDataAdapter pickerViewDataAdapterWithComponentsBlock:^(NSMutableArray<PickerViewComponent *> *components) {
        
        // First component.
        PickerViewComponent *firstComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.itemManagerModel.data.categories enumerateObjectsUsingBlock:^(CategoryModel *model, NSUInteger idx, BOOL *stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[CategoryInfoView class] data:model]];
            }];
            
        } componentWidth:Width / 3.f * 1 - 5.f];
        
        // Second component.
        PickerViewComponent *secondComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.itemManagerModel.data.categories[CustomPickerViewControllerUserDefaults.selectedRowInFirstComponent].subcategories
             enumerateObjectsUsingBlock:^(ShopItemModel *model, NSUInteger idx, BOOL *stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[ShopItemInfoView class] data:model]];
            }];
            
        } componentWidth:Width / 3.f * 2 - 5.f];
        
        [components addObject:firstComponent];
        [components addObject:secondComponent];
        
    } rowHeight:45.f];
    
    // Create CustomPickerView.
    self.pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)
                                                     delegate:self
                                         pickerViewHeightType:kCustomPickerViewHeightTypeMax
                                                  dataAdapter:self.pickerViewDataAdapter];
    self.pickerView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.pickerView];
    [self.pickerView selectRow:CustomPickerViewControllerUserDefaults.selectedRowInFirstComponent  inComponent:0 animated:NO];
    [self.pickerView selectRow:CustomPickerViewControllerUserDefaults.selectedRowInSecondComponent inComponent:1 animated:NO];
}

#pragma mark - CustomPickerViewDelegate

- (void)customPickerView:(CustomPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        NSMutableArray *rows = [NSMutableArray array];
        [self.itemManagerModel.data.categories[row].subcategories enumerateObjectsUsingBlock:^(ShopItemModel *model, NSUInteger idx, BOOL *stop) {
            
            [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[ShopItemInfoView class] data:model]];
        }];
        
        pickerView.pickerViewDataAdapter.components[1].rows = rows;
        [pickerView reloadComponent:1];
    }
}

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    NSLog(@"%@ %@", rows, datas);
    CustomPickerViewControllerUserDefaults.selectedRowInFirstComponent  = rows[0].integerValue;
    CustomPickerViewControllerUserDefaults.selectedRowInSecondComponent = rows[1].integerValue;
}

@end

//
//  NodeModelViewController.m
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "NodeModelViewController.h"
#import "NodeModelCell.h"
#import "NodeModelStrings.h"

#define  Width   [UIScreen mainScreen].bounds.size.width
#define  Height  [UIScreen mainScreen].bounds.size.height

typedef enum : NSUInteger {
    
    kNormalEditState = 0,
    kHideEditState   = 1,
    
    kCancelButton = 0x11,
    kOkButton,
    kBlackView,
    
    kShowState,
    kHideState,
    
    kBackButton,
    kCreateButton,
    
} KNodeModelViewControllerEnumValue;

@interface NodeModelViewController () <UITableViewDelegate, UITableViewDataSource, NodeModelCellDelegate>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, weak)   NodeModel    *editNodeModel;

@property (nonatomic, strong) UIButton     *blackView;
@property (nonatomic, strong) UIView       *editView;
@property (nonatomic, strong) UITextField  *editField;

@property (nonatomic) BOOL                  haveShow;

@property (nonatomic, strong) NSArray <NSString *>  *editViewFrames;

@end

@implementation NodeModelViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
    
    [self createTableView];
    
    [self createEditView];
}

- (void)delayEvent {

    self.haveShow = YES;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < self.nodeModel.properties.count; i++) {
        
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationFade];
}

- (void)setup {

    self.title = self.nodeModel.modelName;
    
    if (self.nodeModel.level == 0) {
        
        UIButton *backButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        backButton.tag             = kBackButton;
        backButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:14.f];
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        UIButton *createButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        createButton.tag             = kCreateButton;
        createButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:14.f];
        [createButton setTitle:@"Create" forState:UIControlStateNormal];
        [createButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [createButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [createButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createButton];
    }
    
    [self performSelector:@selector(delayEvent) withObject:nil afterDelay:0.45f];
}

- (void)createEditView {

    self.blackView                 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64)];
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.blackView.alpha           = 0.f;
    self.blackView.tag             = kBlackView;
    [self.blackView addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.blackView];
    
    if ([[UIApplication sharedApplication] isStatusBarHidden] == YES) {
        
        self.editViewFrames = @[NSStringFromCGRect(CGRectMake(0, 64 - 20, Width, 30)),
                                NSStringFromCGRect(CGRectMake(0, 64 - 30 - 20, Width, 30))];
        
    } else {
    
        self.editViewFrames = @[NSStringFromCGRect(CGRectMake(0, 64, Width, 30)),
                                NSStringFromCGRect(CGRectMake(0, 64 - 30, Width, 30))];
    }
    
    self.editView                 = [[UIView alloc] initWithFrame:CGRectFromString(self.editViewFrames[kHideEditState])];
    self.editView.alpha           = 0.f;
    self.editView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editView];
    
    self.editField      = [[UITextField alloc] initWithFrame:CGRectMake(10, 4, Width - 125, 22)];
    self.editField.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.f];
    [self.editView addSubview:self.editField];
    
    UIButton *cancelButton       = [[UIButton alloc] initWithFrame:CGRectMake(Width - 115, 7, 70, 16)];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.f];
    cancelButton.tag             = kCancelButton;
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.editView addSubview:cancelButton];
    
    UIButton *okButton       = [[UIButton alloc] initWithFrame:CGRectMake(Width - 55, 7, 50, 16)];
    okButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.f];
    okButton.tag             = kOkButton;
    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [okButton setTitle:@"Done" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.editView addSubview:okButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 26, Width - 125, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.editView addSubview:line];
}

- (void)createTableView {

    self.tableView                = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NodeModelCell class] forCellReuseIdentifier:nodeCellReusedString];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.haveShow == NO) {
        
        return 0;
        
    } else {
    
        return self.nodeModel.properties.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NodeModelCell *cell = [tableView dequeueReusableCellWithIdentifier:nodeCellReusedString];
    
    cell.viewController = self;
    cell.indexPath      = indexPath;
    cell.data           = self.nodeModel.properties[indexPath.row];
    cell.delegate       = self;
    [cell loadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)nodeModelCell:(NodeModelCell *)cell data:(id)data {

    self.editNodeModel         = data;
    self.editField.placeholder = self.editNodeModel.modelName;
    self.editField.text        = self.editNodeModel.modelName;
    [self.editField becomeFirstResponder];
    
    [self changeToState:kShowState];
}

#pragma mark - 
- (void)buttonsEvent:(UIButton *)button {

    [self.editField resignFirstResponder];
    
    if (button.tag == kOkButton) {
        
        if (self.editField.text.length) {
            
            self.editNodeModel.modelName = self.editField.text;
            [self.tableView reloadData];
        }
        
        [self changeToState:kHideState];
        
    } else if (button.tag == kCancelButton) {
    
        [self changeToState:kHideState];
        
    } else if (button.tag == kBlackView) {
    
        [self changeToState:kHideState];
        
    } else if (button.tag == kBackButton) {
    
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    } else if (button.tag == kCreateButton) {
    
        for (NodeModel *node in self.nodeModel.allSubNodes) {
            
            NodeModelStrings *nodeModelString = [NodeModelStrings nodeModelStringsWithNodeModel:node];
            [nodeModelString createFile];
        }
        
        NSLog(@"生成的文件在以下地址: \n%@", [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"]);
    }
}

- (void)changeToState:(KNodeModelViewControllerEnumValue)state {

    if (state == kShowState) {
        
        self.blackView.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            self.blackView.alpha = 1.f;
            self.editView.alpha  = 1.f;
            self.editView.frame  = CGRectFromString(self.editViewFrames[kNormalEditState]);
        }];
        
    } else if (state == kHideState) {
    
        self.blackView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            self.blackView.alpha = 0.f;
            self.editView.alpha  = 0.f;
            self.editView.frame  = CGRectFromString(self.editViewFrames[kHideEditState]);
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
}

@end

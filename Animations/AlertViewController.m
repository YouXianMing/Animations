//
//  AlertViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AlertViewController.h"
#import "AlertViewCollectionCell.h"
#import "UIView+SetRect.h"
#import "MessageView.h"
#import "AlertView.h"
#import "LoadingView.h"
#import "CircleLoadingView.h"

@interface AlertViewController () <BaseMessageViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray             <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation AlertViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Data source.
    self.adapters = [NSMutableArray array];
    [self.adapters addObject:[AlertViewCollectionCell dataAdapterWithData:NSStringFromClass([MessageView       class])]];
    [self.adapters addObject:[AlertViewCollectionCell dataAdapterWithData:NSStringFromClass([AlertView         class])]];
    [self.adapters addObject:[AlertViewCollectionCell dataAdapterWithData:NSStringFromClass([LoadingView       class])]];
    [self.adapters addObject:[AlertViewCollectionCell dataAdapterWithData:NSStringFromClass([CircleLoadingView class])]];

    // Layout.
    self.layout                         = [[UICollectionViewFlowLayout alloc] init];
    self.layout.minimumLineSpacing      = 0.f;
    self.layout.minimumInteritemSpacing = 0.f;
    self.layout.itemSize                = CGSizeMake(Width / 2.f, Width / 2.f);
    
    // CollectionView.
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    [self.contentView addSubview:self.collectionView];
    
    // Register CollectionCell.
    [AlertViewCollectionCell registerToCollectionView:self.collectionView];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.adapters[indexPath.row].cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath                 = indexPath;
    cell.dataAdapter               = self.adapters[indexPath.row];
    cell.data                      = self.adapters[indexPath.row].data;
    cell.indexPath                 = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    if ([adapter.data isEqualToString:NSStringFromClass([MessageView class])]) {
       
        NSString *title                  = arc4random() % 2 ? @"" : @"赤壁赋";
        NSString *content                = @"惟江上之清风，与山间之明月，\n耳得之而为声，目遇之而成色，\n取之无禁，用之不竭。";
        MessageViewObject *messageObject = MakeMessageViewObject(title, content);
        
        if (arc4random() % 2) {
            
            MessageView.build.autoHidden.disableContentViewInteraction.withMessage(messageObject).withDelegate(self).withTag(arc4random() % 100).showIn(self.windowAreaView);
            
        } else {
            
            MessageView.build.autoHidden.withMessage(messageObject).withDelegate(self).withTag(arc4random() % 100).showInKeyWindow();
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([AlertView class])]) {
    
        NSString *content                     = arc4random() % 2 ? @"Network error, please try later." : @"Drinking hot water is an excellent natural remedy for colds.";
        NSArray  *buttonTitles                = arc4random() % 2 ? @[AlertViewNormalStyle(@"Cancel"), AlertViewRedStyle(@"Confirm")] : @[AlertViewRedStyle(@"Confirm")];
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(content, buttonTitles);
        
        if (arc4random() % 2) {
            
            AlertView.build.disableContentViewInteraction.withMessage(messageObject).withDelegate(self).withTag(arc4random() % 100).showIn(self.windowAreaView);
            
        } else {
            
            AlertView.build.withMessage(messageObject).withDelegate(self).withTag(arc4random() % 100).showInKeyWindow();
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([LoadingView class])]) {
        
        if (arc4random() % 2) {

            LoadingView.build.disableContentViewInteraction.withTag(arc4random() % 100).withDelegate(self).withAutoHiddenDelay(5.f).showIn(self.windowAreaView);

        } else {

            LoadingView.build.withTag(arc4random() % 100).withDelegate(self).withAutoHiddenDelay(5.f).showInKeyWindow();
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([CircleLoadingView class])]) {
        
        if (arc4random() % 2) {
            
            CircleLoadingView.build.disableContentViewInteraction.withTag(arc4random() % 100).withDelegate(self).withAutoHiddenDelay(5.f).showIn(self.windowAreaView);
            
        } else {
            
            CircleLoadingView.build.withTag(arc4random() % 100).withDelegate(self).withAutoHiddenDelay(5.f).showInKeyWindow();
        }
    }
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    [messageView hide];
}

- (void)baseMessageViewWillAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillAppear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidAppear, contentView is %@", NSStringFromClass([messageView class]), (long)messageView.tag, NSStringFromClass([messageView.contentView class]));
}

- (void)baseMessageViewWillDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

@end

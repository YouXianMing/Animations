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

- (void)setup {
    
    [super setup];
    
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

    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.adapters[indexPath.row].cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath             = indexPath;
    cell.dataAdapter           = self.adapters[indexPath.row];
    cell.data                  = self.adapters[indexPath.row].data;
    cell.indexPath             = indexPath;
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
            
            [MessageView showAutoHiddenMessageViewWithMessageObject:messageObject delegate:self contentView:self.windowView viewTag:arc4random() % 100];
            
        } else {
            
            [MessageView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:arc4random() % 100];
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([AlertView class])]) {
    
        NSString *content                     = arc4random() % 2 ? @"Network error, please try later." : @"Drinking hot water is an excellent natural remedy for colds.";
        NSArray  *buttonTitles                = arc4random() % 2 ? @[AlertViewNormalStyle(@"Cancel"), AlertViewRedStyle(@"Confirm")] : @[AlertViewRedStyle(@"Confirm")];
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(content, buttonTitles);
        
        if (arc4random() % 2) {
            
            [AlertView showManualHiddenMessageViewWithMessageObject:messageObject delegate:self contentView:self.windowView viewTag:arc4random() % 100];
            
        } else {
            
            [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:arc4random() % 100];
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([LoadingView class])]) {
        
        if (arc4random() % 2) {
            
            [LoadingView showAutoHiddenMessageViewWithMessageObject:nil delegate:self contentView:self.windowView viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
            
        } else {
            
            [LoadingView showAutoHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
        }
        
    } else if ([adapter.data isEqualToString:NSStringFromClass([CircleLoadingView class])]) {
        
        if (arc4random() % 2) {
            
            [CircleLoadingView showAutoHiddenMessageViewWithMessageObject:nil delegate:self contentView:self.windowView viewTag:arc4random() % 100
                                                   delayAutoHidenDuration:8.f];
            
        } else {
            
            [CircleLoadingView showAutoHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
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

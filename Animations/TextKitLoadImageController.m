//
//  TextKitLoadImageController.m
//  Animations
//
//  Created by YouXianMing on 16/4/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TextKitLoadImageController.h"
#import "AttributedStringInitConfig+Constructor.h"
#import "JSAnimatedImagesView.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface TextKitLoadImageController () <JSAnimatedImagesViewDataSource>

@property (nonatomic, strong) JSAnimatedImagesView  *JSView;
@property (nonatomic, strong) NSArray               *JSViewDataSource;

@end

@implementation TextKitLoadImageController

- (void)setup {
    
    [super setup];
    
    NSString *str = @"这是发生在阿拉斯加麦肯莱国家公园的事，这个公园有日本的四国那么大，却只有一个为观光客开设的游客中心，位置就在原野正中央，公园唯一的一条道路上，每天都有许多观光客利用这个游憩场所。\n这附近是北极地松鼠的栖息地，所以每当有观光客下车，地松鼠就会跑过来讨东西吃，完全不怕人，公园管理员一再呼吁游客不要喂食地松鼠，但不管来自哪个国家的人，看到可爱机伶的地松鼠，还是会忍不住丢东西给它们吃。\n有一年，公园里竖着一个奇怪的告示牌。为什么说它奇怪呢？因为这个告示牌只有十公分高，不弯腰下去的话根本看不到，牌子开头就写着：“地松鼠们！”原来，这是写给地松鼠看的警告。\n“......你们再一直吃着人类给的食物，就会越来越胖，最后跑不动，就只好被金雕或是熊吃掉......”一想到好奇的观光客发出苦笑的脸，让我不禁莞尔。又想到在日本的动物园中，看到游客不断地往熊的笼子里丢食物，挂在旁边的“请勿喂食”标示，看起来是那么的无力。\n有人看到动物就自然而然想喂食，这种事情大家都清楚，但也有人率直的认为那是不对的行为。坚持真理是很辛苦的，不如多点想象空间，用小小的幽默来劝服人心。";
    
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:str attributes:[AttributedStringInitConfig heitiSC]];
    
    // 管理器
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [storage addLayoutManager:layoutManager];
    
    // 显示的容器(与UITextView对应)
    NSTextContainer *textContainer = [NSTextContainer new];
    CGSize size                    = CGSizeMake(Width - 20, MAXFLOAT);
    textContainer.size             = size;
    [layoutManager addTextContainer:textContainer];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, Width - 20, self.contentView.height - 20)
                                               textContainer:textContainer];
    textView.scrollEnabled                = YES;
    textView.layer.borderWidth            = 0.5f;
    textView.layer.borderColor            = [[UIColor grayColor] colorWithAlphaComponent:0.15f].CGColor;
    textView.editable                     = NO;
    textView.selectable                   = NO;
    textView.layer.masksToBounds          = NO;
    textView.showsVerticalScrollIndicator = NO;
    textView.layer.masksToBounds          = YES;
    [self.contentView addSubview:textView];
    
    CGRect imagesFrame           = CGRectMake(60, 38, textView.width - 60 * 2, 170);
    textContainer.exclusionPaths = @[[self bezierPathWithFrame:imagesFrame]];
    
    [GCDQueue executeInMainQueue:^{
        
        self.JSViewDataSource  = @[[UIImage imageNamed:@"pic_1"],
                                   [UIImage imageNamed:@"pic_2"],
                                   [UIImage imageNamed:@"pic_3"],
                                   [UIImage imageNamed:@"pic_4"]];
        self.JSView                     = [[JSAnimatedImagesView alloc] initWithFrame:imagesFrame];
        self.JSView.alpha               = 0.f;
        self.JSView.transitionDuration  = 2.f;
        self.JSView.dataSource          = self;
        self.JSView.layer.masksToBounds = YES;
        [textView addSubview:self.JSView];
        
        [UIView animateWithDuration:2.f animations:^{
            
            self.JSView.alpha = 1.f;
        }];
        
    } afterDelaySecs:0.5f];
}

- (UIBezierPath *)bezierPathWithFrame:(CGRect)frame {
    
    return [UIBezierPath bezierPathWithRect:frame];
}

- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView {
    
    return self.JSViewDataSource.count;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index {
    
    return self.JSViewDataSource[index];
}

@end

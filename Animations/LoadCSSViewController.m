//
//  LoadCSSViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/3/23.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "LoadCSSViewController.h"
#import "FileManager.h"
#import <WebKit/WebKit.h>

@interface LoadCSSViewController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *wkWebView;

@end

@implementation LoadCSSViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // Load html text from local
    NSString *path = [FileManager theRealFilePath:@"-/news/news.html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // Use WKWebView to load the html files.
    NSURL *baseURL                    = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    self.wkWebView                    = [[WKWebView alloc]initWithFrame:self.contentView.bounds];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.alpha              = 0.f;
    [self.wkWebView loadHTMLString:html baseURL:baseURL];
    [self.contentView addSubview:self.wkWebView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [UIView animateWithDuration:1.f animations:^{
        
        webView.alpha = 1.f;
    }];
}

@end

//
//  LoadCSSViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/3/23.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "LoadCSSViewController.h"
#import "FileManager.h"
#import "GCD.h"
#import "SSZipArchive.h"
#import <WebKit/WebKit.h>

typedef enum : NSUInteger {
    
    HTML_FROM_Bundle  = 0,
    HTML_FROM_Sandbox = 1,
    
} HTMLType;

@interface LoadCSSViewController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *wkWebView;

@end

@implementation LoadCSSViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    static HTMLType type = HTML_FROM_Bundle;
    
    if (type == HTML_FROM_Sandbox) {
        
        type = HTML_FROM_Bundle;
     
        GCDGroup *group = [[GCDGroup alloc] init];
        [[[GCDQueue alloc] initSerial] execute:^{
            
            if ([FileManager fileExistWithAbsoluteFilePath:absoluteFilePathFrom(@"~/Documents/news")] == NO) {
                
                [SSZipArchive unzipFileAtPath:[FileManager bundleFileWithName:@"news.zip"]
                                toDestination:absoluteFilePathFrom(@"~/Documents/")];
            }
            
        } inGroup:group];
        
        [[GCDQueue mainQueue] notify:^{
            
            // Load html text from Document.
            NSURL *htmlUrl            = [NSURL fileURLWithPath:absoluteFilePathFrom(@"~/Documents/news/news.html")];
            NSURL *relatedDocumentUrl = [NSURL fileURLWithPath:absoluteFilePathFrom(@"~/Documents/news")];
            
            // Use WKWebView to load the html files.
            self.wkWebView                    = [[WKWebView alloc]initWithFrame:self.contentView.bounds];
            self.wkWebView.navigationDelegate = self;
            self.wkWebView.alpha              = 0.f;
            [self.wkWebView loadFileURL:htmlUrl allowingReadAccessToURL:relatedDocumentUrl];
            [self.contentView addSubview:self.wkWebView];
            
        } inGroup:group];
        
    } else if (type == HTML_FROM_Bundle) {
        
        type = HTML_FROM_Sandbox;
        
        // Load html text from Bundle.
        NSURL *htmlUrl            = [NSURL fileURLWithPath:absoluteFilePathFrom(@"-/news/news.html")];
        NSURL *relatedDocumentUrl = [NSURL fileURLWithPath:absoluteFilePathFrom(@"-/news")];
        
        // Use WKWebView to load the html files.
        self.wkWebView                    = [[WKWebView alloc]initWithFrame:self.contentView.bounds];
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.alpha              = 0.f;
        [self.wkWebView loadFileURL:htmlUrl allowingReadAccessToURL:relatedDocumentUrl];
        [self.contentView addSubview:self.wkWebView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [UIView animateWithDuration:1.f animations:^{
        
        webView.alpha = 1.f;
    }];
}

@end

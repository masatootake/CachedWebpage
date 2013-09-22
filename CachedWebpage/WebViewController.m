//
//  WebViewController.m
//  CachedWebpage
//
//  Created by 大竹 雅登 on 13/09/23.
//  Copyright (c) 2013年 Masato. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // リロードボタンを追加
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonAction:)];
    [self.navigationItem setRightBarButtonItem:reloadButton animated:YES];
    
    // webViewの読み込み
    [self reloadWebView];
    
    // Progress関連の設定
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // ProgressBarを追加
    if (!_progressView) _progressView = [[UIProgressView alloc] init];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_progressView setProgressViewStyle:UIProgressViewStyleBar];
    [_progressView setProgress:0];
    [self.navigationController.navigationBar.topItem setTitleView:_progressView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // webViewの読み込みを中止
    [self.webView stopLoading];
    // くるくるを止める
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Button Action
- (void)reloadButtonAction:(UIBarButtonItem *)sender {
    [self reloadWebView];
}

#pragma mark - Reload WebView
- (void)reloadWebView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; // くるくるを始める

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]]];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; // くるくるを止める
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [_progressView setProgress:progress animated:NO];
}

@end

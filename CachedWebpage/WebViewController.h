//
//  WebViewController.h
//  CachedWebpage
//
//  Created by 大竹 雅登 on 13/09/23.
//  Copyright (c) 2013年 Masato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"

@interface WebViewController : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end

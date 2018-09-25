//
//  PluginTest.m
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//


// 扩展插件中需要引入需要的系统库
#import <LocalAuthentication/LocalAuthentication.h>
#import "UIWebView+UIImage.h"
#import "WebViewForImage.h"

@interface WebViewForImage ()<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewForImage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    UIImage * img = [webView imageForWebView];
    _webCallback(img);
    
}

@end

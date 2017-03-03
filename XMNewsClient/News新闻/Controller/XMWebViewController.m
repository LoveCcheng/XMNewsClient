//
//  XMWebViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMWebViewController.h"
#import <NJKWebViewProgress.h>

@interface XMWebViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@property (nonatomic,strong) NJKWebViewProgress *progress;

@property (nonatomic,weak) UIProgressView *progressView;

@end

@implementation XMWebViewController

-(UIWebView *)webView{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

-(void)setRightItem{
    UIBarButtonItem *right = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] HeightImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] target:self action:@selector(NavRightClick) ConteollEvent:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = right;

}
-(void)NavRightClick{
    XMLogFun;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRightItem];
    self.navigationItem.title = @"详情";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    
    UIProgressView *proView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, XMScreenW, 5)];
    proView.backgroundColor = [UIColor redColor];
    proView.tintColor = [UIColor blueColor];
    self.progressView = proView;
    [self.view addSubview:proView];
    
    self.progress = [[NJKWebViewProgress alloc]init];
    
    self.webView.delegate=self.progress;
    
    __weak typeof(self) weakSelf =self;
    self.progress.progressBlock=^(float progress){
        weakSelf.progressView.progress=progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    //将代理设置回来
    self.progress.webViewProxyDelegate=self;
}




























@end

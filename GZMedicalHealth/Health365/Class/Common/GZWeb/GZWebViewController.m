//
//  GZWebViewController.m
//  bloodCirculation
//
//  Created by Apple on 2018/1/13.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZWebViewController.h"

@interface GZWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *webView;

//@property (nonatomic, strong) TGWebProgressLayer *webProgressLayer;

@end

@implementation GZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.view addSubview:self.webView];
//    [self.navigationController.navigationBar.layer addSublayer:self.webProgressLayer];

}

//#pragma mark - WKWebViewDelegate
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    [self.webProgressLayer tg_startLoad];
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [self.webProgressLayer tg_finishedLoadWithError:error];
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    [self.webProgressLayer tg_finishedLoadWithError:nil];
//}

#pragma mark - Getter
-(WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
        _webView.navigationDelegate = self;
        
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        
        [_webView loadRequest:request];
    }
    return _webView;
}

//-(TGWebProgressLayer *)webProgressLayer
//{
//    if (_webProgressLayer == nil) {
//        _webProgressLayer = [[TGWebProgressLayer alloc] init];
//        _webProgressLayer.frame = CGRectMake(0, kNavBarHeight - 3, Main_Screen_Width, 3);
//        _webProgressLayer.strokeColor = [UIColor redColor].CGColor;
//    }
//    return _webProgressLayer;
//}
//
//#pragma mark- dealloc
//- (void)dealloc {
//
//    [self.webProgressLayer tg_closeTimer];
//    [self.webProgressLayer removeFromSuperlayer];
//    self.webProgressLayer = nil;
//}

@end

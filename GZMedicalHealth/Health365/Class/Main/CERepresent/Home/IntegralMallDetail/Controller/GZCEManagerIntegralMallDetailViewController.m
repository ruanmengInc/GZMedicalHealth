//
//  GZCEManagerIntegralMallDetailViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/10.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerIntegralMallDetailViewController.h"
#import "GZCEManagerIntegralMallDetailModel.h"

@interface GZCEManagerIntegralMallDetailViewController ()<WKNavigationDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong)WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@property (weak, nonatomic) IBOutlet UILabel *yaoNameLab;
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *qiyeLab;
@property (weak, nonatomic) IBOutlet UILabel *wenhaoLab;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *SDCycleView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, strong) UILabel *SDCNumLab;

@end

static NSInteger headerHeight = 500;

@implementation GZCEManagerIntegralMallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

    [self intefaceData];
}

- (void)setupUI
{
    [self.SDCycleView addSubview:self.SDCNumLab];
    
    [self.mainScroll addSubview:self.webView];
    self.SDCycleView.currentPageDotColor = MHColor(0, 153, 255);
    self.SDCycleView.pageDotColor = [UIColor whiteColor];
    self.SDCycleView.placeholderImage = [UIImage imageNamed:@"商品详情轮播_"];
    self.SDCycleView.autoScroll = NO;
    self.SDCycleView.showPageControl = NO;
}

- (void)intefaceData{

    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_productinfo";
    subscript[@"tiaoma"] = self.tiaoma;
    subscript[@"id"] = self.shengID;
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCEManagerIntegralMallDetailModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCEManagerIntegralMallDetailModel * responseObject) {

        [MBProgressHUD mh_hideHUDForView:self.view];
        
        self.yaoNameLab.text = responseObject.name;
        self.guigeLab.text = responseObject.tname;
        self.numLab.text = responseObject.guige;
        self.qiyeLab.text = responseObject.qiye;
        self.wenhaoLab.text = responseObject.gyzz;
        self.SDCycleView.imageURLStringsGroup = responseObject.logo;
        self.SDCNumLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self.SDCycleView.imageURLStringsGroup.count];

        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
        [self.webView loadHTMLString:[headerString stringByAppendingString:[NSString stringWithFormat:webViewHead,[NSString stringWithFormat:@"%@", responseObject.jieshao]]] baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        /// show error
        [MBProgressHUD mh_hideHUDForView:self.view];
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - WKWebViewDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id data, NSError * _Nullable error) {
        
        CGFloat height = [data floatValue];
        //ps:js可以是上面所写，也可以是document.body.scrollHeight;在WKWebView中前者offsetHeight获取自己加载的html片段，高度获取是相对准确的，但是若是加载的是原网站内容，用这个获取，会不准确，改用后者之后就可以正常显示，这个情况是我尝试了很多次方法才正常显示的
        CGRect webFrame = webView.frame;
        webFrame.size.height = height;
        webView.frame = webFrame;
        
        self.mainScroll.contentSize = CGSizeMake(kScreenWidth, height + headerHeight + 20);

        //        [self.webProgressLayer tg_finishedLoadWithError:nil];
    }];
}

#pragma mark - 轮播图事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.SDCNumLab.text = [NSString stringWithFormat:@"%ld/%lu",index + 1,(unsigned long)self.SDCycleView.imageURLStringsGroup.count];
}

#pragma mark - Getter
-(WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreenWidth, 10)];
        _webView.navigationDelegate =self;
        
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        
        [_webView sizeToFit];
    }
    return _webView;
}

-(UILabel *)SDCNumLab
{
    if (_SDCNumLab == nil) {
        _SDCNumLab = [[UILabel alloc] initWithFrame:CGRectMake(self.SDCycleView.GZ_width * KsuitParam - 50, self.SDCycleView.GZ_height * KsuitParam - 30, 50, 24)];
        _SDCNumLab.backgroundColor = MHColor(204, 204, 204);
        _SDCNumLab.layer.masksToBounds = YES;
        _SDCNumLab.layer.cornerRadius = 12;
        _SDCNumLab.textAlignment = NSTextAlignmentCenter;
        _SDCNumLab.textColor = [UIColor whiteColor];
        _SDCNumLab.font = [UIFont systemFontOfSize:14];
    }
    return _SDCNumLab;
}

@end

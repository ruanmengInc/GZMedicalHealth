//
//  GZBaseTabViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZBaseTabViewController.h"
#import "GZShoppingMallMenuView.h"
#import "CMHExampleTableTestCell.h"
#import "CMHExampleTableTest.h"
#import "CMHLiveInfo.h"

@interface GZBaseTabViewController ()

@property (nonatomic, strong) GZShoppingMallMenuView *shoppingMallMenuVC;

@end

@implementation GZBaseTabViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = YES;
        /// 支持上拉加载，下拉刷新
        self.shouldPullDownToRefresh = YES;
        self.shouldPullUpToLoadMore = YES;
        
        /// 是否在用户上拉加载后的数据 , 如果请求回来的数据`小于` pageSize， 则提示没有更多的数据.default is YES 。 如果为`NO` 则隐藏mi_footer 。 前提是` shouldMultiSections = NO `才有效。
        self.shouldEndRefreshingWithNoMoreData = NO; // NO
        self.shouldBeginRefreshing = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 236, kScreenWidth, kScreenHeight - 236);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    self.tableView.rowHeight = 55;

}

-(void)configure
{
    [super configure];
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark ------------- 上拉刷新 ---------------------
- (void)tableViewDidTriggerHeaderRefresh
{
    /// 1. 配置参数，子类重写self.subscriptHeader的Getter方法即可

    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:self.subscriptHeader.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel * responseObject) {
        
        /// 成功后才设置 self.page = 1;
        self.page = 1;
                
        /// hid HUD
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        // 添加数据
        [self tableViewDidTriggerHeaderRefreshHandle:responseObject];
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
//        [self tableViewDidFinishTriggerHeader:YES reload:YES];
        
        [self reloadData];
        [self endHeader];
        
        /// 配置 EmptyView
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:@"哈哈，空空如也~" errorInfo:nil offsetTop:NODATAPLACEHOLDERIMGOFFSETTOP_HalfScreen hasData:self.dataSource.count>0 hasError:NO reloadBlock:NULL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        /// show error
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
        
        [self reloadData];
        [self endHeader];
        
        /// 结束刷新状态
        [self tableViewDidFinishTriggerHeader:YES reload:NO];
        
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:nil errorInfo:nil offsetTop:NODATAPLACEHOLDERIMGOFFSETTOP_HalfScreen hasData:self.dataSource.count>0 hasError:YES reloadBlock:^{

            [MBProgressHUD mh_showProgressHUD:@"Loading..." addedToView:self.view];
            [self tableViewDidTriggerHeaderRefresh];
        }];
    }];
}

#pragma mark ------------- 下拉加载 ---------------------
- (void)tableViewDidTriggerFooterRefresh{
    
    /// 1. 配置参数，子类重写self.subscriptHeader的Getter方法即可
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_GET path:Healthy_365_Url parameters:self.subscriptFooter.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel * responseObject) {
        
        /// 成功后才设置 self.page += 1;
        self.page += 1;
        
        /// hid HUD
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [self tableViewDidTriggerFooterRefreshHandle:responseObject];
     
        /// 结束刷新状态
//        [self tableViewDidFinishTriggerHeader:NO reload:YES];
        
        [self reloadData];
        [self endFooter];
        
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:nil errorInfo:nil offsetTop:NODATAPLACEHOLDERIMGOFFSETTOP_HalfScreen hasData:self.dataSource.count>0 hasError:NO reloadBlock:NULL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        [self endFooter];

        /// show error
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];

        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:nil errorInfo:nil offsetTop:NODATAPLACEHOLDERIMGOFFSETTOP_HalfScreen hasData:self.dataSource.count>0 hasError:YES reloadBlock:^{

            [MBProgressHUD mh_showProgressHUD:@"Loading..." addedToView:self.view];
            [self tableViewDidTriggerHeaderRefresh];
        }];
        
        /// 结束刷新状态
        [self tableViewDidFinishTriggerHeader:NO reload:NO];
    }];
}

@end

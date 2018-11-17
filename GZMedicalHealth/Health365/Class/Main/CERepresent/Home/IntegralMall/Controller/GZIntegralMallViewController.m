//
//  GZIntegralMallViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZIntegralMallViewController.h"
#import "GZTwoSaleScanCodeViewController.h"

#import "GZCERepresentIntegralMallTableViewCell.h"

#import "GZCEManagerIntegralMallDetailViewController.h"

@interface GZIntegralMallViewController ()
{
    NSString *_cityID;

}

@end

@implementation GZIntegralMallViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = NO;
        
        /// 支持上拉加载，下拉刷新
        self.shouldPullDownToRefresh = YES;
        self.shouldPullUpToLoadMore = YES;
        
        self.shouldBeginRefreshing = NO;
        
        self.shouldEndRefreshingWithNoMoreData = NO;
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self getCityID];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.GZ_height);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

- (void)setupUI
{
    self.tableView.rowHeight = 100;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"积分规则" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(_backItemDidClicked)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCERepresentIntegralMallTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCERepresentIntegralMallTableViewCell"];
}

#pragma mark - 积分规则
- (void)_backItemDidClicked
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"积分规则";
    nav.titleNameColor = nil;
    
    CMHWebViewController *webView = [[CMHWebViewController alloc] initWithParams:nil];
    webView.shouldDisableWebViewTitle = YES;
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - 根据市名获取id
- (void)getCityID
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"get_pro_id";
    subscript[@"name"] = self.shengCity;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];

    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        _cityID = responseObject.id;

        [self tableViewDidTriggerHeaderRefresh];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        /// show error
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - 事件处理Or辅助方法
- (void)tableViewDidTriggerHeaderRefresh{
    
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_products";
    subscript[@"id"] = _cityID;
    subscript[@"index"] = @"1";
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> * responseObject) {
        
        /// 成功后才设置 self.page = 1;
        self.page = 1;
        /// 添加数据
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:responseObject];
        
        [self reloadData];
        [self endHeader];
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        /// 配置 EmptyView
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:@"客官别急~，一大波小姐姐正在赶来的路上" errorInfo:nil offsetTop:250 hasData:self.dataSource.count>0 hasError:NO reloadBlock:NULL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self.dataSource removeAllObjects];
        [self reloadData];
        [self endFooter];
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        /// 配置 EmptyView
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:nil errorInfo:[NSError mh_tipsFromError:error] offsetTop:250 hasData:self.dataSource.count>0 hasError:YES reloadBlock:NULL];
    }];
}

- (void)tableViewDidTriggerFooterRefresh{
    /// 下拉加载事件 子类重写
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_products";
    subscript[@"id"] = _cityID;
    subscript[@"index"] = @(self.page + 1);
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:YES success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> * responseObject) {
        /// 成功后才设置 self.page += 1;
        self.page += 1;
        /// 添加数据集
        [self.dataSource addObjectsFromArray:responseObject];
        [self reloadData];
        [self endFooter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        /// show error
        [self tableViewDidFinishTriggerHeader:NO reload:YES];
    }];
}


/// 生成一个可复用的cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCERepresentIntegralMallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCERepresentIntegralMallTableViewCell" forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"药店";
    nav.titleNameColor = nil;

    GZCEManagerIntegralMallDetailViewController *vc = [GZCEManagerIntegralMallDetailViewController new];

    GZCERepresentBaseModel *model = self.dataSource[indexPath.row];
    
    vc.tiaoma = model.tiaoma;
    vc.shengID = _cityID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

//此界面内存泄漏，MLeaksFinder框架检测到
//如果您的类设计为单例对象，或者由于某种原因您的类的对象不应该被解除锁定，那么通过返回NO，覆盖-（BOOL）willDealloc在您的类中。
- (BOOL)willDealloc {
    return NO;
}

@end

//
//  GZManagerMonthlyAchievementLeftViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZManagerMonthlyAchievementLeftViewController.h"
#import "UIViewController+YNPageExtend.h"
#import "GZCERepresentMyPointsLeftViewController.h"

#import "GZCERepresentMonthlyAchievementsTableViewCell.h"

#import "GZManagerAchievementsDayViewController.h"


@interface GZManagerMonthlyAchievementLeftViewController ()

@end

@implementation GZManagerMonthlyAchievementLeftViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.headerView.titLab.text = [NSString stringWithFormat:@"%@消费积分",self.name];

    [self tableViewDidTriggerHeaderRefresh];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.tableView.rowHeight = 60;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCERepresentMonthlyAchievementsTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell"];
}

#pragma mark - 事件处理Or辅助方法
- (void)tableViewDidTriggerHeaderRefresh{
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_ce_monthjixiao";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    subscript[@"index"] = @(1);
    subscript[@"type"] = @"1";
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel * responseObject) {
        
        /// 成功后才设置 self.page = 1;
        self.page = 1;
        /// 添加数据
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:responseObject.list];
        
        self.headerView.jifenLab.text = [NSString stringWithFormat:@"%.2f",responseObject.sumjixiao];

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
    subscript[@"action"] = @"user_ce_monthjixiao";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    subscript[@"index"] = @(self.page + 1);
    subscript[@"type"] = @"1";

    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:YES success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel * responseObject) {
        /// 成功后才设置 self.page += 1;
        self.page += 1;
        /// 添加数据集
        [self.dataSource addObjectsFromArray:responseObject.list];
        [self reloadData];
        [self endFooter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        /// show error
        [self tableViewDidFinishTriggerHeader:NO reload:YES];
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GZCERepresentMonthlyAchievementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell" forIndexPath:indexPath];
    
    cell.dic = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GZManagerAchievementsDayViewController *temp = [[GZManagerAchievementsDayViewController alloc] initWithParams:nil];
    
    temp.year = self.dataSource[indexPath.row][@"year"];
    temp.mouth = self.dataSource[indexPath.row][@"month"];
    temp.type = @"1";

    [self.navigationController pushViewController:temp animated:YES];
}

@end

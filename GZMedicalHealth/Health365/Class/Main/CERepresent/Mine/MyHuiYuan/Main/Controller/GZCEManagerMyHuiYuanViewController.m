//
//  GZCEManagerMyHuiYuanViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerMyHuiYuanViewController.h"
#import "GZDayAchievementsViewController.h"
#import "GZCERepresentAchievementsView.h"
#import "GZCERepresentMonthlyAchievementsTableViewCell.h"

#import "GZCEManagerMyHuiYuanView.h"

#import "GZCEManagerMyHuiYuanTableViewCell.h"

#import "GZManagerAchievementsViewTwoController.h"

@interface GZCEManagerMyHuiYuanViewController ()

@property (nonatomic, strong) GZCEManagerMyHuiYuanView *headerView;

@end

@implementation GZCEManagerMyHuiYuanViewController

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
        
        /// 是否在用户上拉加载后的数据 , 如果请求回来的数据`小于` pageSize， 则提示没有更多的数据.default is YES 。 如果为`NO` 则隐藏mi_footer 。 前提是` shouldMultiSections = NO `才有效。
        self.shouldEndRefreshingWithNoMoreData = NO; // NO
        self.shouldBeginRefreshing = NO;
        self.prefersNavigationBarBottomLineColor = [UIColor clearColor];
        self.prefersNavigationBarBottomLineHidden = YES;
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:27]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 172;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCEManagerMyHuiYuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCEManagerMyHuiYuanTableViewCell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, -kTopHeight, kScreenWidth, kScreenHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

-(void)tableViewDidTriggerHeaderRefreshHandle:(GZCERepresentBaseModel *)responseObject
{
    self.headerView.jifenLab.text = [NSString stringWithFormat:@"%@",responseObject.count];
    
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:responseObject.list];
}

-(void)tableViewDidTriggerFooterRefreshHandle:(GZCERepresentBaseModel *)responseObject
{
    /// 添加数据集
    [self.dataSource addObjectsFromArray:responseObject.list];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCEManagerMyHuiYuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCEManagerMyHuiYuanTableViewCell" forIndexPath:indexPath];
    
    cell.telBtn.tag = indexPath.row;
    
    cell.hourDic = self.dataSource[indexPath.row];
    
    cell.btnEventsBlock = ^(NSInteger tag) {
      
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", self.dataSource[tag][@"tel"]];
    
        UIWebView * callWebview = [[UIWebView alloc] init];
    
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
        [self.view addSubview:callWebview];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

#pragma mark - 事件处理Or辅助方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y < 163){
        
        self.title = @"";
        
    }else
    {
        
        self.title = self.headerView.jifenLab.text;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = nil;
    nav.titleNameColor = nil;
    
    GZManagerAchievementsViewTwoController *vc = [GZManagerAchievementsViewTwoController new];
    
    vc.pageIndex = 0;
    
    vc.huiID = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"id"]];
    vc.name = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"name"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter
-(CMHKeyedSubscript *)subscriptHeader
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_daibiaohuiyuan";
    subscript[@"index"] = @"1";
    subscript[@"id"] = [GZTool isNotLoginUid];
    
    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_daibiaohuiyuan";
    subscript[@"index"] = @(self.page + 1);
    subscript[@"id"] = [GZTool isNotLoginUid];
    
    return subscript;
}

-(GZCEManagerMyHuiYuanView *)headerView
{
    if (_headerView == nil) {
        _headerView = [GZCEManagerMyHuiYuanView createGZCEManagerMyHuiYuanView];
    }
    return _headerView;
}

@end


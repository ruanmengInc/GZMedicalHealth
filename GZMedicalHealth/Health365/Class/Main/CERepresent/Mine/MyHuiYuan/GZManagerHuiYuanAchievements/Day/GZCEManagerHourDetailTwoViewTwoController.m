//
//  GZCEManagerHourDetailTwoViewTwoController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerHourDetailTwoViewTwoController.h"
#import "GZCERepresentAchievementsView.h"

#import "GZCEManagerHourDetailTwoTableViewCell.h"

#import "GZManagerAchievementsViewController.h"

@interface GZCEManagerHourDetailTwoViewTwoController ()

@property (nonatomic, strong) GZCERepresentAchievementsView *headerView;

@end

@implementation GZCEManagerHourDetailTwoViewTwoController

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
        self.prefersNavigationBarBottomLineColor = MHColor(66, 136, 226);
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"" selectTitle:nil titleColor:nil titleFont:0 imageName:@"fanhui3_" target:self action:@selector(_backItemDidClicked)];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:27]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 172;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCEManagerHourDetailTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCEManagerHourDetailTwoTableViewCell"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar navBarBackGroundColor:MHColor(54, 131, 222) image:nil isOpaque:YES];//颜色
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

-(void)tableViewDidTriggerHeaderRefreshHandle:(GZCERepresentBaseModel *)responseObject
{
    self.headerView.jifenLab.text = [NSString stringWithFormat:@"%.2f",responseObject.sumjixiao];
    
    switch ([self.type integerValue]) {
        case 1:
        {
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月%@日消费积分",self.name,self.year,self.mouth,self.day];
        }
            break;
            
        case 2:
        {
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月%@日可用积分",self.name,self.year,self.mouth,self.day];
            
        }
            break;
            
        case 3:
        {
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月%@日兑换使用",self.name,self.year,self.mouth,self.day];
            
        }
            break;
            
        default:
            break;
    }
    
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
    GZCEManagerHourDetailTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCEManagerHourDetailTwoTableViewCell" forIndexPath:indexPath];
    
    cell.type = self.type;
    
    cell.hourDic = self.dataSource[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - 返回跟视图
-(void)_backItemDidClicked{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[GZManagerAchievementsViewController class]]) {
            
            GZManagerAchievementsViewController *vc = (GZManagerAchievementsViewController *)controller;
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
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

#pragma mark - Getter
-(CMHKeyedSubscript *)subscriptHeader
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_hydayjifen";
    subscript[@"index"] = @"1";
    subscript[@"uid"] = self.huiID;
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
    subscript[@"day"] = self.day;
    subscript[@"type"] = self.type;
    
    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_hydayjifen";
    subscript[@"index"] = @(self.page + 1);
    subscript[@"uid"] = self.huiID;
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
    subscript[@"day"] = self.day;
    subscript[@"type"] = self.type;
    
    return subscript;
}

-(GZCERepresentAchievementsView *)headerView
{
    if (_headerView == nil) {
        _headerView = [GZCERepresentAchievementsView createGZCERepresentAchievementsView];
    }
    return _headerView;
}

@end

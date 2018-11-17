//
//  GZCEManagerHourDetailTwoViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerHourDetailTwoViewController.h"
#import "GZCERepresentAchievementsView.h"

#import "GZCEManagerHourDetailTwoTableViewCell.h"

@interface GZCEManagerHourDetailTwoViewController ()

@property (nonatomic, strong) GZCERepresentAchievementsView *headerView;

@end

@implementation GZCEManagerHourDetailTwoViewController

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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

-(void)tableViewDidTriggerHeaderRefreshHandle:(GZCERepresentBaseModel *)responseObject
{
    self.headerView.jifenLab.text = [NSString stringWithFormat:@"%.2f",responseObject.sumjixiao];
    self.headerView.titLab.text = [NSString stringWithFormat:@"%@年%@月%@日终端绩效\n%@\n%@",self.year,self.mouth,self.day,self.dianName,self.yaoName];
    
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
    return 160;
}

#pragma mark - 返回跟视图
-(void)_backItemDidClicked{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    subscript[@"action"] = @"user_ce_yp_mingxi";
    subscript[@"index"] = @"1";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
    subscript[@"day"] = self.day;
    subscript[@"tiaoma"] = self.tiaoma;
    subscript[@"type"] = self.type;
    subscript[@"id"] = self.yaoId;

    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_ce_yp_mingxi";
    subscript[@"index"] = @(self.page + 1);
    subscript[@"uid"] = [GZTool isNotLoginUid];
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
    subscript[@"day"] = self.day;
    subscript[@"tiaoma"] = self.tiaoma;
    subscript[@"type"] = self.type;
    subscript[@"id"] = self.yaoId;

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

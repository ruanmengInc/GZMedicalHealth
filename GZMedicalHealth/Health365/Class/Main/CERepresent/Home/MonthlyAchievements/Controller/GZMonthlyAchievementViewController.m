//
//  GZMonthlyAchievementViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/27.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZMonthlyAchievementViewController.h"
#import "GZDayAchievementsViewController.h"
#import "GZCERepresentAchievementsView.h"
#import "GZCERepresentMonthlyAchievementsTableViewCell.h"

@interface GZMonthlyAchievementViewController ()

@property (nonatomic, strong) GZCERepresentAchievementsView *headerView;

@end

@implementation GZMonthlyAchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:27]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 172;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCERepresentMonthlyAchievementsTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell"];
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
    GZCERepresentMonthlyAchievementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell" forIndexPath:indexPath];
    
    cell.dic = self.dataSource[indexPath.row];
    
    return cell;
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
    
    GZDayAchievementsViewController *temp = [[GZDayAchievementsViewController alloc] initWithParams:nil];
    
    temp.year = self.dataSource[indexPath.row][@"year"];
    temp.mouth = self.dataSource[indexPath.row][@"month"];

    [self.navigationController pushViewController:temp animated:YES];
}

#pragma mark - Getter
-(CMHKeyedSubscript *)subscriptHeader
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_dbjixiao";
    subscript[@"index"] = @"1";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    
    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
   
    subscript[@"action"] = @"user_365_dbjixiao";
    subscript[@"index"] = @(self.page + 1);
    subscript[@"uid"] = [GZTool isNotLoginUid];
    
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

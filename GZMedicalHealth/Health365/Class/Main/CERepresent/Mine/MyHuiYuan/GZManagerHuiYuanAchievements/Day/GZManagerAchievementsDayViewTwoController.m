//
//  GZManagerAchievementsDayViewTwoController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZManagerAchievementsDayViewTwoController.h"
#import "GZCEManagerHourDetailTwoViewController.h"
#import "GZCERepresentAchievementsView.h"

#import "GZCERepresentMonthlyAchievementsTableViewCell.h"

#import "GZManagerAchievementsViewController.h"

#import "GZCEManagerHourDetailTwoViewTwoController.h"

@interface GZManagerAchievementsDayViewTwoController ()

@property (nonatomic, strong) GZCERepresentAchievementsView *headerView;

@end

@implementation GZManagerAchievementsDayViewTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 55;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"" selectTitle:nil titleColor:nil titleFont:0 imageName:@"fanhui3_" target:self action:@selector(_backItemDidClicked)];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:27]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 172;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCERepresentMonthlyAchievementsTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell"];
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
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月消费积分",self.name,self.year,self.mouth];
        }
            break;
            
        case 2:
        {
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月惊喜积分",self.name,self.year,self.mouth];
            
        }
            break;
            
        case 3:
        {
            self.headerView.titLab.text = [NSString stringWithFormat:@"%@%@年%@月已用积分",self.name,self.year,self.mouth];
            
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
    GZCERepresentMonthlyAchievementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCERepresentMonthlyAchievementsTableViewCell" forIndexPath:indexPath];
    
    cell.type = self.type;
    
    cell.dayDic = self.dataSource[indexPath.row];
    
    return cell;
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = nil;
    nav.titleNameColor = nil;
    
    GZCEManagerHourDetailTwoViewTwoController *temp = [[GZCEManagerHourDetailTwoViewTwoController alloc] initWithParams:nil];
    temp.year = self.dataSource[indexPath.row][@"year"];
    temp.mouth = self.dataSource[indexPath.row][@"month"];
    temp.day = self.dataSource[indexPath.row][@"day"];
    temp.type = self.type;
    temp.huiID = self.huiID;
    temp.name = self.name;
    
    [self.navigationController pushViewController:temp animated:YES];
}

#pragma mark - Getter
-(CMHKeyedSubscript *)subscriptHeader
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_hymonthjifen";
    subscript[@"index"] = @"1";
    subscript[@"uid"] = self.huiID;
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
    subscript[@"type"] = self.type;
    
    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_hymonthjifen";
    subscript[@"index"] = @(self.page + 1);
    subscript[@"uid"] = self.huiID;
    subscript[@"year"] = self.year;
    subscript[@"month"] = self.mouth;
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


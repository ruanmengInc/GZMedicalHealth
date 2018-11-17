//
//  GZCERepresentMyPointsLeftTwoViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMyPointsLeftTwoViewController.h"
#import "GZCERepresentMyPointsHeaderView.h"
#import "CMHExampleTableTestCell.h"
#import "CMHExampleTableTest.h"
#import "GZHomeNavGradualChangeView.h"

@interface GZCERepresentMyPointsLeftTwoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) GZCERepresentMyPointsHeaderView *headerView;

@property (nonatomic, strong) GZHomeNavGradualChangeView *navView;

@end

@implementation GZCERepresentMyPointsLeftTwoViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    
    self.tableView.rowHeight = 55;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:27]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 172;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    self.navView.frame = CGRectMake(0, 0, kScreenWidth, kTopHeight);
}

-(void)tableViewDidTriggerHeaderRefreshHandle:(NSArray *)responseObject
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:responseObject];
}

-(void)tableViewDidTriggerFooterRefreshHandle:(NSArray *)responseObject
{
    /// 添加数据集
    [self.dataSource addObjectsFromArray:responseObject];
}

/// 生成一个可复用的cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [CMHExampleTableTestCell cellWithTableView:tableView];
}

/// 为Cell配置数据
- (void)configureCell:(CMHExampleTableTestCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    //    [cell setIndexPath:indexPath rowsInSection:self.dataSource.count];
    //    [cell configureModel:object];
}

#pragma mark - 事件处理Or辅助方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y < 163){
        
        self.title = @"";
        _navView.backgroundColor = [UIColor clearColor];
        _navView.titLab.textColor = [UIColor clearColor];
    }else
    {
        
        self.title = @"2635.00";
        
        self.navView.backgroundColor = MHColor(102, 153, 255);
        self.navView.titLab.textColor = MHColor(255, 255, 255);
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
-(CMHKeyedSubscript *)subscriptHeader
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"useridx"] = @"61856069";
    subscript[@"type"] = @(1);
    subscript[@"page"] = @(1);
    subscript[@"lat"] = @(22.54192103514200);
    subscript[@"lon"] = @(113.96939828211362);
    subscript[@"province"] = @"广东省";
    return subscript;
}

-(CMHKeyedSubscript *)subscriptFooter
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"useridx"] = @"61856069";
    subscript[@"type"] = @(1);
    subscript[@"page"] = @(self.page + 1);
    subscript[@"lat"] = @(22.54192103514200);
    subscript[@"lon"] = @(113.96939828211362);
    subscript[@"province"] = @"广东省";
    return subscript;
}

-(GZCERepresentMyPointsHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [GZCERepresentMyPointsHeaderView createGZCERepresentMyPointsHeaderView];
    }
    return _headerView;
}

- (GZHomeNavGradualChangeView *)navView {
    if (!_navView) {
        _navView = [GZHomeNavGradualChangeView createHomeNavGradualChangeView];
        _navView.backgroundColor = [UIColor clearColor];
        _navView.titLab.textColor = [UIColor clearColor];
        _navView.backRootEvents.hidden = NO;
    }
    return _navView;
}

@end

//
//  GZTwoSaleScanCodeViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZTwoSaleScanCodeViewController.h"
#import "GZTwoSaleScanCodeComplaintViewController.h"
#import "GZSalesScavengViewController.h"
#import "CMHExampleTableTestCell.h"
#import "CMHExampleTableTest.h"

@interface GZTwoSaleScanCodeViewController ()

@end

@implementation GZTwoSaleScanCodeViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 55;

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.GZ_height - 100);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark - 返回
- (IBAction)popEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:    // 继续扫描
        {
            [self.navigationController pushViewController:[GZSalesScavengViewController new] animated:YES];
        }
            break;
            
        case 11:    // 投诉
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"二次销售扫码投诉";
            nav.titleNameColor = nil;

            [self.navigationController pushViewController:[GZTwoSaleScanCodeComplaintViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
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


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    CMHExampleTableTest *et = self.dataSource[indexPath.row];
    //    CMHViewController *temp = [[CMHViewController alloc] initWithParams:nil];
    //    temp.title = [NSString stringWithFormat:@"第%ld条数据",et.idNum];
    //    [self.navigationController pushViewController:temp animated:YES];
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

@end

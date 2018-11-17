//
//  GZSalesScavengViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZSalesScavengViewController.h"
#import "CMHExampleTableTestCell.h"
#import "CMHExampleTableTest.h"

@interface GZSalesScavengViewController ()

@property (weak, nonatomic) IBOutlet UIView *hourJiXiaoView;
@property (weak, nonatomic) IBOutlet UILabel *scavengNum;
@property (weak, nonatomic) IBOutlet UILabel *promitLab;

@end

@implementation GZSalesScavengViewController

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hourJiXiaoView.hidden = YES;
    self.tableView.rowHeight = 55;
    
    NSString *str = @"8 盒";
    NSArray *arr = @[@"8"];
    self.scavengNum.attributedText = [NSAttributedString_Encapsulation changeFontAndColor:[UIFont systemFontOfSize:32] Color:MHColor(252, 255, 255) TotalString:str SubStringArray:arr];
    
    NSString *str1 = @"累计扫码 10 盒，未成功 2 盒";
    NSArray *arr1 = @[@"10",@"2"];
    self.promitLab.attributedText = [NSAttributedString_Encapsulation changeFontAndColor:[UIFont systemFontOfSize:15] Color:MHColor(255, 86, 121) TotalString:str1 SubStringArray:arr1];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 322, kScreenWidth, kScreenHeight - 322);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark - 返回
- (IBAction)popEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)tableViewDidTriggerHeaderRefreshHandle:(NSArray *)responseObject
{
    self.hourJiXiaoView.hidden = NO;
    
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

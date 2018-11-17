//
//  GZCERepresentCountyController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/2.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCountyController.h"
#import "GZPersonalDataViewController.h"
#import "GZChooseCityTableViewCell.h"
#import "GZLocationModel.h"

@interface GZCERepresentCountyController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 县 和 ID 的名字数组（刚从后台请求的第一手数据）
 */
@property (nonatomic, strong) NSMutableArray *countyArr;

@end

@implementation GZCERepresentCountyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self requestCountyData];
}

#pragma mark - 布局UI
- (void)setupUI
{
    self.tableView.tableHeaderView = [UITableView new];
    self.tableView.tableFooterView = [UITableView new];
}

#pragma mark - 请求数据
- (void)requestCountyData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"county";
    subscript[@"id"] = self.cityID;
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        // 将 省 名字和 ID 放入 self.provinceArr
        [self.countyArr addObjectsFromArray:responseObject];
        
        [self.tableView reloadData];
        
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

#pragma mark - tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countyArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GZChooseCityTableViewCell *cell = [GZChooseCityTableViewCell cellWithTable:tableView];
    
    GZCERepresentBaseModel *data = self.countyArr[indexPath.row];
    
    cell.textLabel.text = data.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCERepresentBaseModel *data = self.countyArr[indexPath.row];
    
    /// pop 到指定控制器
    for (UIViewController *controller in self.navigationController.viewControllers) {

        if ([controller isKindOfClass:[GZPersonalDataViewController class]]) {
            GZPersonalDataViewController *EditMember =(GZPersonalDataViewController *)controller;

            EditMember.provience = self.province;
            EditMember.city = self.city;
            EditMember.county = data.name;

            EditMember.provienceID = self.provinceID;
            EditMember.cityID = self.cityID;
            EditMember.countyID = data.id;
            
            EditMember.location = [NSString stringWithFormat:@"%@ %@ %@",self.province, self.city, data.name];

            [self.navigationController popToViewController:EditMember animated:YES];
        }
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - Getter
-(NSMutableArray *)countyArr
{
    if (_countyArr == nil) {
        _countyArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _countyArr;
}

@end

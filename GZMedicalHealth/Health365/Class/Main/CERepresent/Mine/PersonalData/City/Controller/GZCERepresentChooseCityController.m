//
//  GZCERepresentChooseCityController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/2.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentChooseCityController.h"
#import "GZCERepresentCountyController.h"
#import "GZChooseCityTableViewCell.h"

#import "GZCERepresentCenterViewController.h"

@interface GZCERepresentChooseCityController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


/**
 市 和 ID 的名字数组（刚从后台请求的第一手数据）
 */
@property (nonatomic, strong) NSMutableArray *cityArr;


@end

@implementation GZCERepresentChooseCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self requestCityData];
}

#pragma mark - 布局UI
- (void)setupUI
{
    
    self.mainTableView.tableHeaderView = [UITableView new];
    self.mainTableView.tableFooterView = [UITableView new];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
}

#pragma mark - 请求数据
- (void)requestCityData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"city";
    subscript[@"id"] = self.provinceID;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        // 将 省 名字和 ID 放入 self.provinceArr
        [self.cityArr addObjectsFromArray:responseObject];
        
        [self.mainTableView reloadData];
        
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
    return self.cityArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZChooseCityTableViewCell *cell = [GZChooseCityTableViewCell cellWithTable:tableView];
    
    GZCERepresentBaseModel *data = self.cityArr[indexPath.row];
    
    cell.textLabel.text = data.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.fromVC isEqualToString:@"CenterVC"]) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[GZCERepresentCenterViewController class]]) {
                GZCERepresentCenterViewController *A =(GZCERepresentCenterViewController *)controller;
                
                GZCERepresentBaseModel *data = self.cityArr[indexPath.row];

                A.cityStr = data.name;
                A.cityIDFrom = data.id;
                
                [self.navigationController popToViewController:A animated:YES];
            }
        }
        
    }else
    {
        
        GZCERepresentCountyController *countyVC = [[GZCERepresentCountyController alloc] init];
        
        GZCERepresentBaseModel *data = self.cityArr[indexPath.row];
        
        countyVC.province = self.navigationItem.title;
        countyVC.city = data.name;
        countyVC.provinceID = self.provinceID;
        countyVC.cityID = data.id;
        
        countyVC.navigationItem.title = data.name;
        
        [self.navigationController pushViewController:countyVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - Getter
-(NSMutableArray *)cityArr
{
    if (_cityArr == nil) {
        _cityArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityArr;
}

@end


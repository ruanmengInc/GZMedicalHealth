//
//  GZProvinceController.m
//  health365
//
//  Created by GuangZhou Gu on 17/8/3.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZProvinceController.h"
#import "GZChooseCityTableViewCell.h"
#import "UITableView+ZYXIndexTip.h"
#import "GZLocationModel.h"
#import "GZProvinceHeaderView.h"
#import "ChineseString.h"

#import "GZCERepresentChooseCityController.h"

#import "GZCERepresentCenterViewController.h"

@interface GZProvinceController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 索引数组
 */
@property (nonatomic, strong) NSMutableArray *indexArr;

/**
 省 和 ID 的名字数组（刚从后台请求的第一手数据）
 */
@property (nonatomic, strong) NSMutableArray *provinceArr;

@property (nonatomic, strong) NSMutableDictionary *cityIDDic;

@property (nonatomic, strong) NSMutableArray *nameArr;

/**
 省和对应的ID数组 （转换成 字母 - 数组）
 */
@property (nonatomic, strong) NSMutableArray *provinceAndIDArray;

@property (nonatomic, strong) GZProvinceHeaderView *headerView;

@end

@implementation GZProvinceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self cityListData];
}

#pragma mark - 布局UI
- (void)setupUI
{
    self.tableView.tableHeaderView = [UITableView new];
    self.tableView.tableFooterView = [UITableView new];
    
//    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.sectionHeaderHeight = 320;

    //修改右边索引字体的颜色
    self.tableView.sectionIndexColor = MHAlphaColor(15, 139, 227, 1.0);
}

#pragma mark - 城市列表数据
- (void)cityListData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"province";
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *>* responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        // 将 省 名字和 ID 放入 self.provinceArr
        [self.nameArr addObjectsFromArray:responseObject];

        NSMutableArray *cityName = [NSMutableArray array];

        for (GZCERepresentBaseModel *data in self.nameArr) {

            [self.cityIDDic setObject:data.id forKey:data.name];

            [cityName addObject:data.name];
        }

        self.indexArr = [ChineseString IndexArray:cityName];
        self.provinceArr = [ChineseString LetterSortArray:cityName];
        
//        [self.indexArr insertObject:@"GPS" atIndex:0];
        [self.indexArr insertObject:@"当前" atIndex:0];
        
//        [self.provinceArr insertObject:@[self.cityStr] atIndex:0];
        [self.provinceArr insertObject:@[self.cityStr] atIndex:0];
        
        [self.tableView addIndexTip];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.provinceArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.provinceArr[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZChooseCityTableViewCell *cell = [GZChooseCityTableViewCell cellWithTable:tableView];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.provinceArr[indexPath.section][indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.provinceArr[indexPath.section][indexPath.row] isEqualToString:self.cityStr]) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[GZCERepresentCenterViewController class]]) {
                GZCERepresentCenterViewController *A =(GZCERepresentCenterViewController *)controller;
                
                A.cityStr = self.provinceArr[indexPath.section][indexPath.row];
                A.cityIDFrom = self.cityID;
                
                [self.navigationController popToViewController:A animated:YES];
            }
        }
    }else
    {
        GZCERepresentChooseCityController *chooseCityVC = [[GZCERepresentChooseCityController alloc] init];
        
        chooseCityVC.provinceID = [self.cityIDDic objectForKey:self.provinceArr[indexPath.section][indexPath.row]];
        chooseCityVC.navigationItem.title = self.provinceArr[indexPath.section][indexPath.row];
        chooseCityVC.fromVC = @"CenterVC";
        
        [self.navigationController pushViewController:chooseCityVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    headerView.backgroundColor = MHColor(246, 246, 246);

    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, (headerView.GZ_height - 15) / 2, 100, 15)];

    cityLabel.text = self.indexArr[section];
    cityLabel.font = [UIFont systemFontOfSize:15];
    cityLabel.textColor = MHColor(153, 153, 153);
    cityLabel.textAlignment = NSTextAlignmentLeft;

    [headerView addSubview:cityLabel];

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

/// 右侧索引条
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArr;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return  index;
}

#pragma mark 自定义索引视图 回调处理，滚动到对应组
-(void)tableViewSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    if(self.indexArr.count <= indexPath.row){
        return;
    }
    if( 0 == indexPath.section){
        CGPoint offset =  self.tableView.contentOffset;
        offset.y = -self.tableView.contentInset.top;
        self.tableView.contentOffset = offset;
    }else{
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma mark - Getter
-(NSMutableArray *)indexArr
{
    if (_indexArr == nil) {
        _indexArr = [[NSMutableArray alloc] init];
    }
    return _indexArr;
}

-(NSMutableArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSMutableArray alloc] init];
    }
    return _provinceArr;
}

-(NSMutableArray *)provinceAndIDArray
{
    if (_provinceAndIDArray == nil) {
        _provinceAndIDArray = [[NSMutableArray alloc] init];
    }
    return _provinceAndIDArray;
}

-(NSMutableArray *)nameArr
{
    if (_nameArr == nil) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}

-(NSMutableDictionary *)cityIDDic
{
    if (_cityIDDic == nil) {
        _cityIDDic = [NSMutableDictionary dictionary];
    }
    return _cityIDDic;
}

- (GZProvinceHeaderView *)headerView {
    if (!_headerView) {
        
        _headerView = [GZProvinceHeaderView createProvinceHeaderView];
        
        kWeakSelf(self)
        _headerView.collectionPopBlock = ^(NSString *cityStr, NSString *cityID) {
            kStrongSelf(self)
            
            if (self.popBlock) {
                self.popBlock(cityStr, cityID);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    return _headerView;
}

@end

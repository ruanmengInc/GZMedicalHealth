//
//  GZCERepresentProvinceController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/2.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentProvinceController.h"
#import "GZCERepresentChooseCityController.h"
#import "GZChooseCityTableViewCell.h"
#import "UITableView+ZYXIndexTip.h"
#import "ChineseString.h"

@interface GZCERepresentProvinceController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

/**
 索引数组
 */
@property (nonatomic, strong) NSMutableArray *indexArr;

@property (nonatomic, strong) NSMutableArray *nameArr;

/**
 省 和 ID 的名字数组（刚从后台请求的第一手数据）
 */
@property (nonatomic, strong) NSMutableArray *provinceArr;

/**
 id字典
 */
@property (nonatomic, strong) NSMutableDictionary *cityIDDic;

@end

@implementation GZCERepresentProvinceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup_UI];

    [self requestProvincial_Data];
}

#pragma mark - 布局UI
- (void)setup_UI
{
    self.navigationItem.title = @"省";
    
    self.mainTableView.tableHeaderView = [UITableView new];
    self.mainTableView.tableFooterView = [UITableView new];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
}

#pragma mark - 请求省数据
- (void)requestProvincial_Data
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"province";
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        // 将 省 名字和 ID 放入 self.provinceArr
        [self.nameArr addObjectsFromArray:responseObject];
        
        NSMutableArray *cityName = [NSMutableArray array];

        for (GZCERepresentBaseModel *data in self.nameArr) {
            
            [cityName addObject:data.name];
            [self.cityIDDic setObject:data.id forKey:data.name];

        }
        
        // 转化为索引数组
        self.indexArr = [ChineseString IndexArray:cityName];
        self.provinceArr = [ChineseString LetterSortArray:cityName];
        
        //修改右边索引字体的颜色
        self.mainTableView.sectionIndexColor = MHAlphaColor(0, 0, 0, 0.7);
        [self.mainTableView addIndexTip];
        
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
    
    GZCERepresentChooseCityController *chooseCityVC = [[GZCERepresentChooseCityController alloc] init];

    chooseCityVC.provinceID = [self.cityIDDic objectForKey:self.provinceArr[indexPath.section][indexPath.row]];
    chooseCityVC.navigationItem.title = self.provinceArr[indexPath.section][indexPath.row];

    [self.navigationController pushViewController:chooseCityVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 19)];
    headerView.backgroundColor = MHAlphaColor(246, 246, 246, 1.0);
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, (headerView.GZ_height - 15) / 2, 15, 15)];
    
    cityLabel.text = self.indexArr[section];
    cityLabel.font = [UIFont systemFontOfSize:17];
    cityLabel.textColor = MHAlphaColor(153, 153, 153, 1.0);
    cityLabel.textAlignment = NSTextAlignmentCenter;
    
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

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return  index;
}

#pragma mark 自定义索引视图 回调处理，滚动到对应组
-(void)tableViewSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    if(self.indexArr.count <= indexPath.row){
        return;
    }
    if( 0 == indexPath.section){
        CGPoint offset =  self.mainTableView.contentOffset;
        offset.y = -self.mainTableView.contentInset.top;
        self.mainTableView.contentOffset = offset;
    }else{
        [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
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

@end

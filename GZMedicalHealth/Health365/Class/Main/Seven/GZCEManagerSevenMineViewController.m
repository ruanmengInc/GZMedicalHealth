//
//  GZCEManagerSevenMineViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/15.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerSevenMineViewController.h"
#import "GZPersonalDataViewController.h"
#import "GZChangePasswordViewController.h"
#import "GZFeedbackViewController.h"
#import "GZMyPointsViewController.h"
#import "GZMyMessageViewController.h"
#import "GZCERepresentSettingViewController.h"
#import "GZCERepresentMineTableViewCell.h"
#import "GZCERepresentMineHeaderView.h"

@interface GZCEManagerSevenMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) GZCERepresentMineHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

static NSString *cellID = @"cellID";

@implementation GZCEManagerSevenMineViewController

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

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self intefaceData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

-(void)configure
{
    [super configure];
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
}

#pragma mark - 界面数据
- (void)intefaceData
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_center";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        self.headerView.model =  responseObject;
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

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCERepresentMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.CEManagerIndexPath = indexPath;
    cell.CEManagerDict = self.dataArray[indexPath.row];
    cell.CEManagerMineModel = self.headerView.model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Jump360://"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Jump360://"] options:nil completionHandler:^(BOOL success) {
                    NSLog(@"嘿，我打开过了");
                }];
            }else
            {
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请安装健康360" delayTime:1.0];
            }
            
        }
            break;
            
        case 1:
        {
            //            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            //            nav.titleName = @"";
            //            nav.titleNameColor = nil;
            //            [nav hideNavigationBottomLine];
            //
            //            [self.navigationController pushViewController:[GZMyPointsViewController new] animated:YES];
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
            
        }
            break;
            
        case 2:
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
            
        }
            break;
            
        case 3:
        {
            //            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            //            nav.titleName = @"消息";
            //            nav.titleNameColor = nil;
            //            [nav showNavigationBottomLine];
            //
            //            [self.navigationController pushViewController:[GZMyMessageViewController new] animated:YES];
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
            
        }
            break;
            
        case 4:
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
        }
            break;
            
        case 5:
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
            
        }
            break;
        case 6:
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"修改密码";
            nav.titleNameColor = nil;
            
            [self.navigationController pushViewController:[GZChangePasswordViewController new] animated:YES];
        }
            break;
            
        case 7:
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"意见反馈";
            nav.titleNameColor = nil;
            
            [self.navigationController pushViewController:[GZFeedbackViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getter
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CEManagerMine" ofType:@"plist"];
        _dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    }
    return _dataArray;
}

-(GZCERepresentMineHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [GZCERepresentMineHeaderView createCERepresentMineHeaderView];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 227);
        
        kWeakSelf(self)
        _headerView.btnEventsBlock = ^(NSInteger tag) {
            kStrongSelf(self)
            
            switch (tag) {
                case 10:    // 设置
                {
                    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
                    nav.titleName = @"设置";
                    nav.titleNameColor = nil;
                    
                    [self.navigationController pushViewController:[GZCERepresentSettingViewController new] animated:YES];
                }
                    break;
                    
                case 11:    // 个人资料
                {
                    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
                    nav.titleName = @"个人资料";
                    nav.titleNameColor = nil;
                    GZPersonalDataViewController * personalVC = [GZPersonalDataViewController new];
                    
                    personalVC.model = self.headerView.model;
                    
                    [self.navigationController pushViewController:personalVC animated:YES];
                }
                    break;
                    
                    
                default:
                    break;
            }
            
        };
        
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -kStatusBarHeight, kScreenWidth, kScreenHeight - kTabBarHeight + kStatusBarHeight) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
        
        _tableView.backgroundColor = MHColorFromHexString(@"#f3f3f3");
        [_tableView registerNib:[UINib nibWithNibName:@"GZCERepresentMineTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end

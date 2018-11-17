//
//  GZCEManagerHomeViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerHomeViewController.h"
#import "GZCERepresentDiscountViewController.h"
#import "GZManagerMonthlyAchievementViewController.h"
#import "GZIntegralMallViewController.h"
#import "GZInvitingMembersViewController.h"
#import "GZScanVerificationViewController.h"
#import "JFLocation.h"

#import "GZManagerAchievementsViewController.h"

@interface GZCEManagerHomeViewController ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>
{
    NSString *_lng;
    NSString *_lat;
    NSString *_city;
    NSString *_shengCity;
}

@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UIButton *jifenBtn;

/** 城市定位管理器*/
@property (nonatomic, strong) BMKLocationManager *locationManager;


@end

@implementation GZCEManagerHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self nicknameData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"homeVC" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
   
    [self confileBaiDuMap];
}

- (void)setupUI
{
    self.navigationItem.title = @"";
    _lat = @"00000000000000000000";
    _lng = @"0";
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:@"homeVC" object:nil];
}

- (void)confileBaiDuMap
{
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"Ob1BDl5g9ol5t11ix7kzaVQENSeLBqxr" authDelegate:self];
    
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    //_locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        
        if (error)
        {
            if (error.code == BMKLocationErrorLocFailed)
            {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"定位失败，请退出重新定位" delayTime:1.0];
                return;
                
            }else if (error.code == BMKLocationErrorDenied)
            {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[健康365]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" , nil];
                alertView.delegate = self;
                alertView.tag = 1;
                [alertView show];
            }
        }
        
        
        if (location)
        {
            _shengCity = location.rgcData.province;
            _city = location.rgcData.city;
            _lat = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
            _lng = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
        }
    
    }];
}

#pragma mark - 名称数据
- (void)nicknameData
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_center";
    subscript[@"uid"] = [GZTool isNotLoginUid];
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        self.nickNameLab.text = [NSString stringWithFormat:@"你好，%@",responseObject.nickname];
        [self.jifenBtn setTitle:[NSString stringWithFormat:@"%.2f",responseObject.jixiao] forState:UIControlStateNormal];
        
//        UITabBarItem *item1 = [self.tabBarController.tabBar.items objectAtIndex:1];
//        item1.badgeValue = @"3";
//
//
//        UITabBarItem *item4 = [self.tabBarController.tabBar.items objectAtIndex:4];
//        item4.badgeValue = @"5";
        
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

- (void)terminalData
{
    if ([_lat isEqualToString:@"00000000000000000000"]) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"定位中" delayTime:1.0];
        return;
    }
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_near_terminal";
    subscript[@"lng"] = _lng;
    subscript[@"lat"] = _lat;
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
        nav.titleName = nil;
        nav.titleNameColor = nil;
        
        GZScanVerificationViewController * VC = [GZScanVerificationViewController new];
        
        VC.lat = _lat;
        VC.lng = _lng;
        VC.city = _city;
        VC.shopid = responseObject.id;
        
        [self.navigationController pushViewController:VC animated:YES];
        
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

#pragma mark - 按钮点击事件
- (IBAction)clickEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:    // 终端绩效
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = nil;
            nav.titleNameColor = nil;
            
            [self.navigationController pushViewController:[GZManagerMonthlyAchievementViewController new] animated:YES];
        }
            break;
            
        case 11:    // 积分商品
        {
            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[健康365]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" , nil];
                alertView.delegate = self;
                alertView.tag = 1;
                [alertView show];
            }else
            {
                // 设置返回名字
                CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
                nav.titleName = @"积分商品";
                nav.titleNameColor = nil;
                
                GZIntegralMallViewController *vc = [GZIntegralMallViewController new];
                
                vc.shengCity = _shengCity;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
            
        case 12:    // 扫码
        {
            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[健康365]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" , nil];
                alertView.delegate = self;
                alertView.tag = 1;
                [alertView show];
            }else
            {
                // 先判断附近是否有药店
                [self terminalData];
            }
        }
            break;
            
        case 13:    // 邀请
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = nil;
            nav.titleNameColor = nil;
            
            nav.lineColor = [UIColor clearColor];
            [nav hideNavigationBottomLine];
            [self.navigationController pushViewController:[GZInvitingMembersViewController new] animated:YES];
        }
            break;
        
        case 14:    // 终端绩效
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = nil;
            nav.titleNameColor = nil;
            
            nav.lineColor = [UIColor clearColor];
            [nav hideNavigationBottomLine];
            
            GZManagerAchievementsViewController *vc = [GZManagerAchievementsViewController new];
            
            vc.pageIndex = 0;
            vc.jifen = self.jifenBtn.titleLabel.text;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 15:    // 会员绩效
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = nil;
            nav.titleNameColor = nil;
            
            nav.lineColor = [UIColor clearColor];
            [nav hideNavigationBottomLine];
            GZManagerAchievementsViewController *vc = [GZManagerAchievementsViewController new];
            
            vc.pageIndex = 1;
            vc.jifen = self.jifenBtn.titleLabel.text;

            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 16:    // 未扫绩效
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = nil;
            nav.titleNameColor = nil;
            
            nav.lineColor = [UIColor clearColor];
            [nav hideNavigationBottomLine];
            GZManagerAchievementsViewController *vc = [GZManagerAchievementsViewController new];
            
            vc.pageIndex = 2;
            vc.jifen = self.jifenBtn.titleLabel.text;

            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (IBAction)pushTest:(UIButton *)sender
{
    // 设置返回名字
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"骨干工作";
    nav.titleNameColor = nil;
    
    GZCERepresentDiscountViewController *ss = [GZCERepresentDiscountViewController new];
    
    [self.navigationController pushViewController:ss animated:YES];
}

#pragma mark - 开启定位时从后台进入前端
- (void)applicationBecomeActive
{
    [self confileBaiDuMap];
}

//定位失败，或者定位被拒绝时
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1) {
            
            //跳转到定位权限页面
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

@end

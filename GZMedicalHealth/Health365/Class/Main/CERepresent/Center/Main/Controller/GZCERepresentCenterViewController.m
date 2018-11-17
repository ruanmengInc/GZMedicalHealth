//
//  GZCERepresentCenterViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/31.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCenterViewController.h"
#import "GZGiftExchangeViewController.h"
#import "GZCERepresentCenterDetailViewController.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "JFLocation.h"
#import "GZProvinceController.h"
#import "GZShoppingMallMenuView.h"

#import "GZCERepresentCenterTableViewCell.h"

#import "GZCERepresentCenterSearchView.h"


#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface GZCERepresentCenterViewController ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate, JFCityViewControllerDelegate>
{
    NSString *_lat;
    NSString *_lng;
    NSString *_cityID;
    NSString *_city;
    NSString *_cityFitstID;
    NSString *_keyword;

    NSString *_statusOne;
    NSString *_statusTwo;
    NSString *_statusThree;
    NSString *_statusFour;
    NSString *_statusFive;
    NSString *_statusSex;
}

/** 城市定位管理器*/
@property (nonatomic, strong) BMKLocationManager *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic, strong) GZShoppingMallMenuView *shoppingMallMenuVC;

@property (nonatomic, strong) UIView *leftCityView;
@property (nonatomic, strong) UIButton *leftCityBtn;
@property (nonatomic, strong) UIImageView *leftCityImgV;
@property (nonatomic, strong) UIImageView *leftCityImgVTwo;

@property (nonatomic, strong) UIView *rightCityView;
@property (nonatomic, strong) UIButton *rightCityBtn;
@property (nonatomic, strong) UIButton *rightCityBtnTwo;
@property (nonatomic, strong) UIButton *rightCityBtnThree;

@property (nonatomic, strong) GZCERepresentCenterSearchView *searchView;

@end

@implementation GZCERepresentCenterViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = NO;
        
        /// 支持上拉加载，下拉刷新
        self.shouldPullDownToRefresh = YES;
        self.shouldPullUpToLoadMore = YES;
        
        self.shouldBeginRefreshing = NO;
        
        self.shouldEndRefreshingWithNoMoreData = NO;
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self confileBaiDuMap];

    [self setupUI];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 60, kScreenWidth, self.view.GZ_height - 60);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    
    self.searchView.frame = CGRectMake(0, 0, kScreenWidth, 50);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.shoppingMallMenuVC];
    
    if (self.cityStr != nil) {
        
        if ([self.cityIDFrom isEqualToString:_cityID]) {
            
            _cityID = _cityFitstID;

        }else
        {
            _cityID = self.cityIDFrom;
        }
        
        [self.leftCityBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:7];
        [self.leftCityBtn setTitle:self.cityStr forState:UIControlStateNormal];
        
        
        [self tableViewDidTriggerHeaderRefresh];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"homeVC" object:nil];
    [self.shoppingMallMenuVC removeFromSuperview];
    
    self.cityStr = nil;
    self.cityIDFrom = nil;
}

- (void)confileBaiDuMap
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

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
            if (![self.leftCityBtn.titleLabel.text isEqualToString:location.rgcData.city]) {
                
                [self.leftCityBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:7];
                [self.leftCityBtn setTitle:location.rgcData.city forState:UIControlStateNormal];
                
                [KCURRENTCITYINFODEFAULTS setObject:location.rgcData.city forKey:@"locationCity"];
                [KCURRENTCITYINFODEFAULTS setObject:location.rgcData.city forKey:@"currentCity"];
                [self.manager cityNumberWithCity:location.rgcData.city cityNumber:^(NSString *cityNumber) {
                    [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
                }];
                
                _lat = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
                _lng = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
                _city = location.rgcData.city;
                
                [self getCityID];
            }
        }
        
    }];
}

- (void)setupUI
{
    _cityID = @"";
    _cityFitstID = @"";
    
    _lat = @"00000000000000000000";
    _lng = @"";
    _keyword = @"";
    
    _statusOne = @"0";
    _statusTwo = @"0";
    _statusThree = @"0";
    _statusFour = @"0";
    _statusFive = @"0";
    _statusSex = @"0";

    self.tableView.rowHeight = 100;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZCERepresentCenterTableViewCell" bundle:nil] forCellReuseIdentifier:@"GZCERepresentCenterTableViewCell"];
    
    
    [self.leftCityView addSubview:self.leftCityBtn];
    [self.leftCityView addSubview:self.leftCityImgV];
    [self.leftCityView addSubview:self.leftCityImgVTwo];

    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftCityView];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,rewardItem];
    
    
    [self.rightCityView addSubview:self.rightCityBtn];
    [self.rightCityView addSubview:self.rightCityBtnTwo];
    [self.rightCityView addSubview:self.rightCityBtnThree];
    
    UIBarButtonItem *rewardItemRight = [[UIBarButtonItem alloc]initWithCustomView:self.rightCityView];
    UIBarButtonItem *spaceItemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItemRight.width = -15;
    self.navigationItem.rightBarButtonItems = @[spaceItemRight,rewardItemRight];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:@"homeVC" object:nil];
    
    [self.view addSubview:self.searchView];
}

#pragma mark - 根据市名获取id
- (void)getCityID
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"get_city_id";
    subscript[@"name"] = self.leftCityBtn.titleLabel.text;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
                
        _cityID = responseObject.id;
        _cityFitstID = responseObject.id;
        
        [self tableViewDidTriggerHeaderRefresh];
        
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

#pragma mark - 事件处理Or辅助方法
- (void)tableViewDidTriggerHeaderRefresh{
    
    if ([_lat isEqualToString:@"00000000000000000000"]) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请开启定位" delayTime:1.0];
        
        [self endHeader];
        
        return;
    }
    
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_shoplist";
    subscript[@"id"] = [GZTool isNotLoginUid];
    subscript[@"index"] = @(1);
    subscript[@"keyword"] = _keyword;
    subscript[@"lat"] = _lat;
    subscript[@"lng"] = _lng;
    subscript[@"gl"] = _statusOne;
    subscript[@"gz"] = _statusTwo;
    subscript[@"yh"] = _statusThree;
    subscript[@"dh"] = _statusFour;
    subscript[@"ls"] = _statusFive;
    subscript[@"sq"] = _statusSex;
    subscript[@"city"] = _cityID;
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> * responseObject) {
        
        /// 成功后才设置 self.page = 1;
        self.page = 1;
        /// 添加数据
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:responseObject];

        [self reloadData];
        [self endHeader];
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        /// 配置 EmptyView
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:@"客官别急~，一大波小姐姐正在赶来的路上" errorInfo:nil offsetTop:250 hasData:self.dataSource.count>0 hasError:NO reloadBlock:NULL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self.dataSource removeAllObjects];
        [self reloadData];
        [self endFooter];

        [MBProgressHUD mh_hideHUDForView:self.view];
        
        /// 配置 EmptyView
        [self.tableView cmh_configEmptyViewWithType:CMHEmptyDataViewTypeDefault emptyInfo:nil errorInfo:[NSError mh_tipsFromError:error] offsetTop:250 hasData:self.dataSource.count>0 hasError:YES reloadBlock:NULL];
    }];
}

- (void)tableViewDidTriggerFooterRefresh{
    
    if ([_lat isEqualToString:@"00000000000000000000"]) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请开启定位" delayTime:1.0];
        
        [self endFooter];
        return;
    }
    
    /// 下拉加载事件 子类重写
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_shoplist";
    subscript[@"id"] = [GZTool isNotLoginUid];
    subscript[@"index"] = @(self.page + 1);
    subscript[@"keyword"] = _keyword;
    subscript[@"lat"] = _lat;
    subscript[@"lng"] = _lng;
    subscript[@"gl"] = _statusOne;
    subscript[@"gz"] = _statusTwo;
    subscript[@"yh"] = _statusThree;
    subscript[@"dh"] = _statusFour;
    subscript[@"ls"] = _statusFive;
    subscript[@"sq"] = _statusSex;
    subscript[@"city"] = _cityID;
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, NSArray <GZCERepresentBaseModel *> * responseObject) {
        /// 成功后才设置 self.page += 1;
        self.page += 1;
        /// 添加数据集
        [self.dataSource addObjectsFromArray:responseObject];
        [self reloadData];
        [self endFooter];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        /// show error
        [self tableViewDidFinishTriggerHeader:NO reload:YES];
    }];
}

/// 生成一个可复用的cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCERepresentCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZCERepresentCenterTableViewCell" forIndexPath:indexPath];
    
    cell.telBtn.tag = indexPath.row;
    cell.model = self.dataSource[indexPath.row];
    
    cell.btnEventsBlock = ^(NSInteger tag) {
        
        GZCERepresentBaseModel *model = self.dataSource[tag];
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.tel];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebview];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"药店";
    nav.titleNameColor = nil;

    GZCERepresentCenterDetailViewController *vc = [GZCERepresentCenterDetailViewController new];
    
    GZCERepresentBaseModel *model = self.dataSource[indexPath.row];

    vc.shopID = model.id;
    vc.ownLat = _lat;
    vc.ownLng = _lng;
    vc.gl = model.gl;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 选择城市
- (void)pushToReward
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"定位城市";
    nav.titleNameColor = nil;
    
    GZProvinceController *provinceVC = [[GZProvinceController alloc] init];
    
    if (_city == nil) {
        
        provinceVC.cityStr = @"郑州市";
    }else
    {
        provinceVC.cityStr = _city;
    }
    
    provinceVC.cityID = _cityFitstID;
    
    [self.navigationController pushViewController:provinceVC animated:YES];
}

#pragma mark - 礼品兑换
- (void)GiftExchange
{
//    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
//    nav.titleName = @"礼品兑换";
//    nav.titleNameColor = nil;
//
//    [self.navigationController pushViewController:[GZGiftExchangeViewController new] animated:YES];
}

#pragma mark - 搜索
- (void)pushToRewardSearch
{
    
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

#pragma mark - 终端筛选
- (void)terminalScreen:(UIButton *)sender
{
    [self.shoppingMallMenuVC showShoppingMallMenu];
}

#pragma mark - 开启定位时从后台进入前端
- (void)applicationBecomeActive
{
    [self confileBaiDuMap];
}

-(GZShoppingMallMenuView *)shoppingMallMenuVC
{
    if (_shoppingMallMenuVC == nil) {
        
        _shoppingMallMenuVC = [GZShoppingMallMenuView createShoppingMallMenuView];
        _shoppingMallMenuVC.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
        kWeakSelf(self)
        _shoppingMallMenuVC.sureBlock = ^(NSString *statusOne, NSString *statusTwo, NSString *statusThree, NSString *statusFour, NSString *statusFive, NSString *statusSex) {
            kStrongSelf(self)
            
            _statusOne = statusOne;
            _statusTwo = statusTwo;
            _statusThree = statusThree;
            _statusFour = statusFour;
            _statusFive = statusFive;
            _statusSex = statusSex;
            
            [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

            [self tableViewDidTriggerHeaderRefresh];
        };
    }
    return _shoppingMallMenuVC;
}

-(UIButton *)leftCityBtn
{
    if (_leftCityBtn == nil) {
        _leftCityBtn = [UIButton GZ_textButton:@"" selectTitle:nil titleColor:[UIColor blackColor] font:14 ImageButton:nil];
        
        _leftCityBtn.frame = CGRectMake(self.leftCityView.GZ_left + 10, 0, self.leftCityView.GZ_width * KsuitParam - 20, self.leftCityView.GZ_height * KsuitParam);
        _leftCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftCityBtn addTarget:self action:@selector(pushToReward) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftCityBtn;
}

-(UIView *)leftCityView
{
    if (_leftCityView == nil) {
        _leftCityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _leftCityView.backgroundColor = [UIColor whiteColor];
    }
    return _leftCityView;
}

-(UIImageView *)leftCityImgV
{
    if (_leftCityImgV == nil) {
        _leftCityImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftCityBtn.GZ_right, 10, 10, 10)];
        _leftCityImgV.image = [UIImage imageNamed:@"xiala_"];
        _leftCityImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftCityImgV;
}

-(UIImageView *)leftCityImgVTwo
{
    if (_leftCityImgVTwo == nil) {
        _leftCityImgVTwo = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftCityView.GZ_left - 5, 6, 13, 16)];
        _leftCityImgVTwo.image = [UIImage imageNamed:@"zuobiao2_"];
        _leftCityImgVTwo.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _leftCityImgVTwo;
}

-(UIView *)rightCityView
{
    if (_rightCityView == nil) {
        _rightCityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        _rightCityView.backgroundColor = [UIColor whiteColor];
    }
    return _rightCityView;
}

-(UIButton *)rightCityBtn
{
    if (_rightCityBtn == nil) {
        _rightCityBtn = [UIButton GZ_textButton:nil selectTitle:nil titleColor:[UIColor blackColor] font:14 ImageButton:nil];
        
        _rightCityBtn.frame = CGRectMake(0, 0, self.rightCityView.GZ_width / 3, self.rightCityView.GZ_height * KsuitParam);
        [_rightCityBtn setImage:[UIImage imageNamed:@"sousuo_"] forState:UIControlStateNormal];
        _rightCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightCityBtn addTarget:self action:@selector(pushToRewardSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightCityBtn;
}

-(UIButton *)rightCityBtnTwo
{
    if (_rightCityBtnTwo == nil) {
        _rightCityBtnTwo = [UIButton GZ_textButton:nil selectTitle:nil titleColor:[UIColor blackColor] font:14 ImageButton:nil];
        
        _rightCityBtnTwo.frame = CGRectMake(self.rightCityView.GZ_width / 3, 0, self.rightCityView.GZ_width / 3, self.rightCityView.GZ_height * KsuitParam);
        [_rightCityBtnTwo setImage:[UIImage imageNamed:@"lipin_"] forState:UIControlStateNormal];
        _rightCityBtnTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightCityBtnTwo addTarget:self action:@selector(GiftExchange) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightCityBtnTwo;
}

-(UIButton *)rightCityBtnThree
{
    if (_rightCityBtnThree == nil) {
        _rightCityBtnThree = [UIButton GZ_textButton:nil selectTitle:nil titleColor:[UIColor blackColor] font:14 ImageButton:nil];
        
        _rightCityBtnThree.frame = CGRectMake(self.rightCityView.GZ_width * 2 / 3, 0, self.rightCityView.GZ_width / 3, self.rightCityView.GZ_height * KsuitParam);
        [_rightCityBtnThree setImage:[UIImage imageNamed:@"shaixuan_"] forState:UIControlStateNormal];
        _rightCityBtnThree.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightCityBtnThree addTarget:self action:@selector(terminalScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightCityBtnThree;
}

-(GZCERepresentCenterSearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [GZCERepresentCenterSearchView createGZCERepresentCenterSearchView];
        
        kWeakSelf(self)
        _searchView.btnEventsBlock = ^(NSString * _Nonnull text) {
          kStrongSelf(self)
            
            _keyword = text;
            
            [self tableViewDidTriggerHeaderRefresh];
        };
    }
    return _searchView;
}

@end

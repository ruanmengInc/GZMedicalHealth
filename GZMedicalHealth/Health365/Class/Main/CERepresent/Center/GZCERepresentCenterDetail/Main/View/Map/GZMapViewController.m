//
//  GZMapViewController.m
//  health365
//
//  Created by guGuangZhou on 2017/9/20.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZMapViewController.h"
#import "GZMapNavigationView.h"

// 引入系统地图

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface GZMapViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate>// 制定地图代理

@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKUserLocation *userLocation;
@property (nonatomic,strong) BMKLocationService *locationService;

@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;

@property (nonatomic, strong)GZMapNavigationView *mapNavigationView;

@end

@implementation GZMapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"选取地图";

    if (_mapView) {
        return;
    }
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _mapView.zoomLevel = 18;

    [self.view addSubview:_mapView];

    [self startLocation];

    //去除百度地图定位后的蓝色圆圈和定位蓝点(精度圈)
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示

    [_mapView updateLocationViewWithParam:displayParam];

    UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 20, _mapView.GZ_height / 2 - 70, 34, 51)];

    locationImageView.image = [[UIImage imageNamed:@"zuobiao_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    locationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_mapView addSubview:locationImageView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView viewWillDisappear];
    
    [_mapView removeFromSuperview];
    _mapView = nil;
    _mapView.delegate = nil;
    _locationService.delegate = nil;
    
}

-(UIButton *)set_rightButton
{
    return [UIButton GZ_textButton:@"确定位置" selectTitle:nil titleColor:MHColor(255, 102, 102) font:16 ImageButton:@"weizhi_"];
}

-(void)right_button_event:(UIButton *)sender
{
    if (_latitude == nil) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"还没有获取到您的位置，请稍后再试" delayTime:1.0];
        return;
    }
    if (_choosePositionBlock) {
        _choosePositionBlock(_latitude,_longitude);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 获取中心点左边
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    _latitude = [NSString stringWithFormat:@"%.6f",centerCoordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%.6f",centerCoordinate.longitude];
    
}
#pragma mark -- 开始定位
-(void)startLocation{
    _locationService = [[BMKLocationService alloc] init];
    [_locationService startUserLocationService];
    _locationService.delegate =self;
    [_locationService startUserLocationService];
    
}

#pragma mark -- 已经得到定位
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    _userLocation = userLocation;
    
    if (_latitude == nil) {
        _latitude = [NSString stringWithFormat:@"%.6f",_userLocation.location.coordinate.latitude];
        _longitude = [NSString stringWithFormat:@"%.6f",_userLocation.location.coordinate.longitude];
    }
    
    [_mapView updateLocationData:userLocation];
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"定位失败" delayTime:1.0];
}


@end

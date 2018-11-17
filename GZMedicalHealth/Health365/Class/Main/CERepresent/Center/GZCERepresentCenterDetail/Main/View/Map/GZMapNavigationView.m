//
//  GZMapNavigationView.m
//  health365
//
//  Created by guGuangZhou on 2017/8/11.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZMapNavigationView.h"
#import "CLLocation+GZLocation.h"

@implementation GZMapNavigationView
{
    double _currentLatitude;
    double _currentLongitute;
    double _targetLatitude;
    double _targetLongitute;
    NSString *_name;
    CLLocationManager *_manager;
}

-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

+(NSArray *)checkHasOwnApp{
    NSArray *mapSchemeArr = @[@"comgooglemaps://",@"iosamap://navi",@"baidumap://map/",@"qqmap://"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果原生地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0) {
                [appListArr addObject:@"google地图"];
            }else if (i == 1){
                [appListArr addObject:@"高德地图"];
            }else if (i == 2){
                [appListArr addObject:@"百度地图"];
            }else if (i == 3){
                [appListArr addObject:@"腾讯地图"];
            }
        }
    }
    
    return appListArr;
}

- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    
    CLLocation *from = [[CLLocation alloc]initWithLatitude:currentLatitude longitude:currentLongitute];
    
    // 从地图坐标转化到火星坐标
    CLLocation *fromLoction = [from locationMarsFromEarth];
    _currentLatitude = fromLoction.coordinate.latitude;
    _currentLongitute = fromLoction.coordinate.longitude;
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
    
    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"baidumap://map/"]]]) {
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",currentLatitude, currentLongitute,targetLatitude,targetLongitute] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        
       
        
//        CLLocation *to = [[CLLocation alloc]initWithLatitude:_targetLatitude longitude:_targetLongitute];
//
//        // 从火星坐标转化到百度坐标
//        CLLocation *toLoction = [to locationBaiduFromMars];
//
//        NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",fromLoction.coordinate.latitude,fromLoction.coordinate.longitude,toLoction.coordinate.latitude,toLoction.coordinate.longitude];
//        NSURL *url = [NSURL URLWithString:stringURL];
//        [[UIApplication sharedApplication] openURL:url];
        
    }else
    {           //苹果原生地图
        
        CLLocationCoordinate2D from = CLLocationCoordinate2DMake(_currentLatitude, _currentLongitute);
        MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
        currentLocation.name = @"我的位置";
        
        //终点
        CLLocationCoordinate2D to = CLLocationCoordinate2DMake(_targetLatitude, _targetLongitute);
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];

        toLocation.name = name;
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{
                                  MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                  MKLaunchOptionsMapTypeKey:
                                      [NSNumber numberWithInteger:MKMapTypeStandard],
                                  MKLaunchOptionsShowsTrafficKey:@YES
                                  };
        
        //打开苹果自身地图应用
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }
}

- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    [self startLocation];
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
}

//获取经纬度
-(void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate=self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
        _manager.distanceFilter=100;
        [_manager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }
    
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    //    CLLocation *marLoction = [newLocation locationMarsFromEarth];
    [self showMapNavigationViewFormcurrentLatitude:newLocation.coordinate.latitude currentLongitute:newLocation.coordinate.longitude TotargetLatitude:_targetLatitude targetLongitute:_targetLongitute toName:_name];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [self stopLocation];
    
}

-(void)stopLocation
{
    _manager = nil;
}

@end

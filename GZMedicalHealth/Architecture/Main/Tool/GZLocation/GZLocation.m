//
//  GZLocation.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/27.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZLocation.h"
#import <CoreLocation/CLLocationManager.h>

@implementation GZLocation

#pragma mark 判断是否打开定位
+(BOOL)determineWhetherTheAPPOpensTheLocation{
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] ==kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        return YES;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        return NO;
        
    }else{
        
        return NO;
    }
}

@end

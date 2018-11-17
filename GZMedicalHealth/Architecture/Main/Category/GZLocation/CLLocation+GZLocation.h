//
//  CLLocation+GZLocation.h
//  health365
//
//  Created by GuangZhou Gu on 2017/8/11.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (GZLocation)

//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

//从火星坐标到地图坐标
//- (CLLocation*)locationEarthFromMars; // 未实现


@end

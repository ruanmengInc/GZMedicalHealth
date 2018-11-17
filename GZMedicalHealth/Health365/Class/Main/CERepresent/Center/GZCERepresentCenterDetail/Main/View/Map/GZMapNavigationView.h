//
//  GZMapNavigationView.h
//  health365
//
//  Created by guGuangZhou on 2017/8/11.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GZMapNavigationView : UIView <UIActionSheetDelegate,CLLocationManagerDelegate>

/**
 *  从指定地导航到指定地
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
/**
 *  从目前位置导航到指定地
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;

@end

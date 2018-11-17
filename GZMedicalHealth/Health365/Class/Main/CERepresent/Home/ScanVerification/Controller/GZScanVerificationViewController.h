//
//  GZScanVerificationViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZChangenavgationBarColorViewController.h"

@interface GZScanVerificationViewController : GZChangenavgationBarColorViewController

/**
 商品id
 */
@property (nonatomic, copy) NSString *shopid;

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *city;

@end

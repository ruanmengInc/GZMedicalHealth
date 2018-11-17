//
//  GZCERepresentCenterDetailViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHViewController.h"

@interface GZCERepresentCenterDetailViewController : CMHViewController

@property (nonatomic, copy) NSString *shopID;

// 自己的经纬度
@property (nonatomic, copy) NSString *ownLat;
@property (nonatomic, copy) NSString *ownLng;

@property (nonatomic, copy) NSString *gl;

@end

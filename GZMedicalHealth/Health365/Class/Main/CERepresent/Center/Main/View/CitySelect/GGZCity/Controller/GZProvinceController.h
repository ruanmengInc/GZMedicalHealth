//
//  GZProvinceController.h
//  health365
//
//  Created by GuangZhou Gu on 17/8/3.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//
#import "CMHViewController.h"

@interface GZProvinceController : CMHViewController

@property (nonatomic, copy) void(^popBlock)(NSString *cityStr, NSString *cityID);

@property (nonatomic, copy) NSString *cityStr;

@property (nonatomic, copy) NSString *cityID;

@end

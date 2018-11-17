//
//  GZPersonalDataViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHViewController.h"

@interface GZPersonalDataViewController : CMHViewController

// 选择地区带过来的区域
@property (nonatomic, copy) NSString *provience;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, copy) NSString *provienceID;

@property (nonatomic, copy) NSString *cityID;

@property (nonatomic, copy) NSString *countyID;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, strong) GZCERepresentBaseModel *model;

@end

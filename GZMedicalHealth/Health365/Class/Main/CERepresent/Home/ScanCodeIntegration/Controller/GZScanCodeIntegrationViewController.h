//
//  GZScanCodeIntegrationViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHViewController.h"

@interface GZScanCodeIntegrationViewController : CMHViewController


//类型
@property (nonatomic, copy) NSString *fromType;


/**
 商品id
 */
@property (nonatomic, copy) NSString *shopid;
/**
 会员id
 */
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *city;

@end

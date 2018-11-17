//
//  GZCERepresentCountyController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/2.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentCountyController : CMHViewController

/**
 省 ID
 */
@property (nonatomic, copy) NSString *provinceID;

/**
 市 ID
 */
@property (nonatomic, copy) NSString *cityID;

/**
 省 名字
 */
@property (nonatomic, copy) NSString *province;

/**
 市 名字
 */
@property (nonatomic, copy) NSString *city;

@end

NS_ASSUME_NONNULL_END

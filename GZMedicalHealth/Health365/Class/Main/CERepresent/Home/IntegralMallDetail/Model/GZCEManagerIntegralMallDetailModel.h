//
//  GZCEManagerIntegralMallDetailModel.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/10.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZCEManagerIntegralMallDetailModel : CMHObject

//  积分商品详情user_365_productinfo
@property (nonatomic, copy) NSString *jifen;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *guige;

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *qiye;
@property (nonatomic, copy) NSString *jieshao;
@property (nonatomic, copy) NSString *gyzz;
@property (nonatomic, strong) NSArray *logo;

@end

NS_ASSUME_NONNULL_END

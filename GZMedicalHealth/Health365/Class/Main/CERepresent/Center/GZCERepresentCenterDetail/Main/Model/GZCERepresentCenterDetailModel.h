//
//  GZCERepresentCenterDetailModel.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/8.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentCenterDetailModel : CMHObject

//  店铺详情user_365_shopinfo
@property (nonatomic, assign) CGFloat contact;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *collect;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, strong) NSArray *logo;

@end

NS_ASSUME_NONNULL_END

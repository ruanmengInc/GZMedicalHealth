//
//  CMHTmpModel.h
//  MHDevelopExample
//
//  Created by Apple on 2018/8/3.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "CMHObject.h"

@interface CMHTmpModel : CMHObject

@property (nonatomic, copy) NSString *Dfh;
@property (nonatomic, copy) NSString *Dfk;
@property (nonatomic, copy) NSString *Dpj;
@property (nonatomic, copy) NSString *Dsh;
@property (nonatomic, copy) NSString *Ywc;

@property (nonatomic, assign) CGFloat account;
@property (nonatomic, copy) NSString *coupon_num;
@property (nonatomic, copy) NSString *kefu;
@property (nonatomic, copy) NSString *hezuo;
@property (nonatomic, copy) NSString *user_logo;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *linkurl;
@property (nonatomic, copy) NSString *hdgz;
@property (nonatomic, copy) NSString *invite_code;

@property (nonatomic, assign) CGFloat reward;
@property (nonatomic, assign) CGFloat commision;
@property (nonatomic, assign) CGFloat tx_downline;

@property (nonatomic, copy) NSString *txrate;
@property (nonatomic, copy) NSString *txrate_show;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *store_cart;
@property (nonatomic, copy) NSString *cart;
@property (nonatomic, copy) NSString *orderNum;

@end

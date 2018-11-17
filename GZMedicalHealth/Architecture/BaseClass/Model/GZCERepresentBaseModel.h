//
//  GZCERepresentBaseModel.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/10.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentBaseModel : CMHObject

//  登录
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *appsecret;
@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *fenyao;

//  忘记密码
@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *rongyu;

//  用户个人信息
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *isread;
@property (nonatomic, assign) CGFloat jifen;
@property (nonatomic, assign) CGFloat jixiao;
@property (nonatomic, assign) CGFloat liuxiang;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pro;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *count;

//  编辑个人资料、所在区域
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sname;

//  店铺列表user_365_shoplist
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, copy) NSString *dui;
@property (nonatomic, copy) NSString *youhui;
@property (nonatomic, copy) NSString *guanzhu;
@property (nonatomic, copy) NSString *gl;


@property (nonatomic, copy) NSString *xingming;

//  销售扫码user_365_salescan
@property (nonatomic, copy) NSString *tiaoma;
@property (nonatomic, copy) NSString *date;

//  代表绩效user_365_dbjixiao
@property (nonatomic, assign) CGFloat sumjixiao;
@property (nonatomic, strong) NSArray *list;

//  积分商品user_365_products
@property (nonatomic, copy) NSString *changjia;
@property (nonatomic, copy) NSString *guige;

//  规则设置sys_set
@property (nonatomic, copy) NSString *jifen_rule;
@property (nonatomic, copy) NSString *help;
@property (nonatomic, copy) NSString *reg_rule;
@property (nonatomic, copy) NSString *about;
@property (nonatomic, copy) NSString *version_365;
@property (nonatomic, copy) NSString *url_365;
@property (nonatomic, copy) NSString *gengxin_365;
@property (nonatomic, copy) NSString *version_360;
@property (nonatomic, copy) NSString *url_360;
@property (nonatomic, copy) NSString *gengxin_360;

@end

NS_ASSUME_NONNULL_END

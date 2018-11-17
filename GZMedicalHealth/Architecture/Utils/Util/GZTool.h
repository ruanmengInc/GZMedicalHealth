//
//  GZTool.h
//  health365
//
//  Created by GuangZhou Gu on 17/8/3.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Encrypt.h"

@interface GZTool : NSObject

/**
 登录成功之后的token
 */
+ (NSString *) U_token;

/**
 登录成功之后的昵称
 */
+ (NSString *) isU_nick;

/**
 登录成功之后的头像
 */
+ (NSString *) isU_head;

/**
 登录成功之后的uid,三层加密之后,读取uid
 */
+ (NSString *) isUid;
/**
 登录成功之后的uid,读取uid，未加密
 */
+ (NSString *) isNotLoginUid;

/**
 登录成功之后的appid,放入黑带里传
 */
+ (NSString *) isAppid;
/**
 登录成功之后的appsecret,放入黑带里传
 */
+ (NSString *) isAppsecret;

/**
 是否登录
 */
+ (BOOL) isLogin;

/**
  角色， role 0，会员，1，客服经理，2 客服代表
 */
+ (NSString *) role;

+ (NSString *) zhanghao;

+ (NSString *) mima;

// 禁用
+ (NSString *) jinStatus;


/**
 tel DES加密
 */
+ (NSString *) isTel:(NSString *)tel;

/**
 经度
 */
+ (NSString *) isLongitude;

/**
 纬度
 */
+ (NSString *) isLatitude;

/**
 根据UITextField，判断按钮变色
 
 shouldChangeCharactersInRange 在此系统方法中调用 
 */
+ (BOOL)getButtonEnableByCurrentTF:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string tfArr:(NSArray *)tfArr;

@end

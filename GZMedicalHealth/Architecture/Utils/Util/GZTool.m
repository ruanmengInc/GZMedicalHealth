//
//  GZTool.m
//  health365
//
//  Created by GuangZhou Gu on 17/8/3.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZTool.h"

@implementation GZTool

/**
 登录成功之后的token
 */
+ (NSString *) U_token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"U_token"];
}

/**
 登录成功之后的昵称
 */
+ (NSString *) isU_nick
{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"U_nick"];
}

/**
 登录成功之后的头像
 */
+ (NSString *) isU_head
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"U_head"];
}

/**
 登录成功之后的uid,三层加密之后,读取uid
 */

+ (NSString *) isUid
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] Des_3EncryptForTimeInterval:[NSString getNowTimeTimestamp] Appkey:[GZTool isAppid] AppSecret:[GZTool isAppsecret]];
}

+ (NSString *) isNotLoginUid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
}

+ (BOOL) isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

/**
 登录成功之后的appid,放入黑带里传
 */
+ (NSString *) isAppid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appid"];
}
/**
 登录成功之后的appsecret,放入黑带里传
 */
+ (NSString *) isAppsecret
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appsecret"];
}

/**
 角色
 */
+ (NSString *) role
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"role"];
}

+ (NSString *) isTel:(NSString *)tel
{
    return [tel Des_EncryptForKey:LoginDesEncryptKey Iv:LoginDesEncryptIv];
}

+ (NSString *) zhanghao
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zhanghao"];
}

+ (NSString *) mima
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mima"];
}

+ (NSString *) jinStatus
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"jinStatus"];
}

/**
 经度
 */
+ (NSString *) isLongitude
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
}

/**
 纬度
 */
+ (NSString *) isLatitude
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
}

/**
 根据UITextField，判断按钮变色
 
 shouldChangeCharactersInRange 在此系统方法中调用
 */
+ (BOOL)getButtonEnableByCurrentTF:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string tfArr:(NSArray *)tfArr {
    
    if (string.length) {// 文本增加
        NSMutableArray *newTFs = [NSMutableArray arrayWithArray:tfArr];
        [newTFs removeObject:textField];
        
        for (UITextField *tempTF in newTFs) {
            if (tempTF.text.length==0) return NO;
        }
        
    }else{// 文本删除
        
        if (textField.text.length-range.length==0) {// 当前TF文本被删完
            return NO;
        }else{
            NSMutableArray *newTFs = [NSMutableArray arrayWithArray:tfArr];
            [newTFs removeObject:textField];
            for (UITextField *tempTF in newTFs) {
                if (tempTF.text.length==0) return NO;
            }
        }
    }
    return YES;
}

@end

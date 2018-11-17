//
//  CMHMacros.h
//  MHDevelopExample
//
//  Created by lx on 2018/5/24.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#ifndef CMHMacros_h
#define CMHMacros_h


/// 1 -- 进入基于MVC设计模式的基类设计
/// 0 -- 进入常用的开发Demo
#define CMHDEBUG 1

//

/**
 tableView不是全屏时无数据时高度
 */
#define NODATAPLACEHOLDERIMGOFFSETTOP_HalfScreen 280

/**
 tableView全屏时无数据时高度
 */
#define NODATAPLACEHOLDERIMGOFFSETTOP_FullScreen 250

/// ---- WeChat --
/// 全局青色 tintColor
#define CMH_MAIN_TINTCOLOR [UIColor colorWithRed:(10 / 255.0) green:(193 / 255.0) blue:(42 / 255.0) alpha:1]



/// ---- YYWebImage Option
/// 手动设置image
#define CMHWebImageOptionManually (YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation|YYWebImageOptionAvoidSetImage)
/// 自动设置Image
#define CMHWebImageOptionAutomatic (YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation)

//接口
#define GGZ_POST_BASE  @"http://yjb.gekochina.com/tools/interface.ashx"

//电话加密
#define LoginDesEncryptKey (@"!@#$%^&*")
#define LoginDesEncryptIv (@"QWERTYUi")

#import "CMHConstEnum.h"
#import "CMHConstInline.h"
#import "CMHConstant.h"
#import "CMHURLConfigure.h"
#endif /* CMHMacros_h */

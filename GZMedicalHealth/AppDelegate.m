//
//  AppDelegate.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/7.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "AppDelegate.h"
#import "MHNavigationController.h"
//#import "MHExampleController.h"
#import "CMHHomePageViewController.h"

#import "GZTabBarViewController.h"
#import "GZLoginViewController.h"
#import "CMHNavigationController.h"

#if defined(DEBUG)||defined(_DEBUG)
#import "JPFPSStatus.h"
#endif

/// 融云token
#define RongYunAppKey (@"0vnjpoad0621z")


@interface AppDelegate ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
/**
 *  用户数据 只读
 */
@property (nonatomic, readwrite, strong) MHAccount *account;

@property (nonatomic,strong) BMKMapManager *baiDuManager;

@end

@implementation AppDelegate

#pragma mark- 获取appdelegate
+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (MHAccount *)account
{
    if (_account == nil) {
        // 内部初始化了数据
        _account = [[MHAccount alloc] init];
    }
    return _account;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /// 初始化UI之前配置
    [self _configureApplication:application initialParamsBeforeInitUI:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
#if CMHDEBUG
    
    
    /// 百度地图
    [self configurationBaiduMap];
    
    /// 融云IM 初始化
    [self createRongCloud];
    
    
    if ([GZTool isLogin]) {
        
        GZTabBarViewController *tab = [[GZTabBarViewController alloc] init];
        self.window.rootViewController = tab;
        
        /// 百度地图
        [self configurationBaiduMap];
        
    }else
    {
        GZLoginViewController *login = [[GZLoginViewController alloc] init];
        CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:login];
        
        self.window.rootViewController = nav;
    }
    
#else
//    self.window.rootViewController = [[MHNavigationController alloc] initWithRootViewController:[[MHExampleController alloc] init]];
    
    self.window.rootViewController = [[CMHHomePageViewController alloc] initWithParams:nil];

#endif
    
    
    [self.window makeKeyAndVisible];
    
    

#if defined(DEBUG)||defined(_DEBUG)
    [self _configDebugModelTools];
#endif
    
    return YES;
}

#pragma mark ------------------------------------------- 配置百度地图
-(void)configurationBaiduMap{
    _baiDuManager = [[BMKMapManager alloc]init];
    BOOL ret = [_baiDuManager start:@"Ob1BDl5g9ol5t11ix7kzaVQENSeLBqxr"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图配置失败");
    }else{
        
    }
}

#pragma mark - 在初始化UI之前配置
- (void)_configureApplication:(UIApplication *)application initialParamsBeforeInitUI:(NSDictionary *)launchOptions{
    /// 显示状态栏
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    /// 配置键盘
    [self _configureKeyboardManager];
    
    // 配置YYWebImage
    [self _configureYYWebImage];
    
    /// 配置网络请求
    [CMHHTTPService sharedInstance];
}

/// 配置键盘管理器
- (void)_configureKeyboardManager {
    IQKeyboardManager.sharedManager.enable = YES;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    IQKeyboardManager.sharedManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    IQKeyboardManager.sharedManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    IQKeyboardManager.sharedManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; // 设置占位文字的字体
    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    IQKeyboardManager.sharedManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    IQKeyboardManager.sharedManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
}

/// 配置YYWebImage
- (void)_configureYYWebImage {
    /// CoderMikeHe Fixed Bug : 解决 SDWebImage & YYWebImage 加载不出http://img3.imgtn.bdimg.com/it/u=965183317,1784857244&fm=27&gp=0.jpg的BUG
    NSMutableDictionary *header = [YYWebImageManager sharedManager].headers.mutableCopy;
    header[@"User-Agent"] = @"iPhone"; 
    [YYWebImageManager sharedManager].headers = header;
}

- (void)createRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:RongYunAppKey];
    
    /// 接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    /// 设置用户信息代理
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    /// 接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    
    /// 设置头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    
    /// 判断是否登录
    if ([GZTool isLogin]) {
        
        [[RCIM sharedRCIM] connectWithToken:[GZTool U_token] success:^(NSString *userId)
         {
             NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
             
             RCUserInfo *userInfo = [[RCUserInfo alloc]init];
             userInfo.userId = [NSString stringWithFormat:@"%@",[GZTool isNotLoginUid]];
             userInfo.name = [GZTool isU_nick];
             userInfo.portraitUri = [GZTool isU_head];
             
             [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
             [RCIM sharedRCIM].currentUserInfo = userInfo;
             [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
             
         } error:^(RCConnectErrorCode status) {
             
             NSLog(@"登陆的错误码为:%ld", (long)status);
             
         } tokenIncorrect:^{
             
             //token过期或者不正确。
             //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
             //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
             NSLog(@"token错误");
             
         }];
    }
}

#pragma mark - 被迫下线
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        /// 退出登录
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults removeObjectForKey:@"appid"];
        [defaults removeObjectForKey:@"appsecret"];
        [defaults removeObjectForKey:@"uid"];
        
        [defaults removeObjectForKey:@"U_nick"];
        [defaults removeObjectForKey:@"U_token"];
        [defaults removeObjectForKey:@"U_head"];
        [defaults setBool:NO forKey:@"isLogin"];
        
        [defaults synchronize];
        
        //退出融云聊天
        [[RCIM sharedRCIM] logout];
        
        //
        //                    //闭极光推送
        //                    [JPUSHService setTags:nil alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        //
        //                    }];
        
        AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
        UIWindow *theWindow = app.window;
        
        GZLoginViewController *login = [[GZLoginViewController alloc] init];
        CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:login];
        theWindow.rootViewController = nav;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的帐号在别的设备上登录，您被迫下线！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
}

#pragma mark - 调试(DEBUG)模式
- (void)_configDebugModelTools{
    /// 显示FPS
//    [[JPFPSStatus sharedInstance] open];
    
}

//从后台进入前台时监听，定位
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 首页
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeVC" object:nil];
}

@end

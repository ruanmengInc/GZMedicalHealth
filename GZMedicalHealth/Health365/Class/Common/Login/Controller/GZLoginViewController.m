//
//  GZLoginViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/27.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZLoginViewController.h"
#import "GZRegisterViewController.h"
#import "GZForgotPasswordViewController.h"

#import "GZTabBarViewController.h"

@interface GZLoginViewController ()

@property (weak, nonatomic) IBOutlet DSLLoginTextField *telTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *passwordTF;

@end

@implementation GZLoginViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = YES;
    
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.telTF.text = [GZTool zhanghao];
    self.passwordTF.text = [GZTool mima];
}

- (void)setupUI
{
    self.telTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
} 

#pragma mark - 登录
- (void)loginData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_login";
    subscript[@"tel"] = [GZTool isTel:self.telTF.text];
    subscript[@"pwd"] = self.passwordTF.text;
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:YES  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [defaults setObject:responseObject.id forKey:@"uid"];
        [defaults setObject:responseObject.appid forKey:@"appid"];
        [defaults setObject:responseObject.appsecret forKey:@"appsecret"];
        [defaults setObject:responseObject.role forKey:@"role"];  // 角色（0,普通用户，1，vip会员，2，CE代表，3，CE经理，4, 医生，5，终端，6省助理，7 ，省总，8，全国）
        [defaults setObject:responseObject.fenyao forKey:@"fenyao"];
        [defaults setObject:responseObject.rongyu forKey:@"U_token"];

        [defaults setObject:self.telTF.text forKey:@"zhanghao"];
        [defaults setObject:self.passwordTF.text forKey:@"mima"];
        
        [defaults setBool:YES forKey:@"isLogin"];
        
        [defaults synchronize];

        /// 融云
        [[RCIM sharedRCIM] connectWithToken:responseObject.rongyu success:^(NSString *userId)
         {
             NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
             
             RCUserInfo *userInfo = [[RCUserInfo alloc] init];
             
             userInfo.userId = userId;
             //             userInfo.name = model.data.U_nick;
             //             userInfo.portraitUri = model.data.U_head;
             
             [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
             [RCIM sharedRCIM].currentUserInfo = userInfo;
             [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
             
         } error:^(RCConnectErrorCode status) {
             
             //[MBProgressHUD showInfoMessage:@"融云登录失败"];
             
             //  NSLog(@"登陆的错误码为:%ld", (long)status);
             
         } tokenIncorrect:^{
             
             //token过期或者不正确。
             //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
             //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
             //NSLog(@"token错误");
             
             //[MBProgressHUD showInfoMessage:@"融云登录失败"];
         }];
        
        AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
        UIWindow *theWindow = app.window;

        GZTabBarViewController *tab = [[GZTabBarViewController alloc] init];
        theWindow.rootViewController = tab;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        /// show error
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

- (IBAction)clockEvents:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    switch (sender.tag) {
            
        case 10:        /// 登录
        {
//            if (![self.telTF.text isValidateMobile]) {
//
//                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"手机号输入有误" delayTime:1.0];
//                return;
//            }
            
            if (self.passwordTF.text.length < 6) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
                return;
            }
            
            [self loginData];
        }
            break;
            
        case 11:        /// 立即注册
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"开发中" delayTime:1.0];

//            [self.navigationController pushViewController:[GZRegisterViewController new] animated:YES];
        }
            break;
            
        case 12:        /// 忘记密码
        {
            [self.navigationController pushViewController:[GZForgotPasswordViewController new] animated:YES];
        }
            break;
            
        case 13:        /// 退出登录
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

@end

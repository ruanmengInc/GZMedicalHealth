//
//  GZChangePasswordViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/6.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZChangePasswordViewController.h"

#import "CMHNavigationController.h"
#import "GZLoginViewController.h"

@interface GZChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet DSLLoginTextField *oldTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *nowPassTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *sureTF;

@end

@implementation GZChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"确定" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(_backItemDidClicked)];
}

- (void)_backItemDidClicked
{
    if (self.oldTF.text.length < 6) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
        return;
    }
    
    if (self.nowPassTF.text.length < 6) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
        return;
    }
    
    if (self.sureTF.text.length < 6) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
        return;
    }
    
    if (![self.nowPassTF.text isEqualToString:self.sureTF.text]) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"两次输入的密码不相同" delayTime:1.0];
        return;
    }
    
    [self sureData];
}

- (void)sureData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"up_365_papass_word";
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"uid"] = [GZTool isUid];
    subscript[@"oldpwd"] = self.oldTF.text;
    subscript[@"newpwd"] = self.sureTF.text;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:YES  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        if ([[NSError mh_tipsFromError:error] isEqualToString:[NSString stringWithFormat:@"%ld",CMHHTTPResponseCodeNotData]]) {
            
            /// 退出登录
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults removeObjectForKey:@"appid"];
            [defaults removeObjectForKey:@"appsecret"];
            [defaults removeObjectForKey:@"uid"];
            
            [defaults removeObjectForKey:@"U_nick"];
            [defaults removeObjectForKey:@"U_token"];
            [defaults removeObjectForKey:@"U_head"];
            [defaults removeObjectForKey:@"mima"];
            [defaults setBool:NO forKey:@"isLogin"];
            
            [defaults synchronize];
            
            //退出融云聊天
            [[RCIM sharedRCIM] logout];
            
            AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
            UIWindow *theWindow = app.window;
            
            GZLoginViewController *login = [[GZLoginViewController alloc] init];
            CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:login];
            theWindow.rootViewController = nav;
            
        }else
        {
            [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
        }
    }];
}

@end

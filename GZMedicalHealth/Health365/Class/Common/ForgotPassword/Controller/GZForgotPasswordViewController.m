//
//  GZForgotPasswordViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/27.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZForgotPasswordViewController.h"


@interface GZForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet DSLLoginTextField *telTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *passwordTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *surePasswordTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *codeTF;

@end

@implementation GZForgotPasswordViewController

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
}

- (void)setupUI
{
    self.telTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.surePasswordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"再次输入密码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
}

#pragma mark - 获取口令
- (void)tokenData:(UIButton *)sender
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_verify_token";
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [self codeData:sender token:responseObject.token];

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

#pragma mark - 获取验证码
- (void)codeData:(UIButton *)sender token:(NSString *)token
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_code";
    subscript[@"t"] = @"1";
    subscript[@"token"] = token;
    subscript[@"tel"] = [GZTool isTel:self.telTF.text];

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:YES success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        [UIButton openCountdown:sender];

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

#pragma mark - 忘记密码
- (void)forgotPasswordData:(UIButton *)sender
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_forget";
    subscript[@"tel"] = [GZTool isTel:self.telTF.text];
    subscript[@"pwd"] = self.surePasswordTF.text;
    subscript[@"code"] = self.codeTF.text;
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:nil parsedResult:YES isRequestHead:NO isShowHudMsg:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [self.navigationController popViewControllerAnimated:YES];
        
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

- (IBAction)clickEvents:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    switch (sender.tag) {
            
        case 10:        /// 返回
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 11:        /// 获取验证码
        {
            if (![self.telTF.text isValidateMobile]) {

                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"手机号输入有误" delayTime:1.0];
                return;
            }
            
            [self tokenData:sender];
        }
            break;
            
        case 12:        /// 确定
        {
            if (self.passwordTF.text.length < 6) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
                return;
            }
            
            if (self.surePasswordTF.text.length < 6) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"密码至少6位" delayTime:1.0];
                return;
            }
            
            if (self.codeTF.text.length < 4) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"验证码至少4位" delayTime:1.0];
                return;
            }
            
            [self forgotPasswordData:sender];
        }
            break;
            
        case 13:        /// 无法获取验证码
        {
            
        }
            break;
            
        default:
            break;
    }
}


@end

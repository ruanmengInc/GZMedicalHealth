//
//  GZInvitingMembersViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZInvitingMembersViewController.h"
#import "GZDownloadViewController.h"

#import "GZWebViewController.h"

@interface GZInvitingMembersViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *telTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *codeTF;

@end

@implementation GZInvitingMembersViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.prefersNavigationBarHidden = YES;

    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - 注册
- (void)intefaceData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_add";

    subscript[@"uid"] = [GZTool isUid];
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"tel"] = self.telTF.text;
    subscript[@"name"] = self.nameTF.text;
    subscript[@"code"] = self.codeTF.text;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        if ([[NSError mh_tipsFromError:error] isEqualToString:[NSString stringWithFormat:@"%ld",CMHHTTPResponseCodeNotData]]) {
           
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"邀请好友";
            nav.titleNameColor = nil;
            
            GZWebViewController *webView = [[GZWebViewController alloc] initWithParams:nil];
            webView.url = [NSString stringWithFormat:@"%@%@",Healthy_365_UrlTou,@"download.html"];
            
            [self.navigationController pushViewController:webView animated:YES];

        }else
        {
            /// show error
            [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
        }
    }];
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
    subscript[@"t"] = @"2";
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
- (IBAction)popEvents:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10: // 获取验证码
        {
            if (![self.telTF.text isValidateMobile]) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"手机号输入有误" delayTime:1.0];
                return;
            }
            
            [self tokenData:sender];
        }
            break;
            
        case 11:    // 注册
        {
            [self intefaceData];
        }
            break;
            
        default:
            break;
    }
}

@end

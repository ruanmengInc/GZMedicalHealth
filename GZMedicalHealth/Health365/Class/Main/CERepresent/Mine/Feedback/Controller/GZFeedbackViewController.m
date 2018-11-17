//
//  GZFeedbackViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/6.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZFeedbackViewController.h"

@interface GZFeedbackViewController ()

@property (weak, nonatomic) IBOutlet PlaceholderTextView *contentTV;

@end

@implementation GZFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"提交" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(_backItemDidClicked)];

}

#pragma mark - 提交
- (void)_backItemDidClicked
{
    [self.view endEditing:YES];
    
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_suggest";
    
    subscript[@"uid"] = [GZTool isUid];
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"neirong"] = self.contentTV.text;
    
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
            
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"提交成功" delayTime:1.0];

        }else
        {
            /// show error
            [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
        }
        
    }];
}

@end

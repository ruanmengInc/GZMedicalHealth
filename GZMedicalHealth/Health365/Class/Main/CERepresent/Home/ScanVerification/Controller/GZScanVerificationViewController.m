//
//  GZScanVerificationViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZScanVerificationViewController.h"
#import "GZScanCodeIntegrationViewController.h"

@interface GZScanVerificationViewController ()
{
   NSString *_yaoID;
}

@property (weak, nonatomic) IBOutlet DSLLoginTextField *telTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *niChengTF;

@end

@implementation GZScanVerificationViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.prefersNavigationBarHidden = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - 验证身份
- (void)validataData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_validate";
    subscript[@"tel"] = self.telTF.text;
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel * responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        self.niChengTF.text = responseObject.name;
        _yaoID = responseObject.id;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - 返回
- (IBAction)popEvents:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:    // 验证身份
        {
            if (![self.telTF.text isValidateMobile]) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请输入手机号" delayTime:1.0];
                return;
            }
            
            [self.view endEditing:YES];
            
            [self validataData];
        }
            break;
            
        case 11:
        {
            if ((self.niChengTF.text.length == 0)) {
                
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请先验证身份" delayTime:1.0];
                return;
            }
            
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"销售扫码";
            nav.titleNameColor = nil;
            
            GZScanCodeIntegrationViewController *scanCodeIntegrationVC = [[GZScanCodeIntegrationViewController alloc] init];
            
            //    scanCodeIntegrationVC.navigationItem.title = @"扫码积分";
            //    scanCodeIntegrationVC.saomaType=self.saomaType;
            //
            
            scanCodeIntegrationVC.lat = _lat;
            scanCodeIntegrationVC.lng = _lng;
            scanCodeIntegrationVC.city = _city;

            scanCodeIntegrationVC.ID = _yaoID;
            scanCodeIntegrationVC.shopid = self.shopid;
            
            scanCodeIntegrationVC.fromType = @"ScanCodeIntegration";

            [self.navigationController pushViewController:scanCodeIntegrationVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end

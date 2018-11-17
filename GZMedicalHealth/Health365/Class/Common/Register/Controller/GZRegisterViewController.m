//
//  GZRegisterViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/27.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZRegisterViewController.h"

@interface GZRegisterViewController ()

@property (weak, nonatomic) IBOutlet DSLLoginTextField *telTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *passwordTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *surePasswordTF;
@property (weak, nonatomic) IBOutlet DSLLoginTextField *codeTF;

@end

@implementation GZRegisterViewController

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
    
    self.passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.surePasswordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"再次输入密码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
    
    self.codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName:MHColorFromHexString(@"#a3c7f2")}];
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
           
        }
            break;
            
        case 12:        /// 确定
        {
            //            GZForgotPasswordViewController *forgotPasswordVC = [[GZForgotPasswordViewController alloc] init];
            //
            //            [self.navigationController pushViewController:forgotPasswordVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end

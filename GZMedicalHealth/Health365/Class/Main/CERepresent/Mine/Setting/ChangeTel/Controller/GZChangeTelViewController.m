//
//  GZChangeTelViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/6.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZChangeTelViewController.h"
#import "GZVerificationFailureViewController.h"
#import "GZChangeTelSureViewController.h"

@interface GZChangeTelViewController ()

@end

@implementation GZChangeTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:    // 获取验证码
        {
            
        }
            break;
            
        case 11:    //下一步
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"更换手机号码";
            nav.titleNameColor = nil;

            [self.navigationController pushViewController:[GZChangeTelSureViewController new] animated:YES];
        }
            break;
            
        case 12:    // 无法获取验证码？
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"验证失败";
            nav.titleNameColor = nil;

            [self.navigationController pushViewController:[GZVerificationFailureViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end

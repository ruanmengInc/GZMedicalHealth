//
//  GZChangenavgationBarColorViewController.m
//  GZMedicalHealth360
//
//  Created by Apple on 2018/9/11.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZChangenavgationBarColorViewController.h"

@interface GZChangenavgationBarColorViewController ()

@end

@implementation GZChangenavgationBarColorViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.prefersNavigationBarBottomLineColor = MHColor(54, 131, 222);
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar navBarBackGroundColor:MHColor(66, 136, 226) image:nil isOpaque:YES];//颜色
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:YES];//颜色
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end

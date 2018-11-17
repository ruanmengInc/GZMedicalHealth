//
//  GZChangenavigationBarColorTableViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/11.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZChangenavigationBarColorTableViewController.h"

@interface GZChangenavigationBarColorTableViewController ()

@end

@implementation GZChangenavigationBarColorTableViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = NO;
        /// 支持上拉加载，下拉刷新
        self.shouldPullDownToRefresh = YES;
        self.shouldPullUpToLoadMore = YES;
        
        /// 是否在用户上拉加载后的数据 , 如果请求回来的数据`小于` pageSize， 则提示没有更多的数据.default is YES 。 如果为`NO` 则隐藏mi_footer 。 前提是` shouldMultiSections = NO `才有效。
        self.shouldEndRefreshingWithNoMoreData = NO; // NO
        self.shouldBeginRefreshing = NO;
        self.prefersNavigationBarBottomLineColor = MHColor(66, 136, 226);
        
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
    // Do any additional setup after loading the view from its nib.
}


@end

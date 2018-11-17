//
//  GZCERepresentForecastStockOneViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentForecastStockOneViewController.h"
#import "CMHExampleTableTestCell.h"
#import "CMHExampleTableTest.h"
#import "GZCERepresentForecastStockLeftViewController.h"
#import "GZCERepresentForecastStockCenterViewController.h"
#import "GZCERepresentForecastStockRightViewController.h"

@interface GZCERepresentForecastStockOneViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

@end

@implementation GZCERepresentForecastStockOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPageView];
}

#pragma mark - 事件处理Or辅助方法
- (void)setupPageView
{
    NSArray *titleArr = @[@"入库记录", @"出库记录",@"当前库存"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    
    configure.titleColor = MHColor(153, 153, 153);
    configure.titleSelectedColor = MHColor(51, 51, 51);
    configure.titleGradientEffect = YES;
    configure.needBounces = NO;
    configure.showIndicator = NO;
    configure.showVerticalSeparator = YES;
    configure.verticalSeparatorReduceHeight = 35;
    configure.verticalSeparatorColor = MHColorFromHexString(@"#e2e2e2");
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.menuView.GZ_height * KsuitParam) delegate:self titleNames:titleArr configure:configure];
    [self.menuView addSubview:_pageTitleView];
    
    GZCERepresentForecastStockLeftViewController *oneVC = [[GZCERepresentForecastStockLeftViewController alloc] init];
    oneVC.topHeight = self.menuView.GZ_height * KsuitParam;
    
    GZCERepresentForecastStockCenterViewController *twoVC = [[GZCERepresentForecastStockCenterViewController alloc] init];
    twoVC.topHeight = self.menuView.GZ_height * KsuitParam;

    GZCERepresentForecastStockRightViewController *threeVC = [[GZCERepresentForecastStockRightViewController alloc] init];
    threeVC.topHeight = self.menuView.GZ_height * KsuitParam;

    NSArray *childArr = @[oneVC, twoVC, threeVC];
    
    CGFloat ContentCollectionViewHeight = kScreenHeight - self.menuView.GZ_height * KsuitParam;
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, self.menuView.GZ_height * KsuitParam, kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

#pragma mark - SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

#pragma mark - SGPageContentScrollViewDelegate
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end

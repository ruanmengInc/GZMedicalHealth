//
//  GZMyPointsViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/6.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZMyPointsViewController.h"
#import "GZHomeNavGradualChangeView.h"
#import "GZCERepresentMyPointsHeaderView.h"
#import "GZCERepresentMyPointsLeftTableViewController.h"
#import "GZCERepresentMyPointsRightTableViewController.h"
#import "YNPageViewController.h"
#import "UIView+YNPageExtend.h"

@interface GZMyPointsViewController ()<YNPageViewControllerDataSource, YNPageViewControllerDelegate>

@property (nonatomic, strong) GZHomeNavGradualChangeView *navView;
@property (nonatomic, strong) GZCERepresentMyPointsHeaderView *headerView;

@end

#define kHeaderViewH 177

@implementation GZMyPointsViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self setupPageVC];
    });
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.navView.frame = CGRectMake(0, 0, kScreenWidth, kTopHeight);
}

- (void)setupPageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    /// 控制tabbar 和 nav
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    configration.lineColor = [UIColor clearColor];
    configration.selectedItemColor = [UIColor blackColor];
    configration.bottomLineBgColor = MHColor(243, 243, 243);
    configration.menuHeight = 68;
    configration.bottomLineHeight = 12;
    configration.itemFont = [UIFont systemFontOfSize:15];
    configration.selectedItemFont = [UIFont systemFontOfSize:15];


    /// 设置悬浮停顿偏移量
    configration.suspenOffsetY = kTopHeight;
    
    
    YNPageViewController *vc = [YNPageViewController pageViewControllerWithControllers:self.getArrayVCs
                                                                                titles:@[@"惊喜积分", @"已用积分"]
                                                                                config:configration];
    vc.dataSource = self;
    vc.delegate = self;

    vc.headerView = self.headerView;
    vc.pageIndex = 0;
    
    [vc addSelfToParentViewController:self];
    [self.view addSubview:self.navView];
}

- (NSArray *)getArrayVCs
{
    GZCERepresentMyPointsLeftTableViewController *vc_1 = [[GZCERepresentMyPointsLeftTableViewController alloc] init];
    GZCERepresentMyPointsRightTableViewController *vc_2 = [[GZCERepresentMyPointsRightTableViewController alloc] init];
    
    return @[vc_1, vc_2];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index
{
    UIViewController *vc = pageViewController.controllersM[index];
    
    return [(GZCERepresentMyPointsLeftTableViewController *)vc tableView];
}

#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress
{
    self.navView.backgroundColor = MHAlphaColor(102, 153, 255, progress);
    self.navView.titLab.textColor = MHAlphaColor(255, 255, 255, progress);
}

#pragma mark - Getter and Setter
-(GZCERepresentMyPointsHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [GZCERepresentMyPointsHeaderView createGZCERepresentMyPointsHeaderView];
        
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewH);
    }
    return _headerView;
}

- (GZHomeNavGradualChangeView *)navView {
    if (!_navView) {
        _navView = [GZHomeNavGradualChangeView createHomeNavGradualChangeView];
        _navView.backgroundColor = [UIColor clearColor];
        _navView.titLab.textColor = [UIColor clearColor];
    }
    return _navView;
}

@end

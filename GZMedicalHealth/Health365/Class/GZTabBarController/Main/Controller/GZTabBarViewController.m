//
//  GZTabBarViewController.m
//  DongHeng
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZTabBarViewController.h"
#import "CMHNavigationController.h"
#import "GZCERepresentHomeViewController.h"
#import "GZCERepresentDiscountViewController.h"
#import "GZCERepresentCenterViewController.h"
#import "GZCERepresentCommunityViewController.h"
#import "GZCERepresentMineViewController.h"
#import "GZLoginViewController.h"


// CE经理
#import "GZCEManagerHomeViewController.h"
#import "GZCEManagerMineViewController.h"

#import "GZCEManagerSexMineViewController.h"
#import "GZCEManagerSevenMineViewController.h"
#import "GZCEManagerEightMineViewController.h"

#import "GZCenterTabBar.h"

@interface GZTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) GZCenterTabBar *tabbar;

@end

@implementation GZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // 设置自定义的tabbar
    [self setCustomtabbar];
    
    [self setupBasic];
}

- (void)setupBasic
{
    switch ([[GZTool role] integerValue]) {  // 0,普通用户，1，vip会员，2，CE代表，3，CE经理，4, 医生，5，终端
     
        case 2:
        {
            [self addChildViewController:[GZCERepresentHomeViewController new] notmalimageNamed:@"shouye2_" selectedImage:@"shouye1_" title:@"首页"];
            
            [self addChildViewController:[GZCERepresentDiscountViewController new] notmalimageNamed:@"youhui2_" selectedImage:@"youhui1_" title:@"优惠"];
            
            [self addChildViewController:[GZCERepresentCenterViewController new] notmalimageNamed:@"" selectedImage:@"" title:@""];
            
            [self addChildViewController:[GZCERepresentCommunityViewController new] notmalimageNamed:@"shequ2_" selectedImage:@"shequ1_" title:@"社区"];
            
            [self addChildViewController:[GZCERepresentMineViewController new] notmalimageNamed:@"wode2_" selectedImage:@"wode1_" title:@"我的"];
        }
            break;
            
        case 3:
        {
            [self addChildViewController:[GZCEManagerHomeViewController new] notmalimageNamed:@"shouye2_" selectedImage:@"shouye1_" title:@"首页"];
            
            [self addChildViewController:[GZCERepresentDiscountViewController new] notmalimageNamed:@"youhui2_" selectedImage:@"youhui1_" title:@"优惠"];
            
            [self addChildViewController:[GZCERepresentCenterViewController new] notmalimageNamed:@"" selectedImage:@"" title:@""];
            
            [self addChildViewController:[GZCERepresentCommunityViewController new] notmalimageNamed:@"shequ2_" selectedImage:@"shequ1_" title:@"社区"];
            
            [self addChildViewController:[GZCEManagerMineViewController new] notmalimageNamed:@"wode2_" selectedImage:@"wode1_" title:@"我的"];
        }
            break;
            
        case 6:
        {
            [self addChildViewController:[GZCEManagerHomeViewController new] notmalimageNamed:@"shouye2_" selectedImage:@"shouye1_" title:@"首页"];
            
            [self addChildViewController:[GZCERepresentDiscountViewController new] notmalimageNamed:@"youhui2_" selectedImage:@"youhui1_" title:@"优惠"];
            
            [self addChildViewController:[GZCERepresentCenterViewController new] notmalimageNamed:@"" selectedImage:@"" title:@""];
            
            [self addChildViewController:[GZCERepresentCommunityViewController new] notmalimageNamed:@"shequ2_" selectedImage:@"shequ1_" title:@"社区"];
            
            [self addChildViewController:[GZCEManagerSexMineViewController new] notmalimageNamed:@"wode2_" selectedImage:@"wode1_" title:@"我的"];
        }
            break;
            
        case 7:
        {
            [self addChildViewController:[GZCEManagerHomeViewController new] notmalimageNamed:@"shouye2_" selectedImage:@"shouye1_" title:@"首页"];
            
            [self addChildViewController:[GZCERepresentDiscountViewController new] notmalimageNamed:@"youhui2_" selectedImage:@"youhui1_" title:@"优惠"];
            
            [self addChildViewController:[GZCERepresentCenterViewController new] notmalimageNamed:@"" selectedImage:@"" title:@""];
            
            [self addChildViewController:[GZCERepresentCommunityViewController new] notmalimageNamed:@"shequ2_" selectedImage:@"shequ1_" title:@"社区"];
            
            [self addChildViewController:[GZCEManagerSevenMineViewController new] notmalimageNamed:@"wode2_" selectedImage:@"wode1_" title:@"我的"];
        }
            break;
            
        case 8:
        {
            [self addChildViewController:[GZCEManagerHomeViewController new] notmalimageNamed:@"shouye2_" selectedImage:@"shouye1_" title:@"首页"];
            
            [self addChildViewController:[GZCERepresentDiscountViewController new] notmalimageNamed:@"youhui2_" selectedImage:@"youhui1_" title:@"优惠"];
            
            [self addChildViewController:[GZCERepresentCenterViewController new] notmalimageNamed:@"" selectedImage:@"" title:@""];
            
            [self addChildViewController:[GZCERepresentCommunityViewController new] notmalimageNamed:@"shequ2_" selectedImage:@"shequ1_" title:@"社区"];
            
            [self addChildViewController:[GZCEManagerEightMineViewController new] notmalimageNamed:@"wode2_" selectedImage:@"wode1_" title:@"我的"];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:childController];
    
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.title = title;
 
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];

    [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];

    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : MHColorFromHexString(@"#ddbb75"),NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];

    [self addChildViewController:nav];
}

//点击tabbar
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == 1
        || [tabBarController.childViewControllers indexOfObject:viewController] == 3) {

        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];
        return NO;
    }
    
    _tabbar.centerBtn.selected = NO;
    
//    if ([tabBarController.childViewControllers indexOfObject:viewController] == 4) {
//
//        if (![GZTool isLogin]) {
//
//            GZLoginViewController *loginVC = [[GZLoginViewController alloc]init];
//            CMHNavigationController *nv = [[CMHNavigationController alloc] initWithRootViewController:loginVC];
//
//            [self presentViewController:nv animated:YES completion:nil];
//
//            return NO;
//        }
//    }
    return YES;
}

- (void)setCustomtabbar{
    
    _tabbar = [[GZCenterTabBar alloc] init];
    
    [_tabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_tabbar forKeyPath:@"tabBar"];
}

#pragma mark - 中间按钮点击事件
- (void)buttonAction:(UIButton *)button
{
    button.selected = YES;
    self.selectedIndex = 2;
}

@end

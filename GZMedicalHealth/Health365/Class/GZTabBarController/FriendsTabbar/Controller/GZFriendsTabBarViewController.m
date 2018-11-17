//
//  GZFriendsTabBarViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZFriendsTabBarViewController.h"
#import "CMHNavigationController.h"

#import "GZMailListViewController.h"
#import "GZFriendsViewController.h"
#import "GZCERepresentAddFriendsViewController.h"

@interface GZFriendsTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation GZFriendsTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setupBasic];
}

- (void)setupBasic
{
    [self addChildViewController:[GZFriendsViewController new] notmalimageNamed:@"tabbar_discover_23x23" selectedImage:@"tabbar_discoverHL_23x23" title:@"好友互动" itemTag:0];

    [self addChildViewController:[GZMailListViewController new] notmalimageNamed:@"tabbar_contacts_27x23" selectedImage:@"tabbar_contactsHL_27x23" title:@"通讯录" itemTag:1];
}

- (void)addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title itemTag:(NSInteger)itemTag
{
    CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:childController];
    
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.tag = itemTag;
    
    childController.title = title;
    
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : MHColorFromHexString(@"#929292"),NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}

//点击tabbar
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
        {
            self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:@"好友互动" selectTitle:nil titleColor:MHColorFromHexString(@"#343434") titleFont:MHRegularFont_16 imageName:@"navigationButtonReturn" target:self action:@selector(_backItemDidClicked)];
            
            self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:@"" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(noClick)];

        }
            break;

        case 1:
        {
             self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:@"通讯录" selectTitle:nil titleColor:MHColorFromHexString(@"#343434") titleFont:MHRegularFont_16 imageName:@"navigationButtonReturn" target:self action:@selector(_backItemDidClicked)];
            
            self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:@"添加" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(addFriends)];
        }
            break;

        default:
            break;
    }
}

-(void)noClick
{
    
}

- (void)_backItemDidClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addFriends
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"添加好友";
    nav.titleNameColor = nil;
    
    [self.navigationController pushViewController:[GZCERepresentAddFriendsViewController new] animated:YES];
}

@end

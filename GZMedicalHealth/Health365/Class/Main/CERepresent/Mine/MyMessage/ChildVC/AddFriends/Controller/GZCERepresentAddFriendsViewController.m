//
//  GZCERepresentAddFriendsViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentAddFriendsViewController.h"

@interface GZCERepresentAddFriendsViewController ()

@end

@implementation GZCERepresentAddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:@"发送" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(addFriends)];

}

- (void)addFriends
{
//    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
//    nav.titleName = @"添加好友";
//    [self.navigationController pushViewController:[GZCERepresentAddFriendsViewController new] animated:YES];
}


@end

//
//  GZCERepresentMyPointsRightTableViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMyPointsRightTableViewController.h"
#import "UIViewController+YNPageExtend.h"
#import "GZCERepresentMyPointsLeftViewController.h"
#import "GZCERepresentMyPointsRightOneTableViewController.h"

@interface GZCERepresentMyPointsRightTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation GZCERepresentMyPointsRightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"-------------%ld", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = nil;
    nav.titleNameColor = nil;
    
    [self.navigationController pushViewController:[GZCERepresentMyPointsRightOneTableViewController new] animated:YES];
}

@end

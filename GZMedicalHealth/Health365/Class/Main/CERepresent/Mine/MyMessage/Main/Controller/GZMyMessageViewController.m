//
//  GZMyMessageViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZMyMessageViewController.h"
#import "GZFriendsTabBarViewController.h"

#import "GZCERepresentMineTableViewCell.h"
#import "GZMailListViewController.h"
#import "GZFriendsViewController.h"
#import "GZCERepresentPlatformPushViewController.h"
#import "GZCERepresentConferencePushViewController.h"

@interface GZMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *cellID = @"cellID";

@implementation GZMyMessageViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航栏
        self.prefersNavigationBarHidden = NO;
        
    }
    return self;
}

// 修改状态栏字体颜色， 白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZCERepresentMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.messageIndexPath = indexPath;
    cell.dict = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {    // 好友互动
        case 0:
        {
         
        }
            break;

        case 1:
        {
            
        }
            break;

        case 2:
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"好友互动";
            nav.titleNameColor = nil;
            
            GZFriendsTabBarViewController *tabbarVC = [[GZFriendsTabBarViewController alloc] init];
            [self.navigationController pushViewController:tabbarVC animated:true];
        }
            break;
        
        case 3:
        {
  
        }
            break;
            
        case 4:
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"平台推送";
            nav.titleNameColor = nil;
            
            [self.navigationController pushViewController:[GZCERepresentPlatformPushViewController new] animated:YES];
        }
            break;
            
        case 5:
        {
            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
            nav.titleName = @"会议签到";
            nav.titleNameColor = nil;
            
            [self.navigationController pushViewController:[GZCERepresentConferencePushViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getter
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Message" ofType:@"plist"];
        _dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    }
    return _dataArray;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.backgroundColor = MHColorFromHexString(@"#f3f3f3");
        [_tableView registerNib:[UINib nibWithNibName:@"GZCERepresentMineTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end

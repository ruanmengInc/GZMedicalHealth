//
//  GZCERepresentSettingViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/6.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentSettingViewController.h"
#import "GZChangeTelViewController.h"
#import "GZLoginViewController.h"

#import "CMHNavigationController.h"

#import "GZSetCell.h"
#import "UIImageView+WebCache.h"

@interface GZCERepresentSettingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) GZCERepresentBaseModel *model;

@end

static NSString *cellID = @"cellID";

@implementation GZCERepresentSettingViewController

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
    
    [self setData];

    [self setupUI];
}

- (void)setData
{
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"sys_set";
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        self.model =  responseObject;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        /// show error
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

-(void)setupUI
{
    self.tableView.tableFooterView = [UITableView new];
    self.tableView.tableHeaderView = [UITableView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZSetCell" bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - UITableViewDelegate 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
//    cell.telStr = self.tel;
    cell.indexPath = indexPath;
    cell.dataArray = self.dataArray;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictVC = self.dataArray[indexPath.section][indexPath.row];
    
    if (dictVC[@"controller"]) {
        
        if ([dictVC[@"controller"] isEqualToString:@"GZLoginController"]) {
            
            [self ShowAlertTitle:@"确定退出当前账号？" Message:nil Delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" Block:^(NSInteger index) {
                
                if (index) {
                    
                    /// 退出登录
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    [defaults removeObjectForKey:@"appid"];
                    [defaults removeObjectForKey:@"appsecret"];
                    [defaults removeObjectForKey:@"uid"];
                    
                    [defaults removeObjectForKey:@"U_nick"];
                    [defaults removeObjectForKey:@"U_token"];
                    [defaults removeObjectForKey:@"U_head"];
                    [defaults removeObjectForKey:@"mima"];

                    [defaults setBool:NO forKey:@"isLogin"];
                    
                    [defaults synchronize];
 
                    //退出融云聊天
                    [[RCIM sharedRCIM] logout];

                    //
                    //                    //闭极光推送
                    //                    [JPUSHService setTags:nil alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    //
                    //                    }];

                    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
                    UIWindow *theWindow = app.window;
                    
                    GZLoginViewController *login = [[GZLoginViewController alloc] init];
                    CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:login];
                    theWindow.rootViewController = nav;
                    
//                    GZLoginViewController *loginVC = [[GZLoginViewController alloc] init];
//
//                    CMHNavigationController *nav = [[CMHNavigationController alloc] initWithRootViewController:loginVC];
//
//                    [self.navigationController presentViewController:nav animated:YES completion:^{
//
//                        self.tabBarController.selectedIndex = 0;
//
//                        [self.navigationController popToRootViewControllerAnimated:YES];
//                    }];
                }
            }];
            
        } else if (indexPath.section == 0 && indexPath.row == 0) {
            
//            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
//            nav.titleName = @"更换手机号码";
//            nav.titleNameColor = nil;
//
//            [self.navigationController pushViewController:[GZChangeTelViewController new] animated:YES];

            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"开发中" delayTime:1.0];

        } else if (indexPath.section == 0 && indexPath.row == 1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.tel];

            UIWebView * callWebview = [[UIWebView alloc] init];
            
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
            [self.view addSubview:callWebview];
            
        } else if (indexPath.section == 0 && indexPath.row == 3) {
            
            [self ShowAlertTitle:@"提示" Message:@"是否清楚缓存？" Delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" Block:^(NSInteger index) {
                
                if (index == 1) {
                    
                    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                    [[SDWebImageManager sharedManager] cancelAll];
                    [self.tableView reloadData];
                }
                
            }];
            
        } else if (indexPath.section == 0 && indexPath.row == 4) {
            
            [self versionUpdate];
            
        } else {
            
            Class VCClass = NSClassFromString(dictVC[@"controller"]);
            
            UIViewController *VC = [[VCClass alloc] init];
            
            VC.navigationItem.title = dictVC[@"title"];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 46;
    }
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 52;
    }
    return 0.01;
}

#pragma mark 检查更新
- (void)versionUpdate{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    /* NSOrderedAscending = -1  升序
     
          * NSOrderedSame = 0        相等
          * NSOrderedDescending      降序
          
     */
    
    /// 判断当前版本与后台返回的版本, 后台版本 > 当前版本
    BOOL isVersion = [appCurVersion compare:[defaults valueForKey:@"health_verson"] options:NSCaseInsensitiveSearch];
    
    if (!isVersion) {
        
        [self ShowAlertTitle:@"有新版本,请更新~" Message:nil Delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去下载" Block:^(NSInteger index) {
            
            if (index == 1) {
                NSString *url = @"https://itunes.apple.com/us/app/id1253272773?l=zh&ls=1&mt=8";
                //       // https://itunes.apple.com/us/app/id1253272773?l=zh&ls=1&mt=8
                //        // https://itunes.apple.com/cn/app/qq/id444934666?mt=8 QQ在APPstore的网址
                //
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            
        }];
        
    }else
    {
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"当前已是最新版本~" delayTime:1.0];
    }
}

#pragma mark - Getter
-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
        NSArray *section1 = [[NSArray alloc] initWithContentsOfFile:plistPath];
        NSArray *section2 = @[@{@"title":@"退出当前账号",@"controller":@"GZLoginController"}];
        
        _dataArray = [NSArray arrayWithObjects:section1,section2, nil];
        
    }
    return _dataArray;
}

//此界面内存泄漏，MLeaksFinder框架检测到
//如果您的类设计为单例对象，或者由于某种原因您的类的对象不应该被解除锁定，那么通过返回NO，覆盖-（BOOL）willDealloc在您的类中。
- (BOOL)willDealloc {
    return NO;
}

@end


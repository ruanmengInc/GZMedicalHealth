//
//  GZScanCodeIntegrationViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZScanCodeIntegrationViewController.h"
//#import "GZIntegralExchangeResultsController.h"
#import "GZScanCodeIntegrationCell.h"
#import "GZScanCodeIntegrationModel.h"
#import "GZIntegralExchangeResultModel.h"
#import "LSXAlertInputView.h"
#import "GZTwoScavengingView.h"
#import "GZTwoSaleScanCodeViewController.h"

/** 扫描内容的 W 值 */
#define scanBorderW 0.8 * self.scanView.frame.size.width

/** 扫描内容的 高度 */
#define scanBorderH 0.6 * self.scanView.frame.size.height

/** 扫描内容的 x 值 */
#define scanBorderX 0.5 * (1 - 0.8) * self.scanView.frame.size.width
/** 扫描内容的 Y 值 */
#define scanBorderY 35

@interface GZScanCodeIntegrationViewController () <UITableViewDelegate,UITableViewDataSource>
{
    SGQRCodeObtain *obtain;
}

@property (nonatomic, strong) SGQRCodeScanView *scanView;

/**
 扫码View，最上面的扫码区域
 */
@property (weak, nonatomic) IBOutlet UIView *scanningRangeView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 扫码积分累计
 */
@property (nonatomic, assign) CGFloat accumulation;

/**
 扫码类型，0 手动输入， 1 扫码
 */
@property (nonatomic, copy) NSString *codeType;

@end

@implementation GZScanCodeIntegrationViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /// 二维码开启方法
    [obtain startRunningWithBefore:nil completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [obtain stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obtain = [SGQRCodeObtain QRCodeObtain];
    
    [self setupUI];
    [self setupQRCodeScan];
    [self setupNavigationBar];
}

#pragma mark - 布局UI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.scanningRangeView addSubview:self.scanView];
    
    self.tableView.tableFooterView = [UITableView new];
    self.tableView.tableHeaderView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"GZScanCodeIntegrationCell" bundle:nil] forCellReuseIdentifier:@"GZScanCodeIntegrationCell"];
    
    _codeType = @"";
    self.accumulation = 0.0;
}

#pragma mark - 创建扫描
- (void)setupQRCodeScan {
    __weak typeof(self) weakSelf = self;
    
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    configure.sampleBufferDelegate = YES;
    
    configure.rectOfInterest = CGRectMake(0, 0, 282 / self.view.bounds.size.height, 1);

    [obtain establishQRCodeObtainScanWithController:self configure:configure];
    [obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        if (result) {
            [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"正在处理..." toView:weakSelf.view];
            [obtain stopRunning];
            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            
            // 延迟2s
            sleep(2);
            
            [weakSelf scanResultsData:result];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [MBProgressHUD SG_hideHUDForView:weakSelf.view];
                [obtain startRunning];
            });
        }else
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"暂未识别出扫描的二维码" delayTime:1.0];
        }
    }];
}

#pragma mark - 开灯
- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"开灯" selectTitle:@"关灯" titleColor:MHColorFromHexString(@"#dcbe75") titleFont:MHRegularFont_16 imageName:@"kaideng_" target:self action:@selector(openLighting:)];
}


#pragma mark - UITableViewDelegate 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZScanCodeIntegrationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZScanCodeIntegrationCell" forIndexPath:indexPath];
    
    cell.saomaModel = self.dataArray[indexPath.row];

    if (!cell.deleteBlock) {

        __weak typeof(tableView) weakTableView = tableView;

        cell.deleteBlock = ^(UITableViewCell * currentCell){

            NSInteger row = [tableView indexPathForCell:currentCell].row;

            __strong typeof(tableView) strongTableView = weakTableView;

            [strongTableView deleteRowsAtIndexPaths:@[[self removeDataAtIndex:row]]
                                   withRowAnimation:UITableViewRowAnimationAutomatic];

            [strongTableView reloadData];

            self.numLab.text = [NSString stringWithFormat:@"%ld",self.dataArray.count];
        };
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

#pragma mark - 删除选择的row
- (NSIndexPath *)removeDataAtIndex:(NSInteger)row
{
    NSMutableArray *copyArray = [NSMutableArray  arrayWithArray:self.dataArray];
    [copyArray removeObjectAtIndex:row];
    
    self.dataArray = [NSMutableArray arrayWithArray:copyArray];
    
    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:0];
    
    return path;
}

#pragma mark - 扫描请求网络
- (void)scanResultCodeNetwork:(NSString *)codeStr
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    if ([self.fromType isEqualToString:@"RuKuScanCode"]) {  // 入库扫码
        
        subscript[@"action"] = @"user_365_rukuscan";
        
    }else if ([self.fromType isEqualToString:@"ScanCodeIntegration"]){  // 扫码销售
        
        subscript[@"action"] = @"user_365_salescan";
    }
    
    subscript[@"uid"] = [GZTool isUid];
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"tiaoma"] = codeStr;
    
    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [self.dataArray addObject:responseObject];
        [self.tableView reloadData];

        self.numLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.dataArray.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {

        [self ShowAlertWithMessage:[NSError mh_tipsFromError:error]];
    }];
}

#pragma mark - 确认信息
- (IBAction)sureInformation:(UIButton *)sender
{
    if (self.dataArray.count <= 0) {
        
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"暂无药品" delayTime:1.0];
        return;
    }
    
    [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"Load..." toView:self.view];
    
    // 拼接条形码
    NSMutableArray *sureArray = [NSMutableArray array];
    
    for (GZCERepresentBaseModel *data in self.dataArray) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:data.tiaoma forKey:@"tm"];
        [sureArray addObject:dic];
    }
    
    /// 转换成 JSON
    NSData *data=[NSJSONSerialization dataWithJSONObject:sureArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];

    if ([self.fromType isEqualToString:@"RuKuScanCode"]) {  // 入库扫码
        
        subscript[@"action"] = @"user_365_ruku";
        
    }else if ([self.fromType isEqualToString:@"ScanCodeIntegration"]){  // 扫码销售
        
        subscript[@"action"] = @"user_sale";
        subscript[@"id"] = self.ID;
    }
    
    subscript[@"uid"] = [GZTool isUid];
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"lat"] = self.lat;
    subscript[@"lng"] = self.lng;
    subscript[@"address"] = self.city;
    subscript[@"shopid"] = self.shopid;
    subscript[@"tiaoma"] = jsonStr;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];

    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {

        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        
        self.numLab.text = [NSString stringWithFormat:@"%ld",self.dataArray.count];

        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"提交成功" delayTime:1.0];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {

        if ([[NSError mh_tipsFromError:error] isEqualToString:[NSString stringWithFormat:@"%ld",CMHHTTPResponseCodeNotData]]) {
            
            [self.dataArray removeAllObjects];
            [self.tableView reloadData];
            
            self.numLab.text = [NSString stringWithFormat:@"%ld",self.dataArray.count];
            
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"提交成功" delayTime:1.0];
            
        }else
        {
            [self ShowAlertWithMessage:[NSError mh_tipsFromError:error]];
        }
        
    }];
}

#pragma mark - 扫码结果请求数据
- (void)scanResultsData:(NSString *)codeStr
{
    for (GZCERepresentBaseModel *data in self.dataArray) {
        
        if ([codeStr isEqualToString:data.tiaoma]) {
            
            [self ShowAlertWithMessage:@"此药品已添加"];
            return;
        }
    }
    
    [self scanResultCodeNetwork:codeStr];
}

#pragma mark - 手动录入
- (IBAction)manualCodeEvents:(UIButton *)sender
{
    _codeType = @"1";

    LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"手工录入编码" PlaceholderText:@"请输入商品编码" WithKeybordType:LSXKeyboardTypeNumberPad CompleteBlock:^(NSString *contents) {

        if (contents.length != 20) {
            
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"请输入20位编码" delayTime:1.0];
            return ;
        }
        
        [self scanResultsData:contents];

    }];
    [alert show];
}

#pragma mark - - - 照明灯的点击事件
-(void)openLighting:(UIButton *)sender
{
    if (sender.selected == NO) { // 点击打开照明灯
        sender.selected = YES;
        [obtain openFlashlight];
        
    } else { // 点击关闭照明灯
    
         sender.selected = NO;
        [obtain closeFlashlight];
    }
}

#pragma mark - 移除扫描器
- (void)removeScanningView {
    
    [obtain stopRunning];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

#pragma mark - Getter
- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, 0, self.scanningRangeView.GZ_width * KsuitParam, self.scanningRangeView.GZ_height * KsuitParam)];
    }
    return _scanView;
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)dealloc
{
    [self removeScanningView];
}

//此界面内存泄漏，MLeaksFinder框架检测到
//如果您的类设计为单例对象，或者由于某种原因您的类的对象不应该被解除锁定，那么通过返回NO，覆盖-（BOOL）willDealloc在您的类中。
- (BOOL)willDealloc {
    return NO;
}

@end

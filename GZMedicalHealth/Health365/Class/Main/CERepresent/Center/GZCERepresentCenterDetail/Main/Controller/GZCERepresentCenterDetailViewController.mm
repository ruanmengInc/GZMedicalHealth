//
//  GZCERepresentCenterDetailViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCenterDetailViewController.h"
#import "GZCERepresentForecastStockOneViewController.h"
#import "GZMapNavigationView.h"
#import "GZCERepresentCenterDetailShowView.h"
#import "GZCERepresentCenterDetailModel.h"

#import "GZScanCodeIntegrationViewController.h"

@interface GZCERepresentCenterDetailViewController ()<SDCycleScrollViewDelegate,BMKLocationServiceDelegate>
{
    double _lat;
    double _lng;
    NSString *_type;
}

@property (weak, nonatomic) IBOutlet SDCycleScrollView *MainSDCycle;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *souCangBtn;

/**
 地图
 */
@property (nonatomic, strong)GZMapNavigationView *mapNavigationView;

@end

@implementation GZCERepresentCenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSDCycleView];
    
    [self intefaceData];
}

#pragma mark - 轮播图
- (void)createSDCycleView
{
    self.MainSDCycle.delegate = self;
    
    self.MainSDCycle.backgroundColor = [UIColor clearColor];
    
    self.MainSDCycle.currentPageDotColor = MHColor(0, 153, 255);
    self.MainSDCycle.pageDotColor = [UIColor whiteColor];
    self.MainSDCycle.placeholderImage = [UIImage imageNamed:@"yaodiantu"];
    self.MainSDCycle.autoScroll = NO;
    self.MainSDCycle.showPageControl = NO;
    
    self.addressBtn.titleLabel.numberOfLines = 2;
    
    _lat = 0;
    _lng = 0;
}

#pragma mark - 界面数据
- (void)intefaceData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];

    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_shopinfo";
    subscript[@"id"] = self.shopID;
    subscript[@"uid"] = [GZTool isNotLoginUid];
    
    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentCenterDetailModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentCenterDetailModel * responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
       
        _lat = [responseObject.lat doubleValue];
        _lng = [responseObject.lng doubleValue];
        _type = responseObject.collect;
        
        self.titLab.text = responseObject.name;
        [self.addressBtn setTitle:responseObject.address forState:UIControlStateNormal];
        
        if ([responseObject.collect integerValue] > 0) {
            
            [self.souCangBtn setImage:[UIImage imageNamed:@"shoucang2_"] forState:UIControlStateNormal];
        }else
        {
            [self.souCangBtn setImage:[UIImage imageNamed:@"quxiaoshoucang_"] forState:UIControlStateNormal];
        }
        
        if (responseObject.logo.count > 0) {
            
            self.numLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self.MainSDCycle.imageURLStringsGroup.count];
        }else
        {
            self.numLab.text = [NSString stringWithFormat:@"0/%lu",(unsigned long)self.MainSDCycle.imageURLStringsGroup.count];
        }
  
        self.MainSDCycle.imageURLStringsGroup = responseObject.logo;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - 收藏
- (void)collectionData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    /// 1. 配置参数
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    subscript[@"action"] = @"user_365_collectshop";
    subscript[@"id"] = self.shopID;
    subscript[@"uid"] = [GZTool isNotLoginUid];
    subscript[@"type"] = _type;

    /// 2. 配置参数模型 #define CMH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentCenterDetailModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO success:^(NSURLSessionDataTask *task, GZCERepresentCenterDetailModel * responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        _type = responseObject.collect;

        if ([responseObject.collect integerValue] > 0) {

            [self.souCangBtn setImage:[UIImage imageNamed:@"shoucang2_"] forState:UIControlStateNormal];

        }else
        {
            [self.souCangBtn setImage:[UIImage imageNamed:@"quxiaoshoucang_"] forState:UIControlStateNormal];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
        [MBProgressHUD mh_showErrorTips:error addedToView:self.view];
    }];
}

#pragma mark - 入库前判断
- (void)terminalData
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_rukunear";
    subscript[@"lng"] = self.ownLng;
    subscript[@"lat"] = self.ownLat;
    subscript[@"zid"] = self.shopID;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:NO isShowHudMsg:NO  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        /// 请求失败的回调，
        /// 客户端一般只需要关心出错的原因是：
        /// - 网络问题0
        /// - 服务器问题
        /// 只需要设置 errorInfo 和 hasError == YES , hasData
        
        if ([[NSError mh_tipsFromError:error] isEqualToString:[NSString stringWithFormat:@"%ld",CMHHTTPResponseCodeNotData]]) {
            
            GZCERepresentCenterDetailShowView *twoScavengingVC = [GZCERepresentCenterDetailShowView createGZCERepresentCenterDetailShowView];
            
            twoScavengingVC.titleLab.text = @"入库扫码";
            twoScavengingVC.sureBlock = ^{
                
                CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
                nav.titleName = @"入库扫码";
                nav.titleNameColor = nil;
                
                GZScanCodeIntegrationViewController *scanCodeIntegrationVC = [[GZScanCodeIntegrationViewController alloc] init];
                
                scanCodeIntegrationVC.lat = [NSString stringWithFormat:@"%f",_lat];
                scanCodeIntegrationVC.lng = [NSString stringWithFormat:@"%f",_lng];
                scanCodeIntegrationVC.city = self.addressBtn.titleLabel.text;
                
                scanCodeIntegrationVC.shopid = self.shopID;
                
                scanCodeIntegrationVC.fromType = @"RuKuScanCode";
                
                [self.navigationController pushViewController:scanCodeIntegrationVC animated:YES];
                
                //                CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
                //                nav.titleName = @"二次销售扫码";
                //                nav.titleNameColor = nil;
                //
                //                [self.navigationController pushViewController:[GZTwoSaleScanCodeViewController new] animated:YES];
            };
            
            [twoScavengingVC show];
            
        }else
        {
            [self ShowAlertWithMessage:[NSError mh_tipsFromError:error]];
        }
        
        [MBProgressHUD mh_hideHUDForView:self.view];
    }];
}

- (IBAction)btnEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:    //电话
        {

        }
            break;
            
        case 11:    //地图
        {
            [self.mapNavigationView showMapNavigationViewWithtargetLatitude:_lat targetLongitute:_lng toName:self.titLab.text];
            
            [self.view addSubview:self.mapNavigationView];
        }
            break;
            
        case 12:    //预估库存
        {
//            CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
//            nav.titleName = @"预估库存";
//            nav.titleNameColor = nil;
//
//            [self.navigationController pushViewController:[GZCERepresentForecastStockOneViewController new] animated:YES];
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];

        }
            break;
            
        case 13:    //预估销量
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];

        }
            break;
            
        case 14:    //优惠活动
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];

        }
            break;
            
        case 15:    //发消息
        {
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];

        }
            break;
            
        case 16:   //入库扫码
        {
            if ([[GZTool jinStatus] isEqualToString:@"0"]) {
                
                if ([self.gl isEqualToString:[GZTool isNotLoginUid]]) {     // gl与id相同，自己的店
                    
                    [self terminalData];
                    
                }else
                {
                    [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"不能入库自己未关联的店" delayTime:1.0];
                }
                
            }else
            {
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"您的账号已被禁用" delayTime:1.0];
            }
            
            
           
        }
            break;
            
        case 17:    //礼品兑换
        {
//            GZCERepresentCenterDetailShowView *twoScavengingVC = [GZCERepresentCenterDetailShowView createGZCERepresentCenterDetailShowView];
//
//            twoScavengingVC.titleLab.text = @"礼品兑换";
//            twoScavengingVC.sureBlock = ^{
//
////                CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
////                nav.titleName = @"二次销售扫码";
////                nav.titleNameColor = nil;
////
////                [self.navigationController pushViewController:[GZTwoSaleScanCodeViewController new] animated:YES];
//            };
//
//            [twoScavengingVC show];
            [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"此功能暂未开放，请继续等待" delayTime:1.0];

        }
            break;
            
        case 18:    //收藏
        {
            [self collectionData];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 轮播图事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.numLab.text = [NSString stringWithFormat:@"%ld/%lu",index + 1,(unsigned long)self.MainSDCycle.imageURLStringsGroup.count];
}

- (GZMapNavigationView *)mapNavigationView
{
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[GZMapNavigationView alloc]init];
    }
    return _mapNavigationView;
}

@end

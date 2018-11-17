//
//  GZPersonalDataViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZPersonalDataViewController.h"
#import "GZCERepresentProvinceController.h"

@interface GZPersonalDataViewController ()<TZImagePickerControllerDelegate>
{
    NSString *_headImgStr;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *quyuBtn;

@end

@implementation GZPersonalDataViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.provience isEqual: @""]) {
        
        [self.quyuBtn setTitle:self.location forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

    [self editData];
}

- (void)setupUI
{
    self.provience = @"";
    self.city = @"";
    self.county = @"";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_RightItemWithTitle:@"确定" selectTitle:nil titleColor:MHColorFromHexString(@"#d6be73") titleFont:MHRegularFont_16 imageName:nil target:self action:@selector(_backItemDidClicked)];
}

- (void)editData
{
    self.nameTF.text = self.model.nickname;
    self.telTF.text = self.model.tel;
    self.addressTF.text = self.model.address;
    [self.quyuBtn setTitle:self.model.sname forState:UIControlStateNormal];

    [self.headImgV yy_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholder:MHImageNamed(@"placeholder_image") options:CMHWebImageOptionAutomatic completion:NULL];
}

#pragma mark - 确定
- (void)_backItemDidClicked
{
    [MBProgressHUD mh_showProgressHUD:@"Loadind..." addedToView:self.view];
    
    CMHKeyedSubscript *subscript = [CMHKeyedSubscript subscript];
    
    subscript[@"action"] = @"user_365_changeinfo";
    subscript[@"timestamp"] = [NSString getNowTimeTimestamp];
    subscript[@"uid"] = [GZTool isUid];
    subscript[@"nickname"] = self.nameTF.text;
    subscript[@"realname"] = @"";
    subscript[@"pro"] = self.provienceID;
    subscript[@"city"] = self.cityID;
    subscript[@"county"] = self.countyID;
    subscript[@"address"] = self.addressTF.text;
    subscript[@"logo"] = _headImgStr;

    /// 2. 配置参数模型
    CMHURLParameters *paramters = [CMHURLParameters urlParametersWithMethod:CMH_HTTTP_METHOD_POST path:Healthy_365_Url parameters:subscript.dictionary];
    
    [[CMHHTTPRequest requestWithParameters:paramters] enqueueResultClass:GZCERepresentBaseModel.class parsedResult:YES isRequestHead:YES isShowHudMsg:YES  success:^(NSURLSessionDataTask *task, GZCERepresentBaseModel *responseObject) {
        
        [MBProgressHUD mh_hideHUDForView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        
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

#pragma mark - 修改头像
- (IBAction)btnEvents:(UIButton *)sender
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowPickingImage=YES;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
    imagePickerVc.naviTitleColor = [UIColor blackColor];

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSString *img1 = @"";
        NSData *imageData =UIImageJPEGRepresentation(photos[0],0.4);
        img1 = [imageData base64EncodedStringWithOptions:0];
        
        _headImgStr = img1;
        
        self.headImgV.image = photos[0];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 所在区域
- (IBAction)addressEvents:(UIButton *)sender
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"个人资料";
    nav.titleNameColor = nil;
    
    [self.navigationController pushViewController:[GZCERepresentProvinceController new] animated:YES];
}

@end


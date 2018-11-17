//
//  GZSetCell.m
//  jadeCircle
//
//  Created by guGuangZhou on 2017/8/21.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import "GZSetCell.h"
#import "UIImageView+WebCache.h"

@interface GZSetCell ()

@property (nonatomic, strong) UILabel *exitLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *MySwitch;

@property (nonatomic, strong) UILabel *versionUpdateLabel;
/// 客服
@property (nonatomic,strong) UILabel *customerServiceLabel;

@end

@implementation GZSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    self.MySwitch.hidden = YES;
    self.titleLabel.hidden = NO;

    self.titleLabel.text  = dataArray[self.indexPath.section][self.indexPath.row][@"title"];

    if (self.indexPath.section == 1 && self.indexPath.row == 0) {
        
        self.titleLabel.hidden = YES;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);

        self.exitLabel.text = dataArray[self.indexPath.section][self.indexPath.row][@"title"];
        [self addSubview:self.exitLabel];
        
    }else if (self.indexPath.section == 0 && self.indexPath.row == 2) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.MySwitch.hidden = NO;
        
        self.MySwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);//缩放
        self.MySwitch.onTintColor = MHColorFromHexString(@"#659aff");
        
        if ([UIApplication sharedApplication].isRegisteredForRemoteNotifications) {
            
            self.MySwitch.on = YES;
            
        }else{
            
            self.MySwitch.on = NO;
        }
        
        [self.MySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        
    }else if (self.indexPath.section == 0 && self.indexPath.row == 3) {
    
        self.detailLabel.text = [self caCheSize];
        [self addSubview:self.detailLabel];
        
    }else if (self.indexPath.section == 0 && self.indexPath.row == 4) {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        // 当前应用软件版本  比如：1.0.1
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        self.versionUpdateLabel.text = appCurVersion;
        
        [self addSubview:self.versionUpdateLabel];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.exitLabel.frame = CGRectMake(25, 0, kScreenWidth - 50, self.GZ_height);

    self.versionUpdateLabel.frame = CGRectMake(kScreenWidth - 105, 0, 70, self.GZ_height);
}

#pragma mark - custom action
- (NSString *)caCheSize
{
    NSString *detailTitle = nil;
    CGFloat size = [SDImageCache sharedImageCache].getSize;

    if (size > 1024 * 1024){
        detailTitle = [NSString stringWithFormat:@"%.02fM",size / 1024 / 1024];
    }else if (size > 1024){
        detailTitle = [NSString stringWithFormat:@"%.02fKB",size / 1024];
    }else{
        detailTitle = [NSString stringWithFormat:@"%.02fB",size];
    }
    
    return detailTitle;
}

#pragma mark - UISwitch开关
- (void)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else{
        
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}

#pragma mark - Getter
-(UILabel *)exitLabel
{
    if (_exitLabel == nil) {
        _exitLabel = [[UILabel alloc] init];
        
        _exitLabel.backgroundColor = MHColor(76, 157, 254);
        _exitLabel.textAlignment = NSTextAlignmentCenter;
        _exitLabel.font = [UIFont systemFontOfSize:16];
        _exitLabel.textColor = [UIColor whiteColor];
        _exitLabel.layer.masksToBounds = YES;
        _exitLabel.layer.cornerRadius = 23;
    }
    return _exitLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 120, 0, 90, self.GZ_height)];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.textColor = MHColorFromHexString(@"#deba79");
    }
    return _detailLabel;
}

-(UILabel *)customerServiceLabel
{
    if (!_customerServiceLabel) {
        _customerServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 0, 90, self.GZ_height)];
        _customerServiceLabel.font = [UIFont systemFontOfSize:13];
        _customerServiceLabel.textAlignment = NSTextAlignmentRight;
        _customerServiceLabel.textColor = MHColorFromHexString(@"#deba79");
    }
    return _customerServiceLabel;
}

-(UILabel *)versionUpdateLabel
{
    if (_versionUpdateLabel == nil) {
        _versionUpdateLabel = [[UILabel alloc] init];
        _versionUpdateLabel.textColor = MHColorFromHexString(@"#deba79");
        _versionUpdateLabel.font = [UIFont systemFontOfSize:14];
        _versionUpdateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _versionUpdateLabel;
}

@end

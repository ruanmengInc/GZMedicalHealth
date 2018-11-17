//
//  GZScanCodeIntegrationCell.h
//  health365
//
//  Created by guGuangZhou on 2017/8/13.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZScanCodeIntegrationModel.h"

@interface GZScanCodeIntegrationCell : UITableViewCell

/**
 删除按钮回调
 */
@property (copy, nonatomic) void (^deleteBlock)(UITableViewCell * cell);

/**
 每条cell的数据
 */
@property (nonatomic, strong) GZScanCodeIntegrationData *data;

@property (nonatomic, strong) GZCERepresentBaseModel *saomaModel;

/**
 初始化cell
 
 */
+ (instancetype)cellWithTable:(UITableView *)tableView;

@end

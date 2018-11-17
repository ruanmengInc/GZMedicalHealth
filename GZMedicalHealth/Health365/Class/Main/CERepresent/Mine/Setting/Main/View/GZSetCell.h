//
//  GZSetCell.h
//  jadeCircle
//
//  Created by guGuangZhou on 2017/8/21.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZSetCell : UITableViewCell

@property (nonatomic, copy) NSString *telStr;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *detailLabel;

/// 版本
@property (nonatomic,strong) UILabel *editionLabel;

@end

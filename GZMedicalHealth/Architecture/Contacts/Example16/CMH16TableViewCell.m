//
//  CMH16TableViewCell.m
//  MHDevelopExample
//
//  Created by Apple on 2018/8/3.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "CMH16TableViewCell.h"

@implementation CMH16TableViewCell

#pragma mark - Public Method
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"CMH16TableViewCell";
    CMH16TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [self mh_viewFromXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - Public Method
- (void)configureModel:(id )example{
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  GZChooseCityTableViewCell.m
//  health365
//
//  Created by GuangZhou Gu on 17/8/3.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZChooseCityTableViewCell.h"

@implementation GZChooseCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTable:(UITableView *)tableView{
    
    static NSString *cellID = @"myCellId";
    
    GZChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [GZChooseCityTableViewCell mh_viewFromXib];
    }
    
    return cell;
}

@end

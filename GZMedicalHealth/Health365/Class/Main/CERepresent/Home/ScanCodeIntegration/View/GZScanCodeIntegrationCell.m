//
//  GZScanCodeIntegrationCell.m
//  health365
//
//  Created by guGuangZhou on 2017/8/13.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZScanCodeIntegrationCell.h"

@interface GZScanCodeIntegrationCell ()

@property (weak, nonatomic) IBOutlet UILabel *drugNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sweepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *drugCodeLabel;


@end

@implementation GZScanCodeIntegrationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 删除按钮
 */
- (IBAction)deleteBtnEvents:(UIButton *)sender {
    if (_deleteBlock) {
        _deleteBlock(self);
    }
}

-(void)setData:(GZScanCodeIntegrationData *)data
{
    _data = data;
    
    self.drugNameLabel.text = data.name;
    self.sweepTimeLabel.text = data.date;
    self.drugCodeLabel.text = data.code;
}

-(void)setSaomaModel:(GZCERepresentBaseModel *)saomaModel
{
    _saomaModel = saomaModel;
    
    self.drugNameLabel.text = saomaModel.name;
    self.sweepTimeLabel.text = saomaModel.date;
    self.drugCodeLabel.text = saomaModel.tiaoma;
}


@end

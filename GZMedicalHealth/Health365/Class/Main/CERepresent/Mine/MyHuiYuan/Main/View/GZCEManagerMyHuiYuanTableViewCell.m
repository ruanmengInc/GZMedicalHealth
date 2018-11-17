//
//  GZCEManagerMyHuiYuanTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerMyHuiYuanTableViewCell.h"

@interface GZCEManagerMyHuiYuanTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *jifenLab;
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end

@implementation GZCEManagerMyHuiYuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setHourDic:(NSDictionary *)hourDic
{
    _hourDic = hourDic;
    
    self.jifenLab.textColor = MHColor(255, 102, 102);
    
    if ([self.type integerValue] == 3) {
        
        self.jifenLab.textColor = MHColor(255, 102, 102);
    }else
    {
        self.jifenLab.textColor = MHColor(219, 186, 118);
    }
    
    if ([hourDic[@"jifen"] integerValue] > 0) {
        
        self.jifenLab.text = [NSString stringWithFormat:@"+%@",hourDic[@"jifen"]];
    }else
    {
        self.jifenLab.text = [NSString stringWithFormat:@"%@",hourDic[@"jifen"]];
    }
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",hourDic[@"name"]];
    self.guigeLab.text = [NSString stringWithFormat:@"%@",hourDic[@"tel"]];
    self.numLab.text = [NSString stringWithFormat:@"%@",hourDic[@"date"]];
}

- (IBAction)telEvents:(UIButton *)sender
{
    if (self.btnEventsBlock) {
        self.btnEventsBlock(sender.tag);
    }
}


@end

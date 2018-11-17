//
//  GZCEManagerHourDetailTwoTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerHourDetailTwoTableViewCell.h"

@interface GZCEManagerHourDetailTwoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *jifenLa;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;

@end

@implementation GZCEManagerHourDetailTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHourDic:(NSDictionary *)hourDic
{
    _hourDic = hourDic;
    
    if ([self.type integerValue] == 3) {
        
        self.jifenLa.textColor = MHColor(255, 102, 102);
    }else
    {
        self.jifenLa.textColor = MHColor(219, 186, 118);
    }
    
    if ([hourDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLa.text = [NSString stringWithFormat:@"+%@",hourDic[@"jixiao"]];
    }else
    {
        self.jifenLa.text = [NSString stringWithFormat:@"%@",hourDic[@"jixiao"]];
    }
    
    self.lab1.text = [NSString stringWithFormat:@"%@",hourDic[@"name"]];
    self.lab2.text = [NSString stringWithFormat:@"%@",hourDic[@"guige"]];
    self.lab3.text = [NSString stringWithFormat:@"%@",hourDic[@"tiaoma"]];
    self.lab4.text = [NSString stringWithFormat:@"操作人：%@",hourDic[@"xingming"]];
    self.lab5.text = [NSString stringWithFormat:@"%@",hourDic[@"date"]];

}

@end

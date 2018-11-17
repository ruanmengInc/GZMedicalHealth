//
//  GZCERepresentHourDetailAchievementsTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentHourDetailAchievementsTableViewCell.h"

@interface GZCERepresentHourDetailAchievementsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *jifenLab;

@end

@implementation GZCERepresentHourDetailAchievementsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setHourDic:(NSDictionary *)hourDic
{
    _hourDic = hourDic;
    
    if ([hourDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLab.text = [NSString stringWithFormat:@"+%@",hourDic[@"jixiao"]];
    }else
    {
        self.jifenLab.text = [NSString stringWithFormat:@"%@",hourDic[@"jixiao"]];
    }

    self.lab1.text = [NSString stringWithFormat:@"%@",hourDic[@"name"]];
    self.lab2.text = [NSString stringWithFormat:@"%@",hourDic[@"tiaoma"]];
    self.lab3.text = [NSString stringWithFormat:@"%@",hourDic[@"xingming"]];
    self.lab4.text = [NSString stringWithFormat:@"+%@",hourDic[@"dname"]];
    self.lab5.text = [NSString stringWithFormat:@"%@",hourDic[@"date"]];
}

-(void)setCEManagerHourDic:(NSDictionary *)CEManagerHourDic
{
    _CEManagerHourDic = CEManagerHourDic;

    if ([CEManagerHourDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLab.text = [NSString stringWithFormat:@"+%@",CEManagerHourDic[@"jixiao"]];
    }else
    {
        self.jifenLab.text = [NSString stringWithFormat:@"%@",CEManagerHourDic[@"jixiao"]];
    }
    
    self.lab1.text = [NSString stringWithFormat:@"%@",CEManagerHourDic[@"name"]];
    self.lab2.text = [NSString stringWithFormat:@"%@",CEManagerHourDic[@"tiaoma"]];
    self.lab3.text = [NSString stringWithFormat:@"%@",CEManagerHourDic[@"date"]];
}

@end

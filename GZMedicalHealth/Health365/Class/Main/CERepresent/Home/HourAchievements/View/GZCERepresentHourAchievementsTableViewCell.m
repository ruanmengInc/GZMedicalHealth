//
//  GZCERepresentHourAchievementsTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentHourAchievementsTableViewCell.h"

@interface GZCERepresentHourAchievementsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *jifenLa;

@end

@implementation GZCERepresentHourAchievementsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setHourDic:(NSDictionary *)hourDic
{
    _hourDic = hourDic;

    self.jifenLa.textColor = MHColor(255, 102, 102);

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
    
    self.titleLab.text = [NSString stringWithFormat:@"%@",hourDic[@"name"]];
}

@end

//
//  GZCEManagerHourDetailTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerHourDetailTableViewCell.h"

@interface GZCEManagerHourDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *jifenLab;
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end

@implementation GZCEManagerHourDetailTableViewCell

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
    
    if ([hourDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLab.text = [NSString stringWithFormat:@"+%@",hourDic[@"jixiao"]];
    }else
    {
        self.jifenLab.text = [NSString stringWithFormat:@"%@",hourDic[@"jixiao"]];
    }
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",hourDic[@"name"]];
    self.guigeLab.text = [NSString stringWithFormat:@"%@",hourDic[@"guige"]];
    self.numLab.text = [NSString stringWithFormat:@"共有%@条记录",hourDic[@"num"]];
}

@end

//
//  GZCERepresentMonthlyAchievementsTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMonthlyAchievementsTableViewCell.h"

@interface GZCERepresentMonthlyAchievementsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *jifenLa;
@property (weak, nonatomic) IBOutlet UIImageView *riqiImgV;

@end

@implementation GZCERepresentMonthlyAchievementsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    self.titleLab.hidden = NO;
    self.jifenLa.hidden = NO;
    self.riqiImgV.hidden = NO;

    if ([self.type integerValue] == 3) {
        
        self.jifenLa.textColor = MHColor(255, 102, 102);
    }else
    {
        self.jifenLa.textColor = MHColor(219, 186, 118);
    }
    
    if ([dic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLa.text = [NSString stringWithFormat:@"+%@",dic[@"jixiao"]];
    }else
    {
        self.jifenLa.text = [NSString stringWithFormat:@"%@",dic[@"jixiao"]];
    }
    
    self.titleLab.text = [NSString stringWithFormat:@"%@年%@月",dic[@"year"],dic[@"month"]];
}

-(void)setDayDic:(NSDictionary *)dayDic
{
    _dayDic = dayDic;
    
    self.titleLab.hidden = NO;
    self.jifenLa.hidden = NO;
    self.riqiImgV.hidden = NO;
    
    if ([self.type integerValue] == 3) {
        
        self.jifenLa.textColor = MHColor(255, 102, 102);
    }else
    {
        self.jifenLa.textColor = MHColor(219, 186, 118);
    }
    
    if ([dayDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLa.text = [NSString stringWithFormat:@"+%@",dayDic[@"jixiao"]];
    }else
    {
        self.jifenLa.text = [NSString stringWithFormat:@"%@",dayDic[@"jixiao"]];
    }
    
    self.titleLab.text = [NSString stringWithFormat:@"%@年%@月%@日",dayDic[@"year"],dayDic[@"month"],dayDic[@"day"]];
}

-(void)setCEManagerDic:(NSDictionary *)CEManagerDic
{
    _CEManagerDic = CEManagerDic;
    
    self.titleLab.hidden = NO;
    self.jifenLa.hidden = NO;
    self.riqiImgV.hidden = NO;

    if ([self.type integerValue] == 3) {
        
        self.jifenLa.textColor = MHColor(255, 102, 102);
    }else
    {
        self.jifenLa.textColor = MHColor(219, 186, 118);
    }
    
    if ([CEManagerDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLa.text = [NSString stringWithFormat:@"+%@",CEManagerDic[@"jixiao"]];
    }else
    {
        self.jifenLa.text = [NSString stringWithFormat:@"%@",CEManagerDic[@"jixiao"]];
    }
    
    self.titleLab.text = [NSString stringWithFormat:@"%@年%@月总绩效",CEManagerDic[@"year"],CEManagerDic[@"month"]];
}

-(void)setAchievementsDic:(NSDictionary *)AchievementsDic
{
    _AchievementsDic = AchievementsDic;
 
    self.titleLab.hidden = YES;
    self.jifenLa.hidden = YES;
    self.riqiImgV.hidden = YES;
}

-(void)setWeisaoDic:(NSDictionary *)weisaoDic
{
    _weisaoDic = weisaoDic;
    
    self.titleLab.hidden = NO;
    self.jifenLa.hidden = NO;
    self.riqiImgV.hidden = NO;
    
    self.jifenLa.textColor = MHColor(255, 102, 102);
    
    if ([weisaoDic[@"jixiao"] integerValue] > 0) {
        
        self.jifenLa.text = [NSString stringWithFormat:@"+%@",weisaoDic[@"jixiao"]];
    }else
    {
        self.jifenLa.text = [NSString stringWithFormat:@"%@",weisaoDic[@"jixiao"]];
    }

    self.titleLab.text = [NSString stringWithFormat:@"%@年%@月",weisaoDic[@"year"],weisaoDic[@"month"]];
}

@end

//
//  GZCERepresentMineHeaderView.m
//  GZMedicalHealth
///Users/Apple/Desktop/软盟/健康365/项目/恒瑞四期/365/GZMedicalHealth/GZMedicalHealth/Health365/Class/Main/CERepresent/Mine/Main/View/GZCERepresentMineHeaderView.h
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMineHeaderView.h"

@interface GZCERepresentMineHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titLab;

@end

@implementation GZCERepresentMineHeaderView

+ (instancetype)createCERepresentMineHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCERepresentMineHeaderView" owner:self options:nil][0];
}

-(void)setModel:(GZCERepresentBaseModel *)model
{
    _model = model;
    
    self.titLab.text = [NSString stringWithFormat:@"你好，%@",model.nickname];
    [self.imgV yy_setImageWithURL:[NSURL URLWithString:model.logo] placeholder:MHImageNamed(@"placeholder_image") options:CMHWebImageOptionAutomatic completion:NULL];
}

- (IBAction)btnEvents:(UIButton *)sender
{
    if (self.btnEventsBlock) {
        self.btnEventsBlock(sender.tag);
    }
}

@end

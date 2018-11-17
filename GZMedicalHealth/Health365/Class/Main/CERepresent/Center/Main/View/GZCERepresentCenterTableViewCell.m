//
//  GZCERepresentCenterTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/8.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCenterTableViewCell.h"

@interface GZCERepresentCenterTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *duiImgV;
@property (weak, nonatomic) IBOutlet UIImageView *huiImgV;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;

@property (weak, nonatomic) IBOutlet UIImageView *yaoDianImgV;

@end

@implementation GZCERepresentCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.duiImgV.hidden = YES;
    self.huiImgV.hidden = YES;
    self.yaoDianImgV.hidden = YES;
}

-(void)setModel:(GZCERepresentBaseModel *)model
{
    _model = model;
    
    self.titleLab.text = model.name;
    
    if (model.distance > 1) {
        [self.distanceBtn setTitle:[NSString stringWithFormat:@"%.2fkm",model.distance] forState:UIControlStateNormal];
    }else
    {
        [self.distanceBtn setTitle:[NSString stringWithFormat:@"%.fm",model.distance * 1000] forState:UIControlStateNormal];
    }
    
    if (([model.dui integerValue] > 0) && ([model.youhui integerValue] > 0)) {
        
        self.duiImgV.hidden = NO;
        self.huiImgV.hidden = NO;
        self.duiImgV.image = [UIImage imageNamed:@"duihuan_"];
        self.huiImgV.image = [UIImage imageNamed:@"youhui_"];
        
    }else if (([model.dui integerValue] == 0) && ([model.youhui integerValue] > 0))
    {
        self.duiImgV.hidden = NO;
        self.huiImgV.hidden = YES;
        self.duiImgV.image = [UIImage imageNamed:@"youhui_"];
        
    }else if (([model.dui integerValue] > 0) && ([model.youhui integerValue] == 0))
    {
        self.duiImgV.hidden = NO;
        self.huiImgV.hidden = YES;
        self.duiImgV.image = [UIImage imageNamed:@"duihuan_"];
        
    }else if (([model.dui integerValue] == 0) && ([model.youhui integerValue] == 0))
    {
        self.duiImgV.hidden = YES;
        self.huiImgV.hidden = YES;
    }
    
    if ([[GZTool isNotLoginUid] isEqualToString:model.gl]) {
        
        self.yaoDianImgV.hidden = NO;
        self.yaoDianImgV.image = [UIImage imageNamed:@"shoucang_"];
        
    }else if (![[GZTool isNotLoginUid] isEqualToString:model.gl])
    {
        if ([model.guanzhu integerValue] > 0) {
            
            self.yaoDianImgV.hidden = NO;
            self.yaoDianImgV.image = [UIImage imageNamed:@"zhongxin_"];
            
        }else
        {
            self.yaoDianImgV.hidden = YES;
        }
    }
}

- (IBAction)telEvents:(UIButton *)sender
{
    if (self.btnEventsBlock) {
        self.btnEventsBlock(sender.tag);
    }
}

@end

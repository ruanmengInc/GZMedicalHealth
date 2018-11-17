//
//  GZCERepresentIntegralMallTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentIntegralMallTableViewCell.h"

@interface GZCERepresentIntegralMallTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *yaoLab;
@property (weak, nonatomic) IBOutlet UILabel *jifenLab;

@end

@implementation GZCERepresentIntegralMallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GZCERepresentBaseModel *)model
{
    _model = model;
    
    self.titleLa.text = model.name;
    self.numLab.text = model.guige;
    self.yaoLab.text = model.changjia;
    self.jifenLab.text = [NSString stringWithFormat:@"%.2f分",model.jifen];
    
    [self.imgV yy_setImageWithURL:[NSURL URLWithString:model.logo] placeholder:MHImageNamed(@"placeholder_image") options:CMHWebImageOptionAutomatic completion:NULL];
}

@end

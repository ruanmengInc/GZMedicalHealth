//
//  GZCERepresentMineTableViewCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMineTableViewCell.h"

@interface GZCERepresentMineTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *repLab;
@property (weak, nonatomic) IBOutlet UILabel *integralLab;

@end

@implementation GZCERepresentMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    self.imgV.image = [UIImage imageNamed:dict[@"icon"]];
}

-(void)setMineIndexPath:(NSIndexPath *)mineIndexPath
{
    _mineIndexPath = mineIndexPath;
    
    self.repLab.hidden = YES;
    self.integralLab.hidden = YES;
    
    switch (mineIndexPath.row) {
            
        case 1:
        {
            self.integralLab.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

-(void)setMessageIndexPath:(NSIndexPath *)messageIndexPath
{
    _messageIndexPath = messageIndexPath;

    self.titleLab.font = [UIFont systemFontOfSize:16];
    self.integralLab.hidden = YES;
    self.repLab.hidden = YES;

    switch (messageIndexPath.row) {
            
        case 0:
        {
            
            
        }
            break;
            
        case 1:
        {

        }
            break;
            
        case 2:
        {
            self.repLab.hidden = NO;
            
        }
            break;
            
        case 3:
        {
            
            
        }
            break;
            
        case 4:
        {
            self.repLab.hidden = NO;
        }
            break;
            
        case 5:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)setMineModel:(GZCERepresentBaseModel *)mineModel
{
    _mineModel = mineModel;

    self.integralLab.text = [NSString stringWithFormat:@"%.2f",mineModel.jifen];
    
    switch (self.mineIndexPath.row) {
            
        case 1:
        {
            if ([mineModel.isread integerValue] == 0) {
                
                self.repLab.hidden = YES;
            }else
            {
                self.repLab.hidden = NO;
            }
            
        }
            break;
            
        default:
            break;
    }
}

-(void)setCEManagerIndexPath:(NSIndexPath *)CEManagerIndexPath
{
    _CEManagerIndexPath = CEManagerIndexPath;
    
    self.titleLab.font = [UIFont systemFontOfSize:16];
    self.integralLab.hidden = YES;
    self.repLab.hidden = YES;
}

-(void)setCEManagerDict:(NSDictionary *)CEManagerDict
{
    _CEManagerDict = CEManagerDict;
    
    self.titleLab.text = [NSString stringWithFormat:@"%@",CEManagerDict[@"title"]];
    self.imgV.image = [UIImage imageNamed:CEManagerDict[@"icon"]];
}

-(void)setCEManagerMineModel:(GZCERepresentBaseModel *)CEManagerMineModel
{
    _CEManagerMineModel = CEManagerMineModel;
    
    switch (self.CEManagerIndexPath.row) {
        
        case 0:
        {
            self.integralLab.hidden = YES;
                        
        }
            break;
            
        case 1:
        {
            self.integralLab.hidden = NO;
            
            self.integralLab.text = [NSString stringWithFormat:@"%.2f",CEManagerMineModel.jifen];

        }
            break;

        case 2:
        {
            self.integralLab.hidden = NO;

            self.integralLab.text = [NSString stringWithFormat:@"%.2f",CEManagerMineModel.liuxiang];

        }
            break;

        case 3:
        {
            if ([CEManagerMineModel.isread integerValue] == 0) {
                
                self.repLab.hidden = YES;
            }else
            {
                self.repLab.hidden = NO;
            }
            
        }
            break;
            
        default:
            break;
    }
}

@end

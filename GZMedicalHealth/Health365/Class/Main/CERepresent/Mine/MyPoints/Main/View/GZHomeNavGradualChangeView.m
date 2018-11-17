//
//  GZHomeNavGradualChangeView.m
//  MedicalCompany
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZHomeNavGradualChangeView.h"

@implementation GZHomeNavGradualChangeView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backRootEvents.hidden = YES;
}

+ (instancetype)createHomeNavGradualChangeView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZHomeNavGradualChangeView" owner:self options:nil][0];
}

- (IBAction)searchEvents:(UIButton *)sender
{
    switch (sender.tag) {
    case 10:
    {
        [[self viewController].navigationController popViewControllerAnimated:YES];

    }
        break;
        
    case 11:
    {
        [[self viewController].navigationController popToRootViewControllerAnimated:YES];

    }
        break;
        
    default:
        break;
    }
}

@end

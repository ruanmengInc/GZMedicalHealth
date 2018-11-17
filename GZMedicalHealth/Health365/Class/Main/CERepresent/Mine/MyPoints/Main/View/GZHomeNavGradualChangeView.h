//
//  GZHomeNavGradualChangeView.h
//  MedicalCompany
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZHomeNavGradualChangeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UIButton *backRootEvents;


+ (instancetype)createHomeNavGradualChangeView;

@end

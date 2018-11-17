//
//  GZCERepresentAchievementsView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/20.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentAchievementsView.h"

@implementation GZCERepresentAchievementsView

+ (instancetype)createGZCERepresentAchievementsView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCERepresentAchievementsView" owner:self options:nil][0];
}

@end

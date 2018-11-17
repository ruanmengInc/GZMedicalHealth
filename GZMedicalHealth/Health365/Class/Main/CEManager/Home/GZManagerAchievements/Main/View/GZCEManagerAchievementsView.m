//
//  GZCEManagerAchievementsView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCEManagerAchievementsView.h"

@implementation GZCEManagerAchievementsView

+ (instancetype)createGZCERepresentAchievementsView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCEManagerAchievementsView" owner:self options:nil][0];
}


@end

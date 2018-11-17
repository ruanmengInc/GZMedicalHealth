//
//  GZCERepresentMyPointsHeaderView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentMyPointsHeaderView.h"

@implementation GZCERepresentMyPointsHeaderView

+ (instancetype)createGZCERepresentMyPointsHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCERepresentMyPointsHeaderView" owner:self options:nil][0];
}

@end

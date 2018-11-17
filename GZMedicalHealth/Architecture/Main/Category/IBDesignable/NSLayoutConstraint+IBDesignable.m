//
//  NSLayoutConstraint+IBDesignable.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/8.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"

@implementation NSLayoutConstraint (IBDesignable)

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.constant = self.constant * KsuitParam;
}

@end

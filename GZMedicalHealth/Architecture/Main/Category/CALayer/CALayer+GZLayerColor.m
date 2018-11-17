//
//  CALayer+GZLayerColor.m
//  jadeCircle
//
//  Created by guGuangZhou on 2017/8/18.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import "CALayer+GZLayerColor.h"

@implementation CALayer (GZLayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color
{

    self.borderColor = color.CGColor;
}

@end

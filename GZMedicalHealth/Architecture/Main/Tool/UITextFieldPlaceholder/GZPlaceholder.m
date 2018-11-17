//
//  GZPlaceholder.m
//  bloodCirculation
//
//  Created by Apple on 2017/12/20.
//  Copyright © 2017年 ruanmeng. All rights reserved.
//

#import "GZPlaceholder.h"

@implementation GZPlaceholder

// 返回placeholderLabel的bounds，改变返回值，是调整placeholderLabel的位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(10, 0 , self.bounds.size.width, self.bounds.size.height);
}

// 控制还未输入时文本的位置，缩进40
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds, 10, 0);
}

// 控制输入后文本的位置，缩进20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds, 10, 0);
}


@end

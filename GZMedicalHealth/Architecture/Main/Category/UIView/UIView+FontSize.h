//
//  UIView+FontSize.h
//
//  Created by 袁小荣 on 2018/5/18.
//  Copyright © 2018年 tec. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UITextViewEnable 1
#define UITextFieldEnable 1
#define UIButtonEnable 1
#define UILabelEnable 1

@interface UIView (FontSize)

/**
 设置需要忽略的空间tag值

 @param tagArr tag值数组
 */
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr;

/**
 设置字体大小比例

 @param value 需要设置的比例
 */
+ (void)setFontScale:(CGFloat)value;

@end


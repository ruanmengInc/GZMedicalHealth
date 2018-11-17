//
//  UIButton+CZAddition.m
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIButton+CZAddition.h"

@implementation UIButton (CZAddition)

+ (instancetype)cz_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor {
    return [self cz_textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil];
}

+ (instancetype)cz_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        
        NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)cz_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
    [button setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)GZ_textButton:(NSString *)title selectTitle:(NSString *)selectTitle titleColor:(UIColor *)titleColor font:(CGFloat)font ImageButton:(NSString *)imageName
{
    UIButton *button = [[self alloc] init];
    
    button.frame = CGRectMake(0, 0, 35, 44);
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];

    [button setTitleColor:titleColor forState:UIControlStateNormal];

    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.adjustsImageWhenHighlighted = NO;

    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return button;
}

@end

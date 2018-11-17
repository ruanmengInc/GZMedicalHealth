//
//  UIBarButtonItem+MHExtension.m
//  MHDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "UIBarButtonItem+MHExtension.h"
#import "MHBackButton.h"

@implementation UIBarButtonItem (MHExtension)


+ (UIBarButtonItem *)mh_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
     MHBackButton*button = [[MHBackButton alloc] init];
    
    if(imageName) [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if(highImageName) [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 100, 44);
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

+ (UIBarButtonItem *)mh_itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [UIBarButtonItem mh_itemWithImageName:imageName highImageName:nil target:target action:action];
}







+ (UIBarButtonItem *)mh_systemItemWithTitle:(NSString *)title
                                 titleColor:(UIColor *)titleColor
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                   selector:(SEL)selector
                                   textType:(BOOL)textType {
    UIBarButtonItem *item = textType ?
    ({
        /// 设置普通状态的文字属性
        item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        titleColor = titleColor?titleColor:[UIColor whiteColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = titleColor;
        textAttrs[NSFontAttributeName] = MHRegularFont(16.0f);
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset =  CGSizeZero;
        textAttrs[NSShadowAttributeName] = shadow;
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置高亮状态的文字属性
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        // 设置不可用状态(disable)的文字属性
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        
        item;
    }) : ({
        item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item;
    });
    return item;
}

+ (UIBarButtonItem *)mh_customItemWithTitle:(NSString *)title
                                selectTitle:(NSString *)selectTitle
                                 titleColor:(UIColor *)titleColor
                                  titleFont:(UIFont *)titleFont
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                   selector:(SEL)selector
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    UIButton *item = [[UIButton alloc] init];
    titleColor = titleColor?titleColor:[UIColor whiteColor];
    
    if (MHStringIsNotEmpty(title)) {
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitle:selectTitle forState:UIControlStateSelected];
    }
    
    if (MHStringIsNotEmpty(imageName)) {
        [item setImage:[UIImage mh_imageAlwaysShowOriginalImageWithImageName:imageName] forState:UIControlStateNormal];
        [item setImage:[UIImage mh_imageAlwaysShowOriginalImageWithImageName:imageName] forState:UIControlStateHighlighted];
    }
    
    [item.titleLabel setFont:MHRegularFont_16];
    [item setTitleColor:titleColor forState:UIControlStateNormal];
    [item setTitleColor:[titleColor colorWithAlphaComponent:.5f] forState:UIControlStateHighlighted];
    [item setTitleColor:[titleColor colorWithAlphaComponent:.5f] forState:UIControlStateDisabled];
    [item layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    [item sizeToFit];
    item.size = CGSizeMake(84, 44);
    item.contentHorizontalAlignment = contentHorizontalAlignment;
    [item addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

/// 返回按钮 带箭头的
+ (UIBarButtonItem *)mh_backItemWithTitle:(NSString *)title
                              selectTitle:(NSString *)selectTitle
                               titleColor:(UIColor *)color
                                titleFont:(UIFont *)titleFont
                                imageName:(NSString *)imageName
                                   target:(id)target
                                   action:(SEL)action
{
    return [self mh_customItemWithTitle:title selectTitle:selectTitle titleColor:color titleFont:titleFont imageName:imageName target:target selector:action contentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

}

+ (UIBarButtonItem *)mh_RightItemWithTitle:(NSString *)title
                               selectTitle:(NSString *)selectTitle
                                titleColor:(UIColor *)color
                                 titleFont:(UIFont *)titleFont
                                 imageName:(NSString *)imageName
                                    target:(id)target
                                    action:(SEL)action
{
    UIButton *item = [[UIButton alloc] init];
    color = color?color:[UIColor whiteColor];
    
    if (MHStringIsNotEmpty(title)) {
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitle:selectTitle forState:UIControlStateSelected];
    }
    
    if (MHStringIsNotEmpty(imageName)) {
        [item setImage:[UIImage mh_imageAlwaysShowOriginalImageWithImageName:imageName] forState:UIControlStateNormal];
        [item setImage:[UIImage mh_imageAlwaysShowOriginalImageWithImageName:imageName] forState:UIControlStateHighlighted];
    }
    
    [item.titleLabel setFont:MHRegularFont_16];
    [item setTitleColor:color forState:UIControlStateNormal];
    [item setTitleColor:[color colorWithAlphaComponent:.5f] forState:UIControlStateHighlighted];
    [item setTitleColor:[color colorWithAlphaComponent:.5f] forState:UIControlStateDisabled];
    [item layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    [item sizeToFit];
    item.size = CGSizeMake(84, 44);
    item.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

@end

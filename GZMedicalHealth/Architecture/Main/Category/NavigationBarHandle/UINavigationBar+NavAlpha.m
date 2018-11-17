//
//  UINavigationBar+NavAlpha.m
//  MTransparentNav
//
//  Created by mengqingzheng on 2017/4/20.
//  Copyright © 2017年 mengqingzheng. All rights reserved.
//

#import "UINavigationBar+NavAlpha.h"

#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0

@implementation UINavigationBar (NavAlpha)
static char *navAlphaKey = "navAlphaKey";
-(CGFloat)navAlpha {
    if (objc_getAssociatedObject(self, navAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, navAlphaKey) floatValue];
}
-(void)setNavAlpha:(CGFloat)navAlpha {
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);// 必须在 0~1的范围
    
    if (self.subviews.count != 0) {
        
        UIView *barBackground = self.subviews[0];
        if (self.translucent == NO || [self backgroundImageForBarMetrics:UIBarMetricsDefault] != nil) {
            barBackground.alpha = alpha;
            
        } else {
            
            if (IOS10) {
                UIView *effectFilterView = barBackground.subviews.lastObject;
                effectFilterView.alpha = alpha;
            } else {
                UIView *effectFilterView = barBackground.subviews.firstObject;
                effectFilterView.alpha = alpha;
            }
        }
    }
    
    /// 黑线
    UIImageView *shadowView = [self _findHairlineImageViewUnder:self];

    if (alpha < 0.01) {
        shadowView.hidden = YES;
    } else {
        shadowView.hidden = NO;
        shadowView.alpha = alpha;
    }
    
    objc_setAssociatedObject(self, navAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 查询最后一条数据
- (UIImageView *)_findHairlineImageViewUnder:(UIView *)view{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews){
        UIImageView *imageView = [self _findHairlineImageViewUnder:subview];
        if (imageView){ return imageView; }
    }
    return nil;
}

@end

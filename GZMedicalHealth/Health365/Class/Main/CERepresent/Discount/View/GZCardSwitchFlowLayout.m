//
//  GZCardSwitchFlowLayout.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/31.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCardSwitchFlowLayout.h"

//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.9f;
static float CardHeightScale = 0.8f;

@implementation GZCardSwitchFlowLayout

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake( -30, [self collectionInset], 0, [self collectionInset]);
}

#pragma mark -
#pragma mark 配置方法

//卡片宽度
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

//卡片间隔
- (float)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth])/7;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}

#pragma mark -
#pragma mark 约束设定
//最小纵向间距
- (CGFloat)minimumLineSpacing {
    CGFloat margin = [self cellMargin];
    return margin;
}
//cell大小
- (CGSize)itemSize {
    CGSize size = CGSizeMake([self cellWidth],self.collectionView.bounds.size.height * CardHeightScale);
    return size;
}

#pragma mark -
#pragma mark 其他设定
//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end

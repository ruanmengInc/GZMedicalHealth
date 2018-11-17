//
//  GZProvinceHeaderView.h
//  bloodCirculation
//
//  Created by Apple on 2018/7/20.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZLocationModel.h"

@interface GZProvinceHeaderView : UIView

@property (nonatomic, copy) void(^collectionPopBlock)(NSString *cityStr, NSString *cityID);

/**
 collectionView 列表数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *cityStr;

+ (instancetype)createProvinceHeaderView;

@end

//
//  GZShoppingMallMenuView.h
//  MedicalCompany
//
//  Created by Apple on 2018/5/14.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GZShoppingMallBrandModel.h"

@interface GZShoppingMallMenuView : UIView

@property (nonatomic, copy) void(^sureBlock)(NSString *statusOne, NSString *statusTwo, NSString *statusThree, NSString *statusFour, NSString *statusFive, NSString *statusSex);

+ (instancetype)createShoppingMallMenuView;


/**
 显示view
 */
- (void)showShoppingMallMenu;

/**
 隐藏view
 */
- (void)dissMissShoppingMallMenu;

@end

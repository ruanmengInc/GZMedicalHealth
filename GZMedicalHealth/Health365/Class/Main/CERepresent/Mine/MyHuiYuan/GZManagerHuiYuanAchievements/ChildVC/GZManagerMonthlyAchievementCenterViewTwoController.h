//
//  GZManagerMonthlyAchievementCenterViewTwoController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHTableViewController.h"
#import "GZCEManagerMyHuiYuanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZManagerMonthlyAchievementCenterViewTwoController : CMHTableViewController

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, copy) NSString *huiID;

@property (nonatomic, strong) GZCEManagerMyHuiYuanView *headerView;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END

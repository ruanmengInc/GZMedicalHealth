//
//  GZManagerMonthlyAchievementLeftViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHTableViewController.h"
#import "GZCEManagerAchievementsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZManagerMonthlyAchievementLeftViewController : CMHTableViewController

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) GZCEManagerAchievementsView *headerView;

@end

NS_ASSUME_NONNULL_END

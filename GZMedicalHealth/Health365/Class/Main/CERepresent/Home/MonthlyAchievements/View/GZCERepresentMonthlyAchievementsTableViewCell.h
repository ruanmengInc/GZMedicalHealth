//
//  GZCERepresentMonthlyAchievementsTableViewCell.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentMonthlyAchievementsTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) NSDictionary *dayDic;

@property (nonatomic, strong) NSDictionary *CEManagerDic;

@property (nonatomic, strong) NSDictionary *AchievementsDic;

@property (nonatomic, strong) NSDictionary *weisaoDic;

@end

NS_ASSUME_NONNULL_END

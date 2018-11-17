//
//  GZCEManagerAchievementsView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCEManagerAchievementsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *jifenLab;
@property (weak, nonatomic) IBOutlet UILabel *titLab;

+ (instancetype)createGZCERepresentAchievementsView;

@end

NS_ASSUME_NONNULL_END

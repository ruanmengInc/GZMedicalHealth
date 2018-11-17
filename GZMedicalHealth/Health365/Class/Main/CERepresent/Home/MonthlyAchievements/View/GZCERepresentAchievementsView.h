//
//  GZCERepresentAchievementsView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/20.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentAchievementsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *jifenLab;
@property (weak, nonatomic) IBOutlet UILabel *titLab;

+ (instancetype)createGZCERepresentAchievementsView;

@end

NS_ASSUME_NONNULL_END

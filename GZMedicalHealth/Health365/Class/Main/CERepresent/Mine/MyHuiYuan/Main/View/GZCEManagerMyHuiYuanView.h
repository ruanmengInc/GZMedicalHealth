//
//  GZCEManagerMyHuiYuanView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCEManagerMyHuiYuanView : UIView

@property (weak, nonatomic) IBOutlet UILabel *jifenLab;
@property (weak, nonatomic) IBOutlet UILabel *huiYuanLab;

+ (instancetype)createGZCEManagerMyHuiYuanView;

@end

NS_ASSUME_NONNULL_END

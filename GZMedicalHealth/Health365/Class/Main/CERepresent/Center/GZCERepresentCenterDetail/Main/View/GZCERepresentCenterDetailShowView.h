//
//  GZCERepresentCenterDetailShowView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentCenterDetailShowView : UIView

@property (nonatomic, copy) void (^sureBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+ (instancetype)createGZCERepresentCenterDetailShowView;

-(void)show;

@end

NS_ASSUME_NONNULL_END

//
//  GZTwoScavengingView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/30.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZTwoScavengingView : UIView

@property (nonatomic, copy) void (^sureBlock)(void);

+ (instancetype)createTwoScavengingView;

-(void)show;

@end

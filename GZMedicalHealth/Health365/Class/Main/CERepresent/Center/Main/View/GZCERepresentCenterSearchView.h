//
//  GZCERepresentCenterSearchView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentCenterSearchView : UIView

@property (nonatomic, copy) void (^btnEventsBlock)(NSString *text);

+ (instancetype)createGZCERepresentCenterSearchView;

@end

NS_ASSUME_NONNULL_END

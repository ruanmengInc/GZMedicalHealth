//
//  GZCERepresentCenterTableViewCell.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/10/8.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCERepresentCenterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *telBtn;

@property (nonatomic, copy) void (^btnEventsBlock)(NSInteger tag);

@property (nonatomic, strong) GZCERepresentBaseModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  GZCEManagerMyHuiYuanTableViewCell.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCEManagerMyHuiYuanTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSDictionary *hourDic;

@property (nonatomic, copy) void (^btnEventsBlock)(NSInteger tag);

@property (weak, nonatomic) IBOutlet UIButton *telBtn;

@end

NS_ASSUME_NONNULL_END

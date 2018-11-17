//
//  GZCERepresentMineTableViewCell.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZCERepresentMineTableViewCell : UITableViewCell<CMHConfigureCell>

@property (nonatomic, strong) NSIndexPath *mineIndexPath;
@property (nonatomic, strong) NSIndexPath *messageIndexPath;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) GZCERepresentBaseModel *mineModel;


@property (nonatomic, strong) NSIndexPath *CEManagerIndexPath;
@property (nonatomic, strong) NSDictionary *CEManagerDict;
@property (nonatomic, strong) GZCERepresentBaseModel *CEManagerMineModel;

@end

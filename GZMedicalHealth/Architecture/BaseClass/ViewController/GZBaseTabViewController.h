//
//  GZBaseTabViewController.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHTableViewController.h"

@interface GZBaseTabViewController : CMHTableViewController


/**
 上拉所传字典，子类需重写self.subscriptHeader  Getter方法
 */
@property (nonatomic, strong) CMHKeyedSubscript *subscriptHeader;


/**
 下拉所传字典，子类需重写self.subscriptHeader  Getter方法
 */
@property (nonatomic, strong) CMHKeyedSubscript *subscriptFooter;

/**
 处理上拉请求数据

 */
- (void)tableViewDidTriggerHeaderRefreshHandle:(GZCERepresentBaseModel *)responseObject;

/**
 处理下拉请求数据

 */
- (void)tableViewDidTriggerFooterRefreshHandle:(GZCERepresentBaseModel *)responseObject;

@end

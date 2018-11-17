//
//  GZIntegralExchangeResultModel.h
//  health365
//
//  Created by guGuangZhou on 2017/8/15.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZIntegralExchangeResultData;
@class GZIntegralExchangeResultList;
@interface GZIntegralExchangeResultModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *msgcode;
@property (nonatomic, strong) GZIntegralExchangeResultData *data;

@end

@interface GZIntegralExchangeResultData : NSObject

@property (nonatomic, copy) NSString *c_count;
@property (nonatomic, copy) NSString *error_count;
@property (nonatomic, copy) NSString *ji_fen;
@property (nonatomic, copy) NSString *k_jifen;
@property (nonatomic, strong) NSArray <GZIntegralExchangeResultList *> *list;

@end

@interface GZIntegralExchangeResultList : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *date;

@end

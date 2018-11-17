//
//  GZScanCodeIntegrationModel.h
//  health365
//
//  Created by guGuangZhou on 2017/8/14.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZScanCodeIntegrationData;
@interface GZScanCodeIntegrationModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *msgcode;
@property (nonatomic, strong) GZScanCodeIntegrationData *data;


@end

@interface GZScanCodeIntegrationData : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *fen;
@property (nonatomic, copy) NSString *name;

@end

//
//  GZLocationModel.h
//  health365
//
//  Created by GuangZhou Gu on 17/8/4.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZLocationData;
@interface GZLocationModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray <GZLocationData *> *data;

@end

@interface GZLocationData : NSObject

@property (nonatomic, copy) NSString *locationId;

@property (nonatomic, copy) NSString *cityname;

@property (nonatomic, copy) NSString *name;


// 预约订餐
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *cai_num;

@end

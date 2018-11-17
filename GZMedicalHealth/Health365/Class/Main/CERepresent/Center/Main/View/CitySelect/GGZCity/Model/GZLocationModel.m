//
//  GZLocationModel.m
//  health365
//
//  Created by GuangZhou Gu on 17/8/4.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GZLocationModel.h"

@implementation GZLocationModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [GZLocationData class]};
}

@end

@implementation GZLocationData

+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"locationId" :@"id"};
}


@end

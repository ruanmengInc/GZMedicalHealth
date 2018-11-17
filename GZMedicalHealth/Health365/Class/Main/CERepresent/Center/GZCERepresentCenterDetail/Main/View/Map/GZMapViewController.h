//
//  GZMapViewController.h
//  health365
//
//  Created by guGuangZhou on 2017/9/20.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "CMHViewController.h"


@interface GZMapViewController : CMHViewController

typedef void(^ChoosePositionBlcok) (NSString *latitude,NSString *longitude);

@property (nonatomic,strong) ChoosePositionBlcok choosePositionBlock;

@end

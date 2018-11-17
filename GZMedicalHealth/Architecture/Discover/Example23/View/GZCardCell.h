//
//  GZCardCell.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/30.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "CMHCollectionViewCell.h"
#import "CMHCard.h"

@interface GZCardCell : CMHCollectionViewCell<CMHConfigureView>

@property (nonatomic, strong) CMHCard *card;

@end

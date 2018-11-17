//
//  GZPhotoCollectionViewCell.m
//  bloodCirculation
//
//  Created by Apple on 2017/12/21.
//  Copyright © 2017年 ruanmeng. All rights reserved.
//

#import "GZPhotoCollectionViewCell.h"

@implementation GZPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deleteBtn:(UIButton *)sender
{
    if (self.deletePhotoBlock) {
        self.deletePhotoBlock();
    }
}

@end

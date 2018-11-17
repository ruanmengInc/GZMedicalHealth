//
//  GZPhotoCollectionViewCell.h
//  bloodCirculation
//
//  Created by Apple on 2017/12/21.
//  Copyright © 2017年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^deletePhotoBlock)(void);

@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;

@end

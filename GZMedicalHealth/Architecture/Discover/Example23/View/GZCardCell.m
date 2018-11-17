//
//  GZCardCell.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/30.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCardCell.h"
#import "CMHCard.h"

@interface GZCardCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GZCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Public Method
-(void)setCard:(CMHCard *)card
{
    _card = card;
    
    self.contentLab.text = card.title;
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:card.imageUrl] placeholder:MHImageNamed(@"placeholder_image") options:CMHWebImageOptionAutomatic completion:NULL];
}

@end

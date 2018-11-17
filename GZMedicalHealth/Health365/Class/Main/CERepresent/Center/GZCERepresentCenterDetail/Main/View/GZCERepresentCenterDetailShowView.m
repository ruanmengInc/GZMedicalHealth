//
//  GZCERepresentCenterDetailShowView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCenterDetailShowView.h"

@interface GZCERepresentCenterDetailShowView ()

@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation GZCERepresentCenterDetailShowView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
}

+ (instancetype)createGZCERepresentCenterDetailShowView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCERepresentCenterDetailShowView" owner:self options:nil][0];
}

- (IBAction)btnEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self cancelAction];
        }
            break;
            
        case 11:
        {
            if (self.sureBlock) {
                self.sureBlock();
                
                [self cancelAction];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)show{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

//点击取消
- (void)cancelAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

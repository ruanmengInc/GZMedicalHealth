//
//  UIButton+Helper.m
//  health365
//
//  Created by guGuangZhou on 2017/8/10.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)

#pragma mark - 开启倒计时效果
/**
 开启倒计时效果
 */
+ (void)openCountdown:(UIButton *)sender
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                
                
                
//                [sender setBackgroundColor:GZRGBA(255, 102, 102, 1.0)];
                
                sender.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                [sender setBackgroundColor:GZRGBA(204, 204, 204, 1.0)];
                
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

+ (void)openCountdownn:(UIButton *)sender
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
               
                sender.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end

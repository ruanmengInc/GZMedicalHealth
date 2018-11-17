//
//  GZDownloadViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/28.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZDownloadViewController.h"

@interface GZDownloadViewController ()

@end

@implementation GZDownloadViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.prefersNavigationBarHidden = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)popEvents:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

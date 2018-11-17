//
//  GZTwoScavengingView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/30.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZTwoScavengingView.h"

@interface GZTwoScavengingView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GZTwoScavengingView

+ (instancetype)createTwoScavengingView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZTwoScavengingView" owner:self options:nil][0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.textLabel.text = @"11111111111111111111";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}


@end

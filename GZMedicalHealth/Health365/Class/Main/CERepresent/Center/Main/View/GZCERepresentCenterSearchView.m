//
//  GZCERepresentCenterSearchView.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentCenterSearchView.h"

@interface GZCERepresentCenterSearchView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation GZCERepresentCenterSearchView

+ (instancetype)createGZCERepresentCenterSearchView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZCERepresentCenterSearchView" owner:self options:nil][0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = 20;
    
    self.searchTF.font = [UIFont systemFontOfSize:15];
    self.searchTF.tintColor = [UIColor redColor];
    
    self.searchTF.delegate = self;
    
    self.searchTF.returnKeyType = UIReturnKeySearch;

    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.btnEventsBlock) {
        
        [self endEditing:YES];
        
        self.btnEventsBlock(textField.text);
    }
    
    return YES;
}

@end

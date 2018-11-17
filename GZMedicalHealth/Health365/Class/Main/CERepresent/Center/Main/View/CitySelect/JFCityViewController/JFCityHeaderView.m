//
//  JFCityHeaderView.m
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFCityHeaderView.h"

#import "Masonry.h"
#import "JFButton.h"

#define JFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

@interface JFCityHeaderView ()<UISearchBarDelegate>

@property (nonatomic, strong) UILabel *currentCityLabel;
@property (nonatomic, strong) JFButton *button;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation JFCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = JFRGBAColor(155, 155, 155, 0.5);

        [self addLabels];
    }
    return self;
}

- (void)setCityName:(NSString *)cityName {
    self.currentCityLabel.text = cityName;
}

- (void)addLabels {
    UILabel *currentLabel = [[UILabel alloc] init];
    currentLabel.text = @"当前:";
    currentLabel.textAlignment = NSTextAlignmentLeft;
    currentLabel.textColor = [UIColor blackColor];
    currentLabel.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:currentLabel];
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(40);
        make.height.offset(50);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.currentCityLabel = [[UILabel alloc] init];
    _currentCityLabel.textColor  = [UIColor blackColor];
    _currentCityLabel.textAlignment = NSTextAlignmentLeft;
    _currentCityLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_currentCityLabel];
    [_currentCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(50);
        make.left.equalTo(currentLabel.mas_right).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
    }];
}

@end

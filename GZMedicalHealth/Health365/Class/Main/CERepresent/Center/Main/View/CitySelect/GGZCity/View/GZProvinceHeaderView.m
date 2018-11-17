//
//  GZProvinceHeaderView.m
//  bloodCirculation
//
//  Created by Apple on 2018/7/20.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZProvinceHeaderView.h"
#import "GZProvinceCollectionViewCell.h"

@interface GZProvinceHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *cityNow;

@end

static NSString *oneCollectionCellID = @"oneCollectionCellID";

#define CELLWidth1 (kScreenWidth - 50) / 3

@implementation GZProvinceHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GZProvinceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:oneCollectionCellID];
}

+ (instancetype)createProvinceHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZProvinceHeaderView" owner:self options:nil][0];
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

-(void)setCityStr:(NSString *)cityStr
{
    _cityStr = cityStr;
    
    self.cityNow.text = [NSString stringWithFormat:@"当前位置   %@",cityStr];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZProvinceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneCollectionCellID forIndexPath:indexPath];
    
    GZLocationData *data = self.dataArray[indexPath.row];
    
    cell.titleLab.text = data.cityname;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZLocationData *data = self.dataArray[indexPath.row];

    if (self.collectionPopBlock) {
        self.collectionPopBlock(data.cityname, data.locationId);
    }
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELLWidth1, 40);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end

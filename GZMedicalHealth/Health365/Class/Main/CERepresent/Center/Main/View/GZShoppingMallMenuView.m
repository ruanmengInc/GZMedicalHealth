//
//  GZShoppingMallMenuView.m
//  MedicalCompany
//
//  Created by Apple on 2018/5/14.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZShoppingMallMenuView.h"
#import "GZLimitTimePurchasePopEyeCollectionViewCell.h"

static NSString *oneCollectionCellID = @"oneCollectionCellID";

#define CELLWidth1 (self.leftEyeCollectionView.GZ_width - 100)

@interface GZShoppingMallMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger selectIndex;  // 记录选中的collectionView
}

@property (weak, nonatomic) IBOutlet UICollectionView *leftEyeCollectionView;
@property (nonatomic, strong) NSMutableArray *leftEyeArray;

@end

@implementation GZShoppingMallMenuView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    selectIndex = NSIntegerMax;

    self.leftEyeCollectionView.delegate = self;
    self.leftEyeCollectionView.dataSource = self;
    [self.leftEyeCollectionView registerNib:[UINib nibWithNibName:@"GZLimitTimePurchasePopEyeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:oneCollectionCellID];
    
    //实现多选必须实现这个方法
    self.leftEyeCollectionView.allowsMultipleSelection = YES;
    
    [self.leftEyeArray addObjectsFromArray:@[ @{@"title":@"关联终端",@"status":@"0"},
                                              @{@"title":@"我关注的",@"status":@"0"},
                                              @{@"title":@"优惠活动",@"status":@"0"},
                                              @{@"title":@"兑换礼品",@"status":@"0"},
                                              @{@"title":@"零售药店",@"status":@"0"},
                                              @{@"title":@"社区诊所",@"status":@"0"}]];
    [self.leftEyeCollectionView reloadData];
}

+ (instancetype)createShoppingMallMenuView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GZShoppingMallMenuView" owner:self options:nil][0];
}

- (void)showShoppingMallMenu
{
    
    [ UIView animateWithDuration:0.3 animations:^{
        
        CGAffineTransform tf = CGAffineTransformMakeTranslation(-(self.frame.size.width), 0);
        [self setTransform:tf];
    }];
}

- (IBAction)btnEvents:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self.leftEyeArray removeAllObjects];
            [self.leftEyeArray addObjectsFromArray:@[ @{@"title":@"关联终端",@"status":@"0"},
                                                      @{@"title":@"我关注的",@"status":@"0"},
                                                      @{@"title":@"优惠活动",@"status":@"0"},
                                                      @{@"title":@"兑换礼品",@"status":@"0"},
                                                      @{@"title":@"零售药店",@"status":@"0"},
                                                      @{@"title":@"社区诊所",@"status":@"0"}]];
            
            [self.leftEyeCollectionView reloadData];
        }
            break;
            
        case 11:
        {
            if (self.sureBlock) {
                self.sureBlock(self.leftEyeArray[0][@"status"], self.leftEyeArray[1][@"status"], self.leftEyeArray[2][@"status"], self.leftEyeArray[3][@"status"], self.leftEyeArray[4][@"status"], self.leftEyeArray[5][@"status"]);
                
                [self dissMissShoppingMallMenu];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)dissMissShoppingMallMenu
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform =  CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point=[[touches anyObject]locationInView:self];
    CALayer *layer=[self.layer hitTest:point];
    
    if (layer == self.layer) {  // 如果点击了遮罩，则隐藏
        
        [self dissMissShoppingMallMenu];
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.leftEyeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZLimitTimePurchasePopEyeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneCollectionCellID forIndexPath:indexPath];
    
    cell.numLab.textColor = MHColor(157, 157, 157);
    cell.numLab.backgroundColor = [UIColor whiteColor];
    
    cell.numLab.text = [NSString stringWithFormat:@"%@",self.leftEyeArray[indexPath.row][@"title"]];
    
    return cell;
}

//点击选定
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZLimitTimePurchasePopEyeCollectionViewCell * cell = (GZLimitTimePurchasePopEyeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.numLab.textColor = [UIColor whiteColor];
    cell.numLab.backgroundColor = MHColor(221, 188, 116);
    
    [self.leftEyeArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.leftEyeArray[indexPath.row][@"title"],@"status":@"1"}];
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELLWidth1, 50);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 50, 0, 50);
}

#pragma mark - 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZLimitTimePurchasePopEyeCollectionViewCell * cell = (GZLimitTimePurchasePopEyeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.numLab.textColor = MHColor(157, 157, 157);
    cell.numLab.backgroundColor = [UIColor whiteColor];
    
    [self.leftEyeArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.leftEyeArray[indexPath.row][@"title"],@"status":@"0"}];
}

-(NSMutableArray *)leftEyeArray
{
    if (_leftEyeArray == nil) {
        _leftEyeArray = [NSMutableArray array];
    }
    return _leftEyeArray;
}

@end

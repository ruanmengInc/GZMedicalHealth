//
//  GZCERepresentDiscountViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/8/31.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZCERepresentDiscountViewController.h"
#import "GZCardCell.h"
#import "CMHCard.h"

static NSString *oneCollectionCellID = @"oneCollectionCellID";
#define CELLWidth kScreenWidth - 55
#define CELLHeight self.collectionView.GZ_height - 20

@interface GZCERepresentDiscountViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GZCERepresentDiscountViewController

/// 重写init方法，配置你想要的属性
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 隐藏（YES）导航线
        self.prefersNavigationBarBottomLineHidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    [self setupUI];
}

-(void)configure
{
    [super configure];
    
    /// 配置数据
    CMHCard *card0 = [[CMHCard alloc] init];
    card0.title = @"迪丽热巴";
    card0.imageUrl = @"http://img4.imgtn.bdimg.com/it/u=2460756017,2937785205&fm=27&gp=0.jpg";
    
    CMHCard *card1 = [[CMHCard alloc] init];
    card1.title = @"二哈";
    card1.imageUrl = @"http://img3.imgtn.bdimg.com/it/u=965183317,1784857244&fm=27&gp=0.jpg";
    
    CMHCard *card2 = [[CMHCard alloc] init];
    card2.title = @"动漫";
    card2.imageUrl = @"http://img4.imgtn.bdimg.com/it/u=3796556004,3886443338&fm=27&gp=0.jpg";
    
    CMHCard *card3 = [[CMHCard alloc] init];
    card3.title = @"汽车";
    card3.imageUrl = @"http://img2.imgtn.bdimg.com/it/u=2984990935,4159348043&fm=27&gp=0.jpg";
    
    CMHCard *card4 = [[CMHCard alloc] init];
    card4.title = @"孙悟空";
    card4.imageUrl = @"http://img3.imgtn.bdimg.com/it/u=1344300218,1040337319&fm=27&gp=0.jpg";
    
    CMHCard *card5 = [[CMHCard alloc] init];
    card5.title = @"美女";
    card5.imageUrl = @"http://img5.imgtn.bdimg.com/it/u=1914477842,1074336369&fm=27&gp=0.jpg";
    
    CMHCard *card6 = [[CMHCard alloc] init];
    card6.title = @"模特";
    card6.imageUrl = @"http://img0.imgtn.bdimg.com/it/u=3958320691,3151448931&fm=27&gp=0.jpg";
    
    CMHCard *card7 = [[CMHCard alloc] init];
    card7.title = @"水滴";
    card7.imageUrl = @"http://img3.imgtn.bdimg.com/it/u=3922654918,1195871451&fm=27&gp=0.jpg";
    
    CMHCard *card8 = [[CMHCard alloc] init];
    card8.title = @"冰雪";
    card8.imageUrl = @"http://img5.imgtn.bdimg.com/it/u=2648172021,2116929252&fm=27&gp=0.jpg";
    
    CMHCard *card9 = [[CMHCard alloc] init];
    card9.title = @"卡通";
    card9.imageUrl = @"http://img4.imgtn.bdimg.com/it/u=4266595591,4217592991&fm=27&gp=0.jpg";
    
    [self.dataArr addObjectsFromArray:@[card0,card1,card2,card3,card4,card5,card6,card7,card8,card9]];
    
}

-(void)setupUI
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GZCardCell" bundle:nil] forCellWithReuseIdentifier:oneCollectionCellID];
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneCollectionCellID forIndexPath:indexPath];
    
    cell.card = self.dataArr[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMHNavigationController *nav = (CMHNavigationController *)self.navigationController;
    nav.titleName = @"优惠详情";
    nav.titleNameColor = nil;
    
    CMHWebViewController *webView = [[CMHWebViewController alloc] initWithParams:nil];
    webView.shouldDisableWebViewTitle = YES;
    [self.navigationController pushViewController:webView animated:YES];
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELLWidth, CELLHeight);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 25, 35, 25);
}

#pragma mark - UIScrollView - 滑动结束停留在中间位置
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x + 20, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x  + 20 + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x  + 20 + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
    
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x + 20 - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
    } else {
        MHLog(@"center is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetCenter), @(indexPath.section), @(indexPath.item), attributes);
    }
    
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end

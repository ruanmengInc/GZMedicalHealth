//
//  GZTwoSaleScanCodeComplaintViewController.m
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import "GZTwoSaleScanCodeComplaintViewController.h"
#import "GZPhotoCollectionViewCell.h"
#import "XLPhotoBrowser.h"

@interface GZTwoSaleScanCodeComplaintViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipsLab;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

/**
 图片允许数
 */
@property (nonatomic, assign) NSInteger photoNum;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *cellID = @"cellID";
#define CELLWidth1 (kScreenWidth - 20 - 10 - 10 - 22) / 3

@implementation GZTwoSaleScanCodeComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _photoNum = 3;
    
    [self setupUI];
}

- (void)setupUI
{
    NSString *str = @"请将 68 写在空白纸上，连同要投诉的入库商品一起拍照上传。\n照片请清晰辨认，并确保药品电子监管码可被识别，否则将无法进行投诉处理。";
    NSArray *arr = @[@"68"];
    self.tipsLab.attributedText = [NSAttributedString_Encapsulation changeFontAndColor:[UIFont systemFontOfSize:20] Color:MHColor(255, 86, 121) TotalString:str SubStringArray:arr LabelSpace:6];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GZPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}


#pragma mark - 图片
- (IBAction)photoAlbum:(UIButton *)sender
{
    if (_photoNum > 0) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_photoNum columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        
        imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
        imagePickerVc.allowPickingImage=YES;
        
        imagePickerVc.isStatusBarDefault = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            _photoNum = _photoNum - photos.count;
            
            [self.dataArray addObjectsFromArray:photos];
            [self.collectionView reloadData];
            
            self.photoBtn.GZ_left = 10 + self.dataArray.count *(CELLWidth1 + 20);
            
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else
    {
        [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"最多上传三张照片" delayTime:1.0];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.photoImgV.image = self.dataArray[indexPath.row];
    
    // 删除图片
    cell.deletePhotoBlock = ^{
        
        //取出源item数据
        id objc = [self.dataArray objectAtIndex:indexPath.item];
        //从资源数组中移除该数据
        [self.dataArray removeObject:objc];
        
        [collectionView reloadData];
        [collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        
        _photoNum = _photoNum + 1;
        
        self.photoBtn.GZ_left = 10 + self.dataArray.count *(CELLWidth1 + 20);
    };
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.dataArray currentImageIndex:indexPath.row];
    browser.browserStyle = XLPhotoBrowserStyleIndexLabel; // 微博样式
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELLWidth1, 80);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(10, 20, 10, 22);
}

#pragma mark - Getter
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

//此界面内存泄漏，MLeaksFinder框架检测到
//如果您的类设计为单例对象，或者由于某种原因您的类的对象不应该被解除锁定，那么通过返回NO，覆盖-（BOOL）willDealloc在您的类中。
- (BOOL)willDealloc {
    return NO;
}

@end

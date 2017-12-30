//
//  ExamCardViewController.m
//  iwen
//
//  Created by Interest on 15/11/2.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamCardViewController.h"
#import "CardCell.h"
@interface ExamCardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;
@property (strong,nonatomic) NSMutableArray *selectArray;
@property (nonatomic,strong) UIBarButtonItem *backItem;
@end

@implementation ExamCardViewController

#pragma mark getter

- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        
        
        _selectArray = [NSMutableArray array];
    }
    
    return _selectArray;
}

- (UIBarButtonItem *)backItem{
    
    if (_backItem == nil) {
        
        UIButton *backBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"通用-返回键1"]
                 forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back)
          forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    
    return _backItem;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
    if (dataSource) {
        
        _dataSource = dataSource;
        
        [self.selectArray removeAllObjects];
        
        for (ChapterPracticeModel *model in dataSource) {
            
            BOOL isSelect = false;
            
            for (OptionModel *op in model.option) {
                
                if ([op.isSelect boolValue]) {
                    
                    isSelect = YES;
                }
            }
            if (isSelect) {
                
                [self.selectArray addObject:model];
            }
            
        }
        
        [self.collectview reloadData];
        
        
    }
}



#pragma mark ViewLife cyle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
}



- (void)setupUI{
    
    self.title = @"答题卡";
    
    UINib *nib = [UINib nibWithNibName:@"CardCell" bundle:nil];
    
    [self.collectview registerNib:nib forCellWithReuseIdentifier:@"MyCardCell"];
    
    self.collectview.backgroundColor = [UIColor whiteColor];
    
    
    self.flow.minimumInteritemSpacing = 0.0f;
    self.flow.minimumLineSpacing     = 0.0f;
    
    self.navigationItem.leftBarButtonItem = self.backItem;
}





#pragma mark Action


- (void)back{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark Service







#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return  self.dataSource.count;

}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCardCell" forIndexPath:indexPath];
    
    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    ChapterPracticeModel *model = self.dataSource[indexPath.row];
    
    
    if ([self.selectArray containsObject:model]) {
        
        cell.lab.textColor = [UIColor whiteColor];
        
        cell.lab.backgroundColor = BaseColor;
    }
    else{
        
        cell.lab.textColor = BaseColor;
        
        cell.lab.backgroundColor = [UIColor whiteColor];
    }
    return cell;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
    
        
        [self.delegate didSelectItemWithIndex:indexPath.row];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
    }

}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake(45, 45);
    
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    
//    
//    return UIEdgeInsetsMake(1, 1,1, 1);
//    
//}




@end

//
//  CoupenViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CoupenViewController.h"
#import "ConpenCell.h"
@interface CoupenViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong)  UserModel      *userInfo;

@end

@implementation CoupenViewController

#pragma mark getter

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[]mutableCopy];
        
    }
    return _dataSource;
}
- (UserModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"优惠券";
    UINib *nib = [UINib nibWithNibName:@"ConpenCell" bundle:nil];
    [self.collecview registerNib:nib forCellWithReuseIdentifier:@"CouCell"];
    self.collecview.backgroundColor = BackgroundColor;
    
    [self configCollectviewData];
    
    self.collecview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirst)];
    
    self.collecview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.collecview.header beginRefreshing];

}


#pragma mark Action

- (void)back{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCoupenId:)]) {
        
        [self.delegate didSelectCoupenId:@""];
    
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Service
- (void)configCollectviewData{
    
    [MineService shareInstanced].getCouponSuccess =^(id obj) {
        
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        self.dataSource = obj;
        
        [self.collecview reloadData];
        
    };
    
    [MineService shareInstanced].getCouponFailure = ^(id obj){
        
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        [self showHudWithString:obj];
    };
    
}


- (void)loadFirst{
    
    [[MineService shareInstanced]getFirstCoupenWithUid:self.userInfo.uid];
    
}

- (void)loadMore{
    
    [[MineService shareInstanced]getMoreCoupenWithUid:self.userInfo.uid];
    
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConpenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouCell" forIndexPath:indexPath];
    
    CouponModel *model = self.dataSource[indexPath.row];
    
    cell.coutLab.text = [NSString stringWithFormat:@"¥%@",model.send_money];
    
    cell.dateLab.text = [NSString stringWithFormat:@"有效期至%@",model.end_time];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCoupenId:)]) {
        
        CouponModel *model = self.dataSource[indexPath.row];
        
        [self.delegate didSelectCoupenId:model.id];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([OSHelper iPhone6s]) {
        
        return CGSizeMake(180, 120);
    }
    else if ([OSHelper iPhone6]){
        
        
        return CGSizeMake(160, 120);
    }
    
    
    return CGSizeMake(140, 120);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20, 10, 10, 10);
}



@end

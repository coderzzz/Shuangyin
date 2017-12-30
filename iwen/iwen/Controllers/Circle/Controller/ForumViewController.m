//
//  ForumViewController.m
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ForumViewController.h"
#import "DetailViewController.h"
#import "BlogCell.h"
@interface ForumViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ForumViewController

#pragma mark getter

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[]mutableCopy];
        
    }
    return _dataSource;
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    

}

- (void)setupUI{
    
//    self.title                             = @"纹绣论坛";
    
    self.view.backgroundColor              = BackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:@"BlogCell" bundle:nil];
    [self.collecview registerNib:nib forCellWithReuseIdentifier:@"myBlogCell"];
    self.collecview.backgroundColor        = BackgroundColor;
    self.collecview.frame                  = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    
    [self configData];
    
    self.collecview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstLoadData)];
    
    self.collecview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.collecview.header beginRefreshing];
}


#pragma mark Action


#pragma mark Service

- (void)configData{
    

    [CircleService shareInstaced].getForumSuccess = ^(id obj){
        
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        self.dataSource = obj;
        
        [self.collecview reloadData];
    };
    
    [CircleService shareInstaced].getForumFailure = ^(id obj){
        
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        [self showHudWithString:obj];
        
    };
}

- (void)firstLoadData{
    
    [[CircleService shareInstaced]getFirstForumWithId:self.model.id];
    
}

- (void)loadMoreData{
    
    [[CircleService shareInstaced]getMoreForumWithId:self.model.id];
    
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BlogCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myBlogCell" forIndexPath:indexPath];

    cell.selectimgv.image = nil;
    
    if (indexPath.row<self.dataSource.count) {
        
        ForumModel *model = self.dataSource[indexPath.row];
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
        
        cell.titleLab.text = model.news_title;
        
        [cell.headimgv sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:DefaultAvatar];
        
        cell.nameLab.text = model.username;
    }
    
    
    
    
    return cell;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *vc = [[DetailViewController alloc]init];
    
   
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([OSHelper iPhone6s]) {
        
        return CGSizeMake(180, 180);
    }
    else if ([OSHelper iPhone6]){
        
        
        return CGSizeMake(160, 180);
    }
    
    
    return CGSizeMake(140, 180);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20, 10, 10, 10);
}


@end

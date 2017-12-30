//
//  MyBlogViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MyBlogViewController.h"
#import "DetailViewController.h"
#import "BlogCell.h"
@interface MyBlogViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIToolbar      *toolbar;
@property (nonatomic, strong)  UserModel      *userInfo;
@property (nonatomic, strong) UIBarButtonItem *choseItem;

@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation MyBlogViewController
{
    
    BOOL  ischose;
    
    
    
}


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.title                             = @"我的帖子";
    
    self.view.backgroundColor              = BackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:@"BlogCell" bundle:nil];
    [self.collecview registerNib:nib forCellWithReuseIdentifier:@"myBlogCell"];
    self.collecview.backgroundColor        = BackgroundColor;
    self.collecview.frame                  = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    
    self.navigationItem.rightBarButtonItem = self.choseItem;
    
    [self configCollectviewData];
    
    self.collecview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirst)];
    
    self.collecview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.collecview.header beginRefreshing];
}


#pragma mark Action

- (void)chose{
    

    ischose = !ischose;

    [UIView animateWithDuration:.2 animations:^{
        
        if (ischose) {
            
            self.collecview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-40);
            self.toolbar.frame    = CGRectMake(0, ScreenHeight-64-40, ScreenWidth, 40);
        }
        else{
            
            self.collecview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
            self.toolbar.frame    = CGRectMake(0, ScreenHeight-64, ScreenWidth, 40);
            
        }
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
             [self.selectArray removeAllObjects];
             [self.collecview reloadData];
        }
    }];

}


- (void)delete{
    
    if (self.selectArray.count>0) {
        
        NSMutableArray *temp = [NSMutableArray array];
        
        for (MyNewsModel *model in self.selectArray) {
            
            [temp addObject:model.id];
        }
        
        NSString *ids = [temp componentsJoinedByString:@","];
        
        [[MineService shareInstanced]delNewWithIds:ids];
        
        [self showHud];
        [MineService shareInstanced].delMyNewsSuccess = ^(id obj){
            
            [self hideHud];
            
            [self.dataSource removeObjectsInArray:self.selectArray];
            
            [self.selectArray removeAllObjects];
            
            [self.collecview reloadData];
            
        };
        
        [MineService shareInstanced].delMyNewsFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
        };
        
    }
    
    else{
        
        [self showHudWithString:@"请选择帖子"];
    }
    
    
}

- (void)cancle{
    
    [self chose];
}
#pragma mark Service

- (void)configCollectviewData{
    
    [MineService shareInstanced].getMyNewsSuccess =^(id obj) {
      
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        self.dataSource = obj;
        
        [self.collecview reloadData];
        
    };
    
    [MineService shareInstanced].getMyNewsFailure = ^(id obj){
        
        [self.collecview.header endRefreshing];
        
        [self.collecview.footer endRefreshing];
        
        [self showHudWithString:obj];
    };
    
}


- (void)loadFirst{
    
    [[MineService shareInstanced]getMyFirstNewsWithUid:self.userInfo.uid];
    
}

- (void)loadMore{
    
    [[MineService shareInstanced]getMyMoreNewsWithUid:self.userInfo.uid];
    
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BlogCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myBlogCell" forIndexPath:indexPath];
    
    MyNewsModel *model = self.dataSource[indexPath.row];
    
    [cell.imgv sd_setImageWithURL:[NSURL URLWithString:model.news_thumb] placeholderImage:nil];
    
    cell.titleLab.text = model.news_title;
    
    [cell.headimgv sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:DefaultAvatar];
    
    cell.nameLab.text = model.news_author;
    
    if (ischose) {
        
        if ([self.selectArray containsObject:model]) {
            
            cell.selectimgv.image = [UIImage imageNamed:@"我的-优惠券-勾选"];
        }
        else{
            
            cell.selectimgv.image = [UIImage imageNamed:@"我的-优惠券-未勾选"];
        }

    }
    else{
        
        cell.selectimgv.image = nil;
    }
    
    return cell;
   
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    ForumModel
    MyNewsModel *model = self.dataSource[indexPath.row];
    
     if (ischose) {
         
         
         
         if ([self.selectArray containsObject:model]) {
             
             [self.selectArray removeObject:model];
             
             [collectionView reloadData];
         }
         else{
             
             [self.selectArray addObject:model];
             
             [collectionView reloadData];
         }
         
     }
     else{
         
         ForumModel *forum = [[ForumModel alloc]init];
         
         forum.id = model.id;
         
         DetailViewController *vc = [[DetailViewController alloc]init];
         
         
         [self.navigationController pushViewController:vc animated:YES];

         
     }
    
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


#pragma mark getter

- (UIToolbar *)toolbar{
    
    if (_toolbar == nil) {
        
        _toolbar                    = [[UIToolbar alloc]initWithFrame:CGRectMake(0, ScreenHeight-64, ScreenWidth, 40)];
        
        UIButton *cancleBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 49)];
        
        cancleBtn.titleLabel.font   = [UIFont systemFontOfSize:14];
        
        [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancleBtn addTarget:self
                      action:@selector(cancle)
            forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
        
        UIBarButtonItem *spaceItem  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
        
        UIButton *deleteBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [deleteBtn setImage:[UIImage imageNamed:@"删除"]
                   forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(delete)
            forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
        
        _toolbar.items              = @[cancleItem,spaceItem,deleteItem];
        
        [self.view addSubview:_toolbar];
        
    }
    
    return _toolbar;
}

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[]mutableCopy];
        
    }
    return _dataSource;
}

- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        _selectArray = [@[]mutableCopy];
        
    }
    return _selectArray;
}


- (UIBarButtonItem *)choseItem{
    
    if (_choseItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"选择" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(chose) forControlEvents:UIControlEventTouchUpInside];
        _choseItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _choseItem;
}

- (UserModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}



@end

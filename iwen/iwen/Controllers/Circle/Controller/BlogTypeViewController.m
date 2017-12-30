//
//  BlogTypeViewController.m
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BlogTypeViewController.h"
#import "BlogTypeCell.h"
#import "BlogData.h"
#import "ReViewController.h"
#import "SendAdvViewController.h"
@interface BlogTypeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIBarButtonItem *sendItem;

@end

@implementation BlogTypeViewController
{
    NSString *selectId;
    
    
    PersonModel *userInfo;
}
#pragma mark ViewLife cyle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadCourType];
}

- (void)setupUI{
    
    
    self.view.backgroundColor              = BackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:@"BlogTypeCell" bundle:nil];
    [self.collecview registerNib:nib forCellWithReuseIdentifier:@"typeCell"];
    self.collecview.backgroundColor        = BackgroundColor;

    self.navigationItem.rightBarButtonItem = self.sendItem;
    
    userInfo = [[LoginService shareInstanced]getUserModel];
}


#pragma mark Action

- (void)done{
    
    SendAdvViewController *vc = [[SendAdvViewController alloc]init];
    vc.title = @"发布信息";
    vc.type = @"re";
    [self.navigationController pushViewController:vc animated:YES];
    
////    NSDictionary *dic =@{@"uid":userInfo.uid,@"title":self.model.title,@"picture":self.model.base64Str,@"class_id":[NSString stringWithFormat:@"%@",selectId],@"content":self.model.content};
////    
////    [[CircleService shareInstaced]addNewsWitDic:dic];
////    
//    [self showHud];
//    
//    [CircleService shareInstaced].addNewsSuccess = ^ (id obj){
//        
//        [self hideHud];
//      
//        [self showHudWithString:@"发布成功"];
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    };
//    
//    [CircleService shareInstaced].addNewsFailure = ^ (id obj){
//        
//        [self hideHud];
//        [self showHudWithString:obj];
//    };
}

#pragma mark Service

- (void)loadCourType{
    
    [[CircleService shareInstaced]getCircleList];
    
    [CircleService shareInstaced].getCircleListSuccess = ^(id obj){
        
        self.dataSource = obj;
        
        [self.collecview reloadData];
    };
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BlogTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typeCell" forIndexPath:indexPath];
    
    CircleListModel *model      = self.dataSource[indexPath.row];

    cell.lab.text = model.fname;
    
    return cell;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CircleListModel *model      = self.dataSource[indexPath.row];
    
    ReViewController *vc = [[ReViewController alloc]init];
    vc.city = self.city;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([OSHelper iPhone6]) {
        return CGSizeMake(120, 50);
    }
    
    return CGSizeMake(100, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0,0,0);
}


#pragma mark getter

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[]mutableCopy];
        
    }
    return _dataSource;
}


- (UIBarButtonItem *)sendItem{
    
    if (_sendItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"发布" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        _sendItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _sendItem;
}


- (IBAction)searaciton:(id)sender {
    
    if (self.textf.text.length>0) {
        
        CircleListModel *model      = [self.dataSource firstObject];
        ReViewController *vc = [[ReViewController alloc]init];
        vc.city = self.city;
        vc.word = self.textf.text;
        vc.model = model;
        [self.textf resignFirstResponder];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
@end

//
//  ExamResultViewController.m
//  iwen
//
//  Created by Interest on 15/11/2.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamResultViewController.h"
#import "CardCell.h"
#import "ShareView.h"
@interface ExamResultViewController ()<ZZShareViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIBarButtonItem * shareItem;

@property (nonatomic, strong) ShareView       *sharView;

@end

@implementation ExamResultViewController

#pragma mark getter

- (UIBarButtonItem *)shareItem{
    
    if (_shareItem == nil) {
        
        UIButton *shareBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [shareBtn setImage:[UIImage imageNamed:@"圈子-详情-分享1"]
                  forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareAction)
           forControlEvents:UIControlEventTouchUpInside];
        _shareItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    }
    
    return _shareItem;
}

- (ShareView *)sharView{
    
    if (_sharView == nil) {
        
        _sharView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        
        self.sharView.delegate = self;
    }
    
    return _sharView;
    
}

- (NSMutableArray *)dataSource{
    
    
    
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
        
        
    }
    
    return _dataSource;
    
}



#pragma mark ViewLife cyle



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
}



- (void)setupUI{
    
    self.title = @"考试报告";
    
    if (self.examId) {
        
      self.navigationItem.rightBarButtonItem  = self.shareItem;
    }

    self.titLab.text  = self.resultModel.txt;
    
    self.countLab.textColor = [UIColor redColor];
    self.statuLab.textColor = [UIColor redColor];
    
    self.countLab.text = self.resultModel.score;
    
    self.statuLab.text = self.resultModel.type;
    
    self.timeLab.text = self.resultModel.use_time;
    
    self.dataSource = [self.resultModel.answer_status mutableCopy];
//    [self.collectview reloadData];
    
    if ([self.resultModel.score intValue]<60) {
        
        self.leftImgv.image = [UIImage imageNamed:@"不及格标签"];
        self.centerImgv.image = [UIImage imageNamed:@"不及格"];
    }
    else if ([self.resultModel.score intValue]<80 && [self.resultModel.score intValue]>=60){
        
        self.leftImgv.image = [UIImage imageNamed:@"及格标签"];
        self.centerImgv.image = [UIImage imageNamed:@"及格"];
    }
    else{
        
        self.leftImgv.image = [UIImage imageNamed:@"优秀标签"];
        self.centerImgv.image = [UIImage imageNamed:@"优秀"];
    }
    
}

#pragma mark Action

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)shareAction{
    
    
    
    if (!self.sharView.isShowing) {
        
        [self.sharView showInView:self.view];
    }
    else{
        
        [self.sharView dismiss];
    }
    
}


- (IBAction)tryAction:(id)sender {
    
    if (![self.resultModel.status boolValue]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tryAgin)]) {
            
            [self.delegate tryAgin];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    else{

        
    }
}



#pragma mark Service



#pragma mark ZZShareViewDelegate

- (void)shareView:(ShareView *)shareView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    NSLog(@"%ld",(long)buttonIndex);
    
    if (buttonIndex == 1) {
        
        [self shareWithType:SSDKPlatformTypeQQ];
    }
    
    if (buttonIndex == 2) {
        
        [self shareWithType:SSDKPlatformSubTypeQZone];
    }
    
    if (buttonIndex == 3) {
        
        [self shareWithType:SSDKPlatformSubTypeWechatTimeline];
    }
    
    if (buttonIndex == 4) {
        
        [self shareWithType:SSDKPlatformSubTypeWechatSession];
    }
    if (buttonIndex == 5) {
        
        [self shareWithType:SSDKPlatformTypeSinaWeibo];
    }
    
    if (buttonIndex == 6) {
        
        [self shareWithType:SSDKPlatformTypeSinaWeibo];
    }
}

- (void)shareWithType:(SSDKPlatformType)type{
    
    UserModel *user  = [[LoginService shareInstanced]getUserModel];
    
        NSString *str =  [NSString stringWithFormat:@"http://wxs.gzinterest.com/index.php?g=Port&m=Topic&a=shareExamResult&exam_id=%@&uid=%@",self.examId,user.uid];
    
    NSLog(@"%@",str);
        [[ShareManager sharePlatform]share:type title:@"分享" content:@"考试结果" url:str];
//    [[ShareManager sharePlatform]share:type title:@"分享" content:@"勤美堂" url:@"http://fir.im/9q58"];
}



//#pragma mark UICollectionViewDataSource
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    
//    
//    return  [self.dataSource count];
//
//}
//
//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCardCell" forIndexPath:indexPath];
//    
//    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//    
//    NSString *str = self.dataSource[indexPath.row];
//    
//    if ([str boolValue]) {
//        
//        cell.lab.textColor = [UIColor whiteColor];
//        
//        cell.lab.backgroundColor = BaseColor;
//    }
//    else{
//        
//        cell.lab.textColor = BaseColor;
//        
//        cell.lab.backgroundColor = [UIColor whiteColor];
//    }
//    return cell;
//    
//}
//
//
//
//#pragma mark UICollectionViewDelegate
//
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//}
//
//#pragma mark UICollectionViewDelegateFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    return CGSizeMake(45, 45);
//    
//}

@end

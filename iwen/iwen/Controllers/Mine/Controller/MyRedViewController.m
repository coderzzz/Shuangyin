//
//  MyRedViewController.m
//  iwen
//
//  Created by Interest on 16/3/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyRedViewController.h"
#import "PutOnCell.h"

@interface MyRedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSMutableArray *imageArray;

@property (nonatomic, strong)  NSMutableArray *rightArray;
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation MyRedViewController
{
    
    NSString *select;
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    select = @"1";
    
    [self setupUI];
    
    
    [self configCollectviewData];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirst)];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.tableview.header beginRefreshing];
    
}



- (void)setupUI
{
    
    self.title = @"我的红包";
    
    UINib *nib  = [UINib nibWithNibName:@"PutOnCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"PutCell"];
    self.tableview.backgroundColor = BackgroundColor;

    [self.tableview setTableHeaderView:self.headview];
    
    
    
    self.redlab.text = [NSString stringWithFormat:@"%.2f元",[self.userInfo.use.ftotal floatValue]/100];
    
    self.redBtn.selected = YES;
    self.rigview.hidden = YES;
    
    [self.tableview clearSeperateLine];
    
}


#pragma mark Action
- (IBAction)leftAction:(UIButton *)sender {
    
    select = @"1";
    
    self.redBtn.selected = YES;
    self.rigbtn.selected = NO;
    
    self.redview.hidden = NO;
    self.rigview.hidden = YES;
    
    [self.tableview reloadData];
    
}

- (IBAction)rigaciton:(id)sender {
    
    select = @"2";
    self.redBtn.selected = NO;
    self.rigbtn.selected = YES;
    
    self.redview.hidden = YES;
    self.rigview.hidden = NO;
    
    if (self.rightArray.count>0) {
        
       [self.tableview reloadData];
    }
    else{
        
        [self.tableview.header beginRefreshing];
    }
    
}
#pragma mark Service

- (void)configCollectviewData{
    
    
    [MineService shareInstanced].getMyNewsSuccess = ^(id obj){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        
        
        self.imageArray = [obj copy];
        
        
        [self.tableview reloadData];
    };
    
    [MineService shareInstanced].getMyNewsFailure = ^(id obj){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        [self showHudWithString:obj];
    };
    
    
    [MineService shareInstanced].getCouponSuccess =^(id obj) {
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
  
            
        self.rightArray = [obj copy];
  
        
        [self.tableview reloadData];
        
    };
    
    [MineService shareInstanced].getCouponFailure = ^(id obj){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        [self showHudWithString:obj];
    };
    
}


- (void)loadFirst{
    
    if ([select isEqualToString:@"1"]) {
        
        [[MineService shareInstanced]getMyFirstNewsWithUid:self.userInfo.use.ftoken];
        
    }
    else{
        
         [[MineService shareInstanced]getFirstCoupenWithUid:self.userInfo.use.ftoken];
    }
        
}

- (void)loadMore{
    
    if ([select isEqualToString:@"1"]) {
        
        [[MineService shareInstanced]getMyMoreNewsWithUid:self.userInfo.use.ftoken];
        
    }
    else{
        
        [[MineService shareInstanced]getMoreCoupenWithUid:self.userInfo.use.ftoken];
    }
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([select isEqualToString:@"1"]) {
    
        return [self.imageArray count];
        
    }else{
        
        return [self.rightArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PutOnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PutCell"];
    
    NSDictionary *dic= [NSDictionary dictionary];
    
    if ([select isEqualToString:@"1"]) {
        
        dic = self.imageArray[indexPath.row];

    }
    else{
        
        dic = self.rightArray[indexPath.row];
        
    }
    
    if (dic) {
        
        cell.titlab.text = dic[@"adName"];
        
        NSString *fee = [NSString stringWithFormat:@"%@",dic[@"fmoney"]];
        
        
        
        cell.rigLab.text = [NSString stringWithFormat:@"%.2f元",[fee floatValue]/100];
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,dic[@"adImg"]]]];
        
        NSString *date = [NSString stringWithFormat:@"%@",dic[@"fcreateTime"]];
        
        long long time = [date longLongValue]/1000;
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time];
        
        cell.dateLab.text = [NSDate formatDateString:@"YYYY-MM-dd" withDate:date2];
        
    }
 
    return cell;
    
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
    DetailViewController *my = [[DetailViewController alloc]init];
    NSDictionary *dic= [NSDictionary dictionary];
    
    if ([select isEqualToString:@"1"]) {
        
        dic = self.imageArray[indexPat.row];
        
    }
    else{
        
        dic = self.rightArray[indexPat.row];
        
    }
    id advid = [NSString stringWithFormat:@"%@",dic[@"fadvertId"]];
    
    if (advid) {
        
        my.advId = advid;
        my.city = @"广东省广州市天河区";
        
        my.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:my animated:YES];
        
    }

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


#pragma mark getter


- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        
        _imageArray =[@[]mutableCopy];
    }
    return _imageArray;
}

- (NSMutableArray *)rightArray
{
    if (_rightArray == nil) {
        
        _rightArray =[@[]mutableCopy];
    }
    return _rightArray;
}


- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}


@end

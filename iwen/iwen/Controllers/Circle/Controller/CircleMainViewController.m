//
//  CircleMainViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CircleMainViewController.h"
#import "ForumViewController.h"
#import "SendBlogViewController.h"
#import "CircleCell.h"
#import "AdvertisementView.h"
@interface CircleMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray  *dataSource;
@property (nonatomic, strong) UIBarButtonItem *sendItem;
@property (nonatomic, strong) AdvertisementView *adView;
@end

@implementation CircleMainViewController



#pragma mark ViewLife cyle



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpUi];
    
    [self loadAdData];
    
    [self loadCircleList];

}

- (void)setUpUi{
    
    self.title = @"个人中心";
    
    self.tableview.backgroundColor = BackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:@"CircleCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"cirCell"];
    
    [self.navigationItem setRightBarButtonItem:self.sendItem];
}


#pragma mark Action

- (void)sendblog{
    
    SendBlogViewController *vc  = [[SendBlogViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark Service

- (void)loadAdData{
    
    [[LoginService shareInstanced]getAdvertisementWithType:@"1"];
    
    [LoginService shareInstanced].getAdvertisementSuccess = ^ (id obj){
        
        self.adView.urlArray = obj;
        [self.tableview setTableHeaderView:self.adView];
    };

}

- (void)loadCircleList{
    
    [[CircleService shareInstaced]getCircleList];
    
    [CircleService shareInstaced].getCircleListSuccess = ^(id obj){
      
        self.dataSource = obj;
        
        [self.tableview reloadData];
    };
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cirCell"];
    
    CircleListModel *model = self.dataSource[indexPath.row];
    
    [cell.imgv sd_setImageWithURL:[NSURL URLWithString:model.class_image] placeholderImage:nil];
    
    cell.titleLab.text = model.class_name;
    
    cell.hotLab.text = [NSString stringWithFormat:@"今日%@",model.read_times_today];
    
    cell.subLab.text = model.class_sub_class;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ForumViewController *vc     = [[ForumViewController alloc]init];
    
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.model = self.dataSource[indexPath.row];
    
    vc.title = vc.model.class_name;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
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
        
        UIButton *blogItem  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [blogItem setImage:[UIImage imageNamed:@"发帖-"] forState:UIControlStateNormal];
        [blogItem addTarget:self action:@selector(sendblog) forControlEvents:UIControlEventTouchUpInside];
        _sendItem = [[UIBarButtonItem alloc]initWithCustomView:blogItem];
        
        
    }
    
    return _sendItem;
}

- (AdvertisementView *)adView{
    
    if (_adView == nil) {
        
        _adView = [[AdvertisementView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
        
    }
    
    return _adView;
    
}

@end

//
//  pusController.m
//  iwen
//
//  Created by sam on 16/10/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "pusController.h"
#import "pusCell.h"
@interface pusController ()
@property (nonatomic, strong)  NSMutableArray *imageArray;
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation pusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [sendbtn setTitle:@"详情" forState:UIControlStateNormal];
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
    [sendbtn addTarget:self action:@selector(cash) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
    self.navigationItem.rightBarButtonItem = settingItem;
    
    UINib *nib  = [UINib nibWithNibName:@"pusCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"sg"];
    self.tableview.backgroundColor = BackgroundColor;
    
    [self.tableview clearSeperateLine];
    [self configBlock];
    
    
    
    
    _tableview.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstload)];
    _tableview.footer = [MJRefreshAutoFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    [self.tableview.header beginRefreshing];
   
}
#pragma mark Service
- (void)firstload{
    
    [[CircleService shareInstaced]getFirst1WithId:self.token?self.token:@"" type:self.type];
}
- (void)loadmore{
    
    [[CircleService shareInstaced]getMore1WithId:self.token?self.token:@"" type:self.type];
}
-(void)configBlock
{
    [CircleService shareInstaced].get1Success = ^(id obj){
        
        [_tableview.header endRefreshing];
        [_tableview.footer endRefreshing];
        _imageArray = [obj mutableCopy];
        [_tableview reloadData];
        
        
        
    };
    
    [CircleService shareInstaced].get1Failure = ^(id obj){
        [_tableview.header endRefreshing];
        [_tableview.footer endRefreshing];
        
    };
    
   
    
    
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.imageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    pusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sg"];
    if (indexPath.row < self.imageArray.count) {
        
        NSDictionary *model = self.imageArray[indexPath.row];
        cell.monlab.text = [NSString stringWithFormat:@"%.2f元",[model[@"fmoney"] floatValue]/100];
        NSString *time = [NSString stringWithFormat:@"%@",model[@"fcreateTime"]];
        long date = [time floatValue]/1000;
        NSDate *da  = [NSDate dateWithTimeIntervalSince1970:date];
        cell.datelab.text = [da formatDateString:nil];
        cell.name.text = [NSString stringWithFormat:@"%@",model[@"userName"]];
       
    }
    
    return cell;
    
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}


#pragma mark getter


- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        
        _imageArray =[@[]mutableCopy];
    }
    return _imageArray;
}

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}

- (void)cash{
    
    DetailViewController *vc = [[DetailViewController alloc]init];
//    if ([self.type isEqualToString:@"red"]) {
//        
//        vc.type = @"re";
//    }
//    else{
//        vc.type = @"re";
//    }
    vc.title = @"详情";
    vc.advId = self.token;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

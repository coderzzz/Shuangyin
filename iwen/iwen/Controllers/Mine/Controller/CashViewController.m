//
//  CashViewController.m
//  iwen
//
//  Created by sam on 16/3/7.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "CashViewController.h"
#import "PersonCell.h"
#import "MyCashViewController.h"

@interface CashViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  UIBarButtonItem *settingItem;
@property (nonatomic, strong)  NSMutableArray *imageArray;
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation CashViewController


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    
}



- (void)setupUI
{
    
    self.title = @"提现记录";
    
    UINib *nib  = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"perCell"];
    self.tableview.backgroundColor = BackgroundColor;

    self.navigationItem.rightBarButtonItem = self.settingItem;
    [self.tableview clearSeperateLine];
    [self loadData];
    
}

- (UIBarButtonItem *)settingItem{
    
    if (_settingItem  == nil) {
        
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"提现" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(cash) forControlEvents:UIControlEventTouchUpInside];
        _settingItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _settingItem;
}
- (void)cash{
    
    
    MyCashViewController *vc = [[MyCashViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark Action

#pragma mark Service

- (void)loadData{
    
    [[MineService shareInstanced]delNewWithIds:self.userInfo.use.ftoken];
    
    [self showHud];
    [MineService shareInstanced].delMyNewsSuccess = ^(id obj){
        
        [self hideHud];
        self.imageArray = [obj copy];
        
        [self.tableview reloadData];
    };
    
    [MineService shareInstanced].delMyNewsFailure = ^(id ojb){
        
      
        [self hideHud];
        [self showHudWithString:ojb];
    };
    
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.imageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"perCell"];
    if (indexPath.row < self.imageArray.count) {
        
        NSDictionary *model = self.imageArray[indexPath.row];
        cell.countLab.text = [NSString stringWithFormat:@"%.2f元",[model[@"fmoney"] floatValue]/100];
        NSString *time = [NSString stringWithFormat:@"%@",model[@"fcreateTime"]];
        long date = [time floatValue]/1000;
        NSDate *da  = [NSDate dateWithTimeIntervalSince1970:date];
        cell.datelab.text = [da formatDateString:nil];
        NSString *type = [NSString stringWithFormat:@"%@",model[@"fstatus"]];
        if ([type isEqualToString:@"1"]) {
            
            cell.statuelab.text = @"提现成功";
        }else{
            cell.statuelab.text = @"处理中";
        }
    }
    
    return cell;
    
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
   
    
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

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}


@end

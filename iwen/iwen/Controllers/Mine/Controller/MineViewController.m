//
//  MineViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MineViewController.h"
#import "PersonCenterViewController.h"
#import "CommonAddressViewController.h"
#import "LoginViewController.h"
#import "CoupenViewController.h"
#import "MyBlogViewController.h"
#import "MoreViewController.h"
#import "logoutCell.h"
#import "MainCell.h"
#import "WebViewController.h"
#import "MoreViewController.h"
#import "PutOnViewController.h"
#import "CashViewController.h"
#import "MyRedViewController.h"
#import "AdvCenterViewController.h"
#import "AccountViewController.h"
#import "MyMoneyViewController.h"
#import "MyCoupenViewController.h"
#import "WeicoViewController.h"
#import "MReViewController.h"
#define DetailLabFont [UIFont systemFontOfSize:14.0f]
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)  NSMutableArray *imageArray;
@property (nonatomic, strong)  NSMutableArray *sectionHightArray;
@property (nonatomic, strong)  PersonModel      *userInfo;
@property (nonatomic, strong)  UIBarButtonItem *settingItem;
@end

@implementation MineViewController
{
   
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getRed];
//    self.userInfo = nil;
//    [self.tableview reloadData];
    
    
    
    
}

- (void)setupUI
{
    
    self.title = @"我的";
    
    UINib *nib  = [UINib nibWithNibName:@"MainCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"myMainCell"];
    self.tableview.backgroundColor = BackgroundColor;
    
    [self.tableview setTableHeaderView:self.headview];
    [self.tableview setTableFooterView:self.footview];

    [self.tableview reloadData];
    
    self.navigationItem.rightBarButtonItem = self.settingItem;
    
    if (!self.userInfo.use.ftoken.length>0) {
        
        [self.logoutbtn setTitle:@"登陆" forState:UIControlStateNormal];
    }
    
    
    self.countLab.text = [NSString stringWithFormat:@"%.2f元",[self.userInfo.use.ftotal floatValue]/100];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(log) name:@"LogOut" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRed) name:@"GetRed" object:nil];
    
    
}

-(void)getRed{
    

    [[LoginService shareInstanced]getUserDetailWithID:self.userInfo.use.ftoken];
    [LoginService shareInstanced].getUserDetailSuccess = ^(id obj){
        
      
        if (obj) {
            

            self.userInfo = [obj copy];
            
            self.countLab.text = [NSString stringWithFormat:@"%.2f元",[self.userInfo.use.ftotal floatValue]/100];
     
        }
    };
    [LoginService shareInstanced].getUserDetailFailure = ^(id obj){
        
       
        [self showHudWithString:obj];
    };
    
}

- (void)log{
    
    self.userInfo = nil;
    self.countLab.text = [NSString stringWithFormat:@"%.2f元",[self.userInfo.use.ftotal floatValue]/100];
    [self.logoutbtn setTitle:@"登陆" forState:UIControlStateNormal];
}

- (UIBarButtonItem *)settingItem{
    
    if (_settingItem  == nil) {
        
        UIButton *blogItem         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [blogItem setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        [blogItem addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        _settingItem = [[UIBarButtonItem alloc]initWithCustomView:blogItem];
        
        
    }
    
    return _settingItem;
}
- (void)setting{
    
    
    MoreViewController *vc = [[MoreViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark Action
- (IBAction)logout:(id)sender {
    
    if (!self.userInfo.use.ftoken.length>0) {
        
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        LoginViewController *vc = [[LoginViewController alloc]init];
        BaseNavigationController *ba = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        dele.window.rootViewController = ba;
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出账号？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
    
}

#pragma mark Service



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return self.imageArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.imageArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    
    cell.imageView.image     = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.textLabel.text      = self.sectionHightArray[indexPath.section][indexPath.row];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    cell.accessoryType       = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font      = DetailLabFont;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
  
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
  
    if (indexPat.section ==0) {
        
        if (indexPat.row == 0) {
            
            PersonCenterViewController *vc = [[PersonCenterViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPat.row == 5) {
            
            MReViewController *vc = [[MReViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        if (indexPat.row == 1) {
            
            MyRedViewController *vc = [[MyRedViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        if (indexPat.row == 4) {
            
            
            MyCoupenViewController *vc = [[MyCoupenViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
//            vc.title = @"我的旗袍说";
//            vc.type = @"2";
//            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        if (indexPat.row == 2) {
            
            
            CashViewController *vc = [[CashViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
       
        if (indexPat.row == 3) {
            
            
            WeicoViewController *vc = [[WeicoViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            vc.title = @"我的旗袍说";
            vc.type = @"2";
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
    if (indexPat.section == 1) {
        
        if (indexPat.row ==0) {
            
            AdvCenterViewController *vc = [[AdvCenterViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else{
            
            if (self.userInfo.adv.fisCoupon.length>0 && self.userInfo.adv.fisRed.length>0) {
                
                PutOnViewController *vc = [[PutOnViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                
                [self showHudWithString:@"您不是商家，无权限进入"];
            }
            
        }
    }
    
    if (indexPat.section == 2) {
        
        if (indexPat.row ==0) {
            
            AccountViewController *vc = [[ AccountViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else{
            
            
            if (self.userInfo.adv.fisCoupon.length>0 && self.userInfo.adv.fisRed.length>0){
                MyMoneyViewController *vc = [[MyMoneyViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                [self showHudWithString:@"您不是商家，无权限进入"];
            }
        }
    }
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [[LoginService shareInstanced]loginout];
        
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        LoginViewController *vc = [[LoginViewController alloc]init];
        BaseNavigationController *ba = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        dele.window.rootViewController = ba;
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LogOut" object:nil];
        
        
    }
    
}
#pragma mark getter

- (NSMutableArray *)sectionHightArray
{
    if (_sectionHightArray == nil) {
        
        _sectionHightArray = [@[@[@"个人中心",@"我的红包",@"我的提现",@"我的旗袍说",@"我的优惠券",@"我的发布"],@[@"商家信息",@"广告投放"],@[@"商家余额",@"收益统计"]] mutableCopy];
    }
    return _sectionHightArray;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        
        
         _imageArray = [@[@[@"1111",@"红包1",@"个人中心-我的提现",@"个人中心-旗袍说",@"个人中心-优惠券",@"my_add_info"],@[@"个人中心-商家信息",@"个人中心-广告投放"],@[@"个人中心-商家余额",@"个人中心-收益统计"]] mutableCopy];
        
        
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

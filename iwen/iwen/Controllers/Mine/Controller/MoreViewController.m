//
//  MoreViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "FixPassWordViewController.h"
#import "GuideViewController.h"
#import "UpViewController.h"
#import "SuggestionViewController.h"
#define LabFont [UIFont systemFontOfSize:14.0]
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *lefeArray;


@end

@implementation MoreViewController

- (NSArray *)lefeArray
{
    if (_lefeArray == nil) {
        _lefeArray = @[@[@"提现账号"],@[@"意见反馈",@"修改密码",@"关于我们"]];
    }
    return _lefeArray;
}


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUi];
}

- (void)setupUi
{
    
    self.title = @"设置";
    
    self.tableview.backgroundColor = BackgroundColor;
    self.tableview.separatorColor = SeparatorColor;
    
    [self.tableview clearSeperateLine];

}


#pragma mark Action


#pragma mark Service



#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.lefeArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.lefeArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = self.lefeArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = LabFont;

    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        
        GuideViewController *vc = [[GuideViewController alloc]init];
        
        vc.title = @"绑定";
        
        [self.navigationController pushViewController:vc animated:YES];
        
        //        FixPassWordViewController *vc = [[FixPassWordViewController alloc]init];
        //
        //        vc.type = @"2";
        //
        //        vc.title = @"修改密码";
        //
        //
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 2) {
        
        AboutViewController *vc = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 0&& indexPath.section == 1) {
        
        SuggestionViewController *vc = [[SuggestionViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1&& indexPath.section == 1) {
        
        UpViewController *vc = [[UpViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



@end

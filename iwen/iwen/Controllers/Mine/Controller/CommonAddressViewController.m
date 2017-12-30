//
//  CommonAddressViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CommonAddressViewController.h"
#import "CenterCell.h"
@interface CommonAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (strong, nonatomic) NSArray *lefeArray;
@property (nonatomic, strong)  UserModel      *userInfo;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CommonAddressViewController
{
    NSInteger  didSelectIndex;
    
    
    
}
#pragma mark getter

- (NSArray *)lefeArray
{
    if (_lefeArray == nil) {
        _lefeArray = @[@[@"收件人"],@[@"收件地区",@"街道门牌",@"邮政编码",@"手机号码"]];
    }
    return _lefeArray;
}

- (UserModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[@[@""],@[@"",@"",@"",@""]]mutableCopy];
        
    }
    return _dataSource;
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUi];
    [self loadData];
}

- (void)setupUi
{
    
    self.title = @"常用地址";
    
    self.tableview.backgroundColor = BackgroundColor;
    
    UINib *nib2  = [UINib nibWithNibName:@"CenterCell" bundle:nil];
    [self.tableview registerNib:nib2 forCellReuseIdentifier:@"cenCell"];
    self.tableview.separatorColor = SeparatorColor;
    
    [self.tableview clearSeperateLine];
}


#pragma mark Action


#pragma mark Service

- (void)loadData{
    
//    [[MineService shareInstanced]getAllAddressWithUid:self.userInfo.uid];
//    
    [MineService shareInstanced].getAllAddressSuccess = ^(id obj){
        
        AllAddressModel *model = obj;
        
        NSString *name = model.receiver_man;
        
        if (!name.length>0) {
            
            name = @"";
        }
        
        NSString * region= model.region;
        
        if (!region.length>0) {
            
            region = @"";
            
        }
        
        
        NSString *doorplate = model.doorplate;
        
        if (!doorplate.length>0) {
            
            doorplate = @"";
        }
        
        NSString *postalcode = model.postalcode;
        
        if (!postalcode.length>0) {
            
            postalcode = @"";
        }
        
        NSString *phone = model.phone;
        
        if (!phone.length>0) {
            
            phone = @"";
            
        }
        
        self.dataSource = [@[@[name],@[region,doorplate,postalcode,phone]]mutableCopy];
        
        [self.tableview reloadData];
 
    };
    
    [MineService shareInstanced].getAllAddressFailure = ^(id obj){
      
        
    };
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.lefeArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return [self.lefeArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    CenterCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cenCell"];
    cell.leftLab.text = self.lefeArray[indexPath.section][indexPath.row];
    cell.contenLab.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        didSelectIndex = 100;

    }
    else{
        
        didSelectIndex = indexPath.row;
    }
    
    NSString *str = self.lefeArray[indexPath.section][indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        UITextField *texfield = [alertView textFieldAtIndex:0];
        
        
        if (texfield.text.length>0) {
            
            
            [self updateUserInfoWithString:texfield.text];
            
        }
        else{
            
            [self showHudWithString:@"请输入内容"];
        }
        
    }
    
}

- (void)updateUserInfoWithString:(NSString *)string{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.userInfo.uid forKey:@"uid"];
    
    NSArray *ary = @[@"region",@"doorplate",@"postalcode",@"phone"];
    
    if (didSelectIndex == 100) {
        
        [dic setValue:string forKey:@"receiver_man"];
    }
    else{
        
        [dic setValue:string forKey:ary[didSelectIndex]];
    }
    
    
    [[MineService shareInstanced]updateAddressWithDictionary:dic];
    
    [self showHud];
    [MineService shareInstanced].updateAddressSuccess = ^(id obj){
        
        
        if (didSelectIndex == 100) {
            
            [self.dataSource replaceObjectAtIndex:0 withObject:@[string]];
        }
        else{
            
            NSMutableArray *temp = [self.dataSource[1] mutableCopy];
            
            [temp replaceObjectAtIndex:didSelectIndex withObject:string];
            
            [self.dataSource replaceObjectAtIndex:1 withObject:temp];
        }

        [self.tableview reloadData];
        
        [self hideHud];
        
    };
    
   [MineService shareInstanced].updateAddressFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
}

@end

//
//  CityViewController.m
//  iwen
//
//  Created by Interest on 16/3/5.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *table1Array;

@property (nonatomic, strong) NSMutableArray *table2Array;

@property (nonatomic, strong) NSMutableArray *table3Array;
@property (nonatomic, strong) UIBarButtonItem *sendItem;

@end

@implementation CityViewController{
    NSDictionary *data;
}
- (UIBarButtonItem *)sendItem{
    
    if (_sendItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"确定" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        _sendItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _sendItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择地区";
    
    self.table1Array = [NSMutableArray array];
    self.table2Array = [NSMutableArray array];
    self.table3Array = [NSMutableArray array];

    self.navigationItem.rightBarButtonItem = self.sendItem;
    CGFloat w = ScreenWidth/3;
    
    self.table1.frame = CGRectMake(0, 0, w, ScreenHeight-64);
    
    self.table2.frame = CGRectMake(w, 0, w, ScreenHeight-64);
    
    self.table3.frame = CGRectMake(w * 2, 0, w, ScreenHeight-64);
    
    [self.table1 clearSeperateLine];
    [self.table2 clearSeperateLine];
    [self.table3 clearSeperateLine];
    
    [self loadData];
}

#pragma mark Action
- (void)done{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCityWithdic:)] && data) {
        
        [self.delegate didSelectCityWithdic:data];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark Service

- (void)loadData{
    
    
    [self showHud];
    [[ExamService shareInstenced]getGradeTypeWithUid:@"0"];
    
    [ExamService shareInstenced].getGradeTypeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.table1Array = [obj copy];
        
        [self.table1 reloadData];
        
    };
    
    [ExamService shareInstenced].getGradeTypeFailure = ^(id obj){
        
        [self hideHud];
        
        
    };
    
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView == self.table1) {
        
        return self.table1Array.count;
    }
    else if (tableView == self.table2){
        
        return self.table2Array.count;
        
    }
    else{
        
        return self.table3Array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.table1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        }
        
        
        cell.textLabel.text = self.table1Array[indexPath.row][@"areaName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
        
    }
    else if (tableView == self.table2){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
       
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        }
         cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        
        cell.textLabel.text = self.table2Array[indexPath.row][@"areaName"];
        
        return cell;
        
    }
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        }
        
         cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.text = self.table3Array[indexPath.row][@"areaName"];
        
        return cell;
    }

}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.table1) {
        
        
        [self showHud];
        data =self.table1Array[indexPath.row];
        [[ExamService shareInstenced]getGradeTypeWithUid:self.table1Array[indexPath.row][@"areaNo"]];
        
        [ExamService shareInstenced].getGradeTypeSuccess = ^(id obj){
            
            [self hideHud];
            
            self.table2Array = [obj copy];
            
            [self.table2 reloadData];
            
        };
        
        [ExamService shareInstenced].getGradeTypeFailure = ^(id obj){
            
            [self hideHud];
            
            
        };

  
    }
    else if (tableView == self.table2){
        
        [self showHud];
        data =self.table2Array[indexPath.row];
        [[ExamService shareInstenced]getGradeTypeWithUid:self.table2Array[indexPath.row][@"areaNo"]];
        
        [ExamService shareInstenced].getGradeTypeSuccess = ^(id obj){
            
            [self hideHud];
            
            self.table3Array = [obj copy];
            
            [self.table3 reloadData];
            
        };
        
        [ExamService shareInstenced].getGradeTypeFailure = ^(id obj){
            
            [self hideHud];
            
            
        };
        
    }
    else{
           data =self.table3Array[indexPath.row];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    return 44;
}



@end

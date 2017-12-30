//
//  TypeViewController.m
//  iwen
//
//  Created by Interest on 16/3/4.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "TypeViewController.h"

@interface TypeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TypeViewController
{
    NSMutableArray *list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"行业选择";
    
    list = [NSMutableArray array];
    
    [self loadData];
}

- (void)loadData{
    
    [[ExamService shareInstenced]getCourseType];
    
    [self showHud];
    [ExamService shareInstenced].getCourseTypeSuccess = ^(id obj){
        
        [self hideHud];
        
        list = obj;
        
        if (list.count>0) {
            
            [self.tableview reloadData];
        }
        
    };
    
    [ExamService shareInstenced].getCourseTypeFailure = ^(id obj){
        
        [self hideHud];
    };
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (indexPath.row<list.count) {
        
        cell.textLabel.text = list[indexPath.row][@"fname"];
    }
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<list.count) {
        
        NSDictionary *dic = list[indexPath.row];
        
        if (dic && [self.delegate respondsToSelector:@selector(didSelectDic:)]) {
            
            [self.delegate didSelectDic:dic];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


@end

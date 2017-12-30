//
//  WebListViewController.m
//  iwen
//
//  Created by Carl on 15/11/18.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import "WebListViewController.h"
#import "WebViewController.h"
@interface WebListViewController ()

@end

@implementation WebListViewController
{
    NSMutableArray *dataSource;
    NSMutableArray *childs;
    CircleListModel *selectModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"类型选择";
    
    UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [sendbtn setTitle:@"确定" forState:UIControlStateNormal];
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
    [sendbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
    self.navigationItem.rightBarButtonItem = item;
    dataSource = [NSMutableArray array];
    childs = [NSMutableArray array];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth/2, ScreenHeight - 64);
    self.tableview2.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, ScreenHeight -64);
    [self loadCourType];
    [_tableView clearSeperateLine];
}
- (void)done{
    if (selectModel) {
     
        [self.delegate did:selectModel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)loadCourType{
    
    [[CircleService shareInstaced]getCircleList];
    
    [CircleService shareInstaced].getCircleListSuccess = ^(id obj){
        
        dataSource = obj;
        CircleListModel *model = [dataSource firstObject];
        if (dataSource.count>0) {
            
            
            [childs addObjectsFromArray:model.child];
            [self.tableview2 reloadData];
        }
        
        [self.tableView reloadData];
    };
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        
        return dataSource.count;
    }
    return childs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == self.tableView) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (dataSource.count>indexPath.row) {
            
            CircleListModel *model      = dataSource[indexPath.row];
            
            cell.textLabel.text = model.fname;
            if ([selectModel.fid isEqualToString:model.fid]) {
                
                cell.textLabel.textColor = [UIColor redColor];
            }
            else{
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        
        
        return cell;
    }
    else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (childs.count>indexPath.row) {
            
            CircleListModel *model      = childs[indexPath.row];
            
            cell.textLabel.text = model.fname;
            if ([selectModel.fid isEqualToString:model.fid]) {
                
                cell.textLabel.textColor = [UIColor redColor];
            }
            else{
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        
        selectModel      = dataSource[indexPath.row];
        [childs removeAllObjects];
        [childs addObjectsFromArray:selectModel.child];
        [self.tableview2 reloadData];
        [self.tableView reloadData];
    }else{
        selectModel = childs[indexPath.row];
        [self.tableview2 reloadData];
    }
    
}

@end

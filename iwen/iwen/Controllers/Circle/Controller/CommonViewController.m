//
//  CommonViewController.m
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonCell.h"

#define ButtomViewHight 40
@interface CommonViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *backItem;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CommonViewController
{
    
     UserModel       *userInfo;
}


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self addNotification];

}

- (void)setUpUI{
    
    self.title = @"评论";
    
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-ButtomViewHight);
    
    self.buttomView.frame = CGRectMake(0, self.tableview.frame.size.height, ScreenWidth, ButtomViewHight);
    
    
    self.buttomView.backgroundColor = BackgroundColor;
    
    
    self.navigationItem.leftBarButtonItem = self.backItem;
    
    
    UINib *nib = [UINib nibWithNibName:@"CommonCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"comCell"];
    
    self.tableview.separatorColor  = SeparatorColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    tap.delegate =self;
    
    [self.tableview addGestureRecognizer:tap];
    
    [self configTableData];
    
    [self.tableview clearSeperateLine];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableview.header beginRefreshing];
    
    userInfo = [[LoginService shareInstanced]getUserModel];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    
}
#pragma mark Action

- (IBAction)sendAction:(id)sender {
    
    if (!self.textField.text.length>0) {
        
        [self showHudWithString:@"请输入内容"];
        return;
    }
    
    [[CircleService shareInstaced]commentNewsWithId:self.newsId uid:userInfo.uid comment:self.textField.text];
    
    [CircleService shareInstaced].commentNewSuccess = ^ (id obj){
        
        CommonModel *model = obj;
        
        [self.tableview beginUpdates];
        
        [self.dataSource insertObject:model atIndex:0];
        
        [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableview endUpdates];
    
        
        self.textField.text = nil;
        
        [self.textField resignFirstResponder];
        

    };
    
    [CircleService shareInstaced].commentNewFailure = ^(id obj){
        
        [self showHudWithString:obj];
    };
    
    
}


- (void)hideKeyboard{
    
    if ([self.textField isFirstResponder]) {
        
        [self.textField resignFirstResponder];
    }
}

- (void)back{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark Service

- (void)configTableData{
    
    [CircleService shareInstaced].getCommentSuccess = ^(id obj){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        self.dataSource = obj;
        
        [self.tableview reloadData];
    };

    [CircleService shareInstaced].getCommentFailure = ^(id obj){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        [self showHudWithString:obj];
        
    };
    
}


- (void)loadFirstData{
    
    [[CircleService shareInstaced]getFirstCommentWithId:self.newsId];

}

- (void)loadMoreData{
    
    [[CircleService shareInstaced]getMoreCommentWithId:self.newsId];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self sendAction:nil];
    
    return YES;
    
}



#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([self.textField isFirstResponder]) {
        
        return YES;
    }
    
    return NO;
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
    
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comCell"];
    
    CommonModel *model = self.dataSource[indexPath.row];
    
    [cell.imgv sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:DefaultAvatar];
    
    cell.nameLab.text = model.username;
    
    cell.dateLab.text = model.add_time;
    
    cell.commonLab.text = model.comment;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除此评论？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    [alert show];
    
    CommonModel *model = self.dataSource[indexPath.row];
    
    [[CircleService shareInstaced]delCommentWithId:model.id uid:userInfo.uid];
    
    [CircleService shareInstaced].delCommentSuccess = ^(id obj){
        
        [self.dataSource removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    };
    
    [CircleService shareInstaced].delCommentFailure = ^(id obj){
        
        [self showHudWithString:obj];
        
    };
    
}

#pragma mark UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSLog(@"1");
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonModel *model = self.dataSource[indexPath.row];
    
    CGFloat h = [RTLabel getHightWithString:model.comment andSizeValue:15.0 andWidth:ScreenWidth-84.0];
    
    if (h<22) {
        
        h=22;
    }
    return h+90-22;

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    
}

#pragma mark Notification

- (void)addNotification{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-ButtomViewHight-endFrame.size.height);
    
    self.buttomView.frame = CGRectMake(0, self.tableview.frame.size.height, ScreenWidth, ButtomViewHight);
    
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-ButtomViewHight);
    
    self.buttomView.frame = CGRectMake(0, self.tableview.frame.size.height, ScreenWidth, ButtomViewHight);
    
}



#pragma mark getter
- (UIBarButtonItem *)backItem{
    
    if (_backItem == nil) {
        
        UIButton *backBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"通用-返回键1"]
                 forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back)
          forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    
    return _backItem;
}

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [@[]mutableCopy];
        
    }
    return _dataSource;
}

#pragma mark delloc

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}





@end

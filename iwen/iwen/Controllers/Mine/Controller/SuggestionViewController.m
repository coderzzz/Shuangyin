//
//  SuggestionViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()
@property (nonatomic, strong) UIBarButtonItem *choseItem;
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation SuggestionViewController

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}

- (UIBarButtonItem *)choseItem{
    
    if (_choseItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        _choseItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _choseItem;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = BackgroundColor;
    
    self.navigationItem.rightBarButtonItem = self.choseItem;
}

- (void)send{
    
    if (self.textview.text.length>0) {
        
        [[MineService shareInstanced]getFeedBackWithUid:self.userInfo.use.ftoken content:self.textview.text];
        
        [self showHud];
        [MineService shareInstanced].getFeedBackSuccess = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:@"反馈成功！"];
            
            [self.navigationController popViewControllerAnimated:YES];

        };
        
        [MineService shareInstanced].getFeedBackFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];

        };
        
    }
    else{
        
        [self showHudWithString:@"请输入内容"];
    }
}


@end

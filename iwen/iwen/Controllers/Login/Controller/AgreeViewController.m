//
//  AgreeViewController.m
//  iwen
//
//  Created by Interest on 15/11/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AgreeViewController.h"

@interface AgreeViewController ()

@end

@implementation AgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"平台说明";
    
    [self loadData];
}


- (void)loadData{
    
    
    [CircleService shareInstaced].delCommentSuccess = ^ (id obj){
        
        NSDictionary *dic = (NSDictionary *)obj;
        self.textview.text = dic[@"fcontent"];

    };
    
    [[CircleService shareInstaced]delCommentWithId:nil uid:nil];
}



@end

//
//  RightViewController.m
//  iwen
//
//  Created by Interest on 15/10/31.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RightViewController.h"
#import "PageVC.h"
@interface RightViewController ()

@end

@implementation RightViewController

//- (id)init{
//    
//    self = [super init];
//    if (self) {
//        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exam) name:@"exam" object:nil];
//        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToChapter) name:@"back" object:nil];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    self.navigationController.navigationBar.hidden = YES;
    
    self.nextBtn.backgroundColor = BaseColor;
    
    self.backBtn.backgroundColor = BaseColor;
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exam) name:@"exam" object:nil];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToChapter) name:@"back" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exam) name:@"exam" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToChapter) name:@"chapter" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(like) name:@"like" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(random) name:@"random" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(errorexam) name:@"errorexam" object:nil];
    
    
}

- (void)exam{
    
    self.lab.hidden = YES;
    
    [self.nextBtn setTitle:@"查看结果" forState:UIControlStateNormal];
    
    [self.backBtn setHidden:YES];
    
}

- (void)backToChapter{
    
    self.lab.hidden = NO;
    
    self.lab.text = @"本章节练习已经做完，是否开始下一章?";
    
    [self.nextBtn setTitle:@"下一章" forState:UIControlStateNormal];
    
    [self.backBtn setTitle:@"返回章节目录" forState:UIControlStateNormal];
    
    [self.backBtn setHidden:NO];
}

- (void)errorexam{
    
    self.lab.hidden = NO;
    
    self.lab.text = @"你已经浏览完当前所有错题";
    
    [self.nextBtn setTitle:@"重新浏览" forState:UIControlStateNormal];
    
    [self.backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    
    [self.backBtn setHidden:NO];
}

- (void)like{
    
    self.lab.hidden = NO;
    
    self.lab.text = @"你已经浏览完当前所有收藏题目";
    
    [self.nextBtn setTitle:@"重新浏览" forState:UIControlStateNormal];
    
    [self.backBtn setTitle:@"返回收藏目录" forState:UIControlStateNormal];
    
    [self.backBtn setHidden:NO];
    
    
}

- (void)random{
    
    [self.backBtn setHidden:NO];
    
    self.lab.hidden = NO;
    
    self.lab.text = @"练习已经全部做完";
    
    [self.nextBtn setTitle:@"从头开始" forState:UIControlStateNormal];
    
    [self.backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)btnAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
    
}

- (IBAction)backAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"back" object:nil];
}
@end

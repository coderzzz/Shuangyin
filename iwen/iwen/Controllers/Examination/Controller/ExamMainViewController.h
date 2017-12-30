//
//  ExamMainViewController.h
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamMainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIView *headview;

- (IBAction)refresh:(UIButton *)sender;

- (IBAction)weicoaction:(UIButton *)sender;

- (IBAction)getRedAction:(UIButton *)sender;

- (IBAction)pushReAction:(id)sender;


@end

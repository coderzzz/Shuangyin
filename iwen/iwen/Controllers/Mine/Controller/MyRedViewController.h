//
//  MyRedViewController.h
//  iwen
//
//  Created by Interest on 16/3/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface MyRedViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) IBOutlet UILabel *redlab;

@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *rigbtn;

@property (weak, nonatomic) IBOutlet UIView *redview;

@property (weak, nonatomic) IBOutlet UIView *rigview;
- (IBAction)leftAction:(UIButton *)sender;
- (IBAction)rigaciton:(id)sender;

@end

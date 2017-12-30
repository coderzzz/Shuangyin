//
//  MineViewController.h
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (strong, nonatomic) IBOutlet UIView *footview;

@property (weak, nonatomic) IBOutlet UIButton *logoutbtn;

- (IBAction)logout:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

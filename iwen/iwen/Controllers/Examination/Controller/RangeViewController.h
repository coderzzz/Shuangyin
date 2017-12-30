//
//  RangeViewController.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface RangeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *buttomView;

@property (weak, nonatomic) IBOutlet UIImageView *headImgv;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet UIButton *examBtn;

- (IBAction)examAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

- (IBAction)leftAction:(id)sender;

- (IBAction)rightAction:(id)sender;


@property (nonatomic,assign) NSString       *tourist;


@end

//
//  PersonCenterViewController.h
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonCenterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *head;

- (IBAction)pick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *agetf;

@property (weak, nonatomic) IBOutlet UITextField *sigtf;

@property (weak, nonatomic) IBOutlet UILabel *clab;

@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@property (weak, nonatomic) IBOutlet UIButton *menBtn;
@property (weak, nonatomic) IBOutlet UIButton *wbtn;
@property (weak, nonatomic) IBOutlet UIButton *unBtn;

- (IBAction)selectSex:(UIButton *)sender;







@end

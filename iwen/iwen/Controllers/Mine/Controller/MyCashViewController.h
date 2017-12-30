//
//  MyCashViewController.h
//  iwen
//
//  Created by Interest on 16/3/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface MyCashViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *toplab;

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *btn5;

@property (weak, nonatomic) IBOutlet UIButton *btn6;


- (IBAction)doneAction:(id)sender;

- (IBAction)cashAction:(UIButton *)sender;




@end

//
//  RightViewController.h
//  iwen
//
//  Created by Interest on 15/10/31.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface RightViewController : BaseViewController

- (IBAction)btnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backAction:(id)sender;

@end

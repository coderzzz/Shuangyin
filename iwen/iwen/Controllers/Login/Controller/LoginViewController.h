//
//  LoginViewController.h
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *logBtn;

@property (weak, nonatomic) IBOutlet UIButton *tourBtn;




- (IBAction)loginAction:(id)sender;

- (IBAction)registAction:(id)sender;

- (IBAction)vistAction:(id)sender;

- (IBAction)changgePWAction:(id)sender;

@property (nonatomic, strong) NSString *isTourist;

@end

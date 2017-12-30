//
//  FixPassWordViewController.m
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "FixPassWordViewController.h"
#import "RightViewController.h"
@interface FixPassWordViewController ()

@end

@implementation FixPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
   
    self.view.backgroundColor        = BackgroundColor;
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.cornerRadius  = 5.0;
    self.doneBtn.backgroundColor     = BaseColor;
    

}

- (IBAction)doneAction:(id)sender {
    
    if (![self.passWordField.text isEqualToString:self.secPWField.text]) {
        
        [self showHudWithString:@"密码不一致!"];
    }
    else{
        
       
        if ([self.type isEqualToString:@"1"]) {
            
            [[LoginService shareInstanced]registWithPhoneNumber:self.phone passWord:[self.passWordField.text md5] code:self.mycode];
            
            [self showHud];
            [LoginService shareInstanced].registSuccess = ^(id obj){
                
                [self hideHud];
               
                [self showHudWithString:@"注册成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            };
            
            [LoginService shareInstanced].registFailure = ^(id obj){
              
                [self hideHud];
                [self showHudWithString:obj];
                
            };
            
        }
        
        else{
            
            [[LoginService shareInstanced]changePwWithPhoneNumber:self.phone passWord:[self.passWordField.text md5] code:self.mycode];
            
            [self showHud];
            [LoginService shareInstanced].changePWSuccess = ^(id obj){
                
                [self hideHud];
                
                [self showHudWithString:@"修改密码成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

                
            };
            
            [LoginService shareInstanced].changePWFailure = ^(id obj){
                
                [self hideHud];
                [self showHudWithString:obj];
                
            };
        }
        
    }

}
@end

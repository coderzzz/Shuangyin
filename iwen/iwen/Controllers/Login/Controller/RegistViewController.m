//
//  RegistViewController.m
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RegistViewController.h"
#import "FixPassWordViewController.h"
#import "AgreeViewController.h"
#import "TimeCounter.h"
@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.view.backgroundColor        = BackgroundColor;
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius  = 5.0;
    self.nextBtn.backgroundColor     = BaseColor;
    
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius  = 5.0;
    [self.txtBtn setTitleColor:BaseColor forState:UIControlStateNormal];
    
    if ([self.type isEqualToString:@"3"]) {
        
        self.bumView.hidden = YES;
    }
    else{
        self.bumView.hidden = NO;
    }
}

- (IBAction)getWordAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (!self.phoneField.text.length>0) {
        
        return;
    }
    
    if ([self.type isEqualToString:@"3"]) {
        
          [ExamService shareInstenced].getPraRecordSuccess = ^(id obj){
            btn.enabled = NO;
            
            [self showHudWithString:obj];
            TimeCounter * counter = [[TimeCounter alloc] initWithCounter:60];
            counter.countBlock = ^(int count){
                if(count == 0)
                {
                    btn.enabled = YES;
                    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
                else
                {
                    [btn setTitle:[NSString stringWithFormat:@"(%i)重新获取",count] forState:UIControlStateNormal];
                }
            };
            
            [counter start];
        };
        
        [ExamService shareInstenced].getPraRecordFailure = ^(id obj){
            btn.enabled = YES;
            
            [self showHudWithString:obj];
        };
        
        [[ExamService shareInstenced]getPraRecordWithUid:self.phoneField.text];
    }
    else{
        
        [LoginService shareInstanced].getCodeSuccess = ^(id obj){
            btn.enabled = NO;
            
            [self showHudWithString:obj];
            TimeCounter * counter = [[TimeCounter alloc] initWithCounter:60];
            counter.countBlock = ^(int count){
                if(count == 0)
                {
                    btn.enabled = YES;
                    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
                else
                {
                    [btn setTitle:[NSString stringWithFormat:@"(%i)重新获取",count] forState:UIControlStateNormal];
                }
            };
            
            [counter start];
        };
        
        [LoginService shareInstanced].getCodeFailure = ^(id obj){
            btn.enabled = YES;
            
            [self showHudWithString:obj];
        };
        
        [[LoginService shareInstanced] getCodeWithPhoneNumber:self.phoneField.text type:self.type];
    }
 
}

- (IBAction)nextAction:(id)sender {
    
    
//    [self showHud];
//    [[LoginService shareInstanced]judgeCodeWithPhoneNumber:self.phoneField.text code:self.wordField.text];
//    
//    [LoginService shareInstanced].judgeCodeSuccess = ^(id obj){
//        
//        [self hideHud];
    
    if (self.wordField.text.length>0) {
        
     
        FixPassWordViewController *vc = [[FixPassWordViewController alloc]init];
        
        vc.title                       = @"确认密码";
        
        vc.phone    = self.phoneField.text;
        
        vc.mycode = self.wordField.text;
        
        vc.type = self.type;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
        
//    };
//    [LoginService shareInstanced].judgeCodeFailure = ^(id obj){
//        
//        [self hideHud];
//        
//        [self showHudWithString:obj];
//        
//    };
//    
}

- (IBAction)checkAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
}

- (IBAction)txtAction:(id)sender {
    
    AgreeViewController *vc = [[AgreeViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end

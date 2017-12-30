//
//  UpViewController.m
//  iwen
//
//  Created by Interest on 16/3/7.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "UpViewController.h"

@interface UpViewController ()

@end

@implementation UpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)done:(id)sender {
    
    if (!self.oldText.text.length>0) {
        
        [self showHudWithString:@"请输入旧密码"];
        return;
    }
    if (!self.nText.text.length>0) {
        
        [self showHudWithString:@"请输入新密码"];
        return;
    }
    
    if (!self.ntex2.text.length>0) {
        
        [self showHudWithString:@"请输入新密码"];
        return;
    }
    
    if (![self.nText.text isEqualToString:self.ntex2.text]) {
        
        [self showHudWithString:@"两次输入的新密码不一致"];
        return;
    }
    
    PersonModel *mo = [[LoginService shareInstanced]getUserModel];
    
    [[MineService shareInstanced]updateAddressWithDictionary:@{@"token":mo.use.ftoken,
                                                               @"oldPassword":[self.oldText.text md5],
                                                               @"newPassword":[self.ntex2.text md5]
 
                                                               }];
    [self showHud];
    [MineService shareInstanced].updateAddressSuccess = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:@"修改成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [MineService shareInstanced].updateAddressFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
}
@end

//
//  GuideViewController.m
//  
//
//  Created by Interest on 15/12/3.
//
//

#import "GuideViewController.h"
#import "CustomUserGuideScrollView.h"
@interface GuideViewController ()

@end

@implementation GuideViewController
{
    
    PersonModel *userModel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"提现账号";
    
    userModel = [[LoginService shareInstanced]getUserModel];
    
    if (!userModel.use.falipay.length>0) {
        
        
      
        
        
    }
    else{
        
        self.alitext.userInteractionEnabled = NO;
        self.alitext.text = userModel.use.falipay;
        
        self.nametext.userInteractionEnabled = NO;
        self.nametext.text = userModel.use.frealName;
        
        self.doneBtn.hidden = YES;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneAction:(id)sender {
    
    if (!self.alitext.text.length>0) {
        
        [self showHudWithString:@"请输入真实的支付宝手机账号"];
        
        return;
    }
    if (!self.nametext.text.length>0) {
        
        [self showHudWithString:@"请输入真实的姓名"];
        
        return;
    }
    
    if (![self.alitext.text isEqualToString:userModel.use.fphone]) {
               
        return;
    }
    
    
    [[MineService shareInstanced]addAddressWithId:userModel.use.ftoken address:self.alitext.text type:self.nametext.text];
    [self showHud];
    [MineService shareInstanced].addAddressSuccess = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:@"绑定成功"];
        
        self.alitext.userInteractionEnabled = NO;
        self.nametext.userInteractionEnabled = NO;
        self.doneBtn.hidden = YES;
        
        User *myUser = [[User MR_findAll]lastObject];
        
        
        myUser.falipay = self.alitext.text;
        myUser.frealName = self.nametext.text;
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
    };
    
    [MineService shareInstanced].addAddressFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
        
    };
    
    
}
@end

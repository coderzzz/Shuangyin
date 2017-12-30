//
//  LoginViewController.m
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "LoginService.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
#import "RightViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) UIBarButtonItem *backItem;

@end

@implementation LoginViewController

- (UIBarButtonItem *)backItem{
    
    if (_backItem == nil) {
        
        UIButton *backBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"通用-返回键1"]
                 forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(cancel)
          forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    
    return _backItem;
}

- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"登录";
    self.view.backgroundColor = BackgroundColor;
    self.logBtn.layer.masksToBounds = YES;
    self.logBtn.layer.cornerRadius  = 5.0;
    [self.logBtn setBackgroundColor:BaseColor];
    
    self.navigationItem.leftBarButtonItem = nil;
    
    if ([self.isTourist isEqualToString:@"1"]) {
        
        self.tourBtn.hidden = YES;
        
        self.navigationItem.leftBarButtonItem = self.backItem;
    }
    else{
        
        self.tourBtn.hidden = NO;

    }
}

- (IBAction)loginAction:(id)sender {
    
    [[LoginService shareInstanced]loginWithPhoneNumber:self.phoneField.text passWord:[self.passwordField.text md5]];
    [self showHud];
    
    [LoginService shareInstanced].loginSuccess = ^(id obj){
      
        [self hideHud];
        
        if ([self.isTourist isEqualToString:@"1"]) {
            
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            
          AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            dele.ddmenu = [[DDMenuController alloc]init];
            
            
            
            TabBarViewController *rootvc = [[TabBarViewController alloc] init];
            
            RightViewController *rig = [[RightViewController alloc]init];
            
            dele.ddmenu.rightViewController = rig;
            
            dele.ddmenu.rootViewController = rootvc;
            
            dele.window.rootViewController =  dele.ddmenu;
//            
//            PersonModel *user = [[LoginService shareInstanced]getUserModel];
//
//            [[LoginService shareInstanced]getScoringWithUid:user.uid];
            
//            TabBarViewController *rootvc = [[TabBarViewController alloc] init];
//            AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//            dele.window.rootViewController = rootvc;
//            
//            dele.ddmenu = [[DDMenuController alloc]init];
//
//            RightViewController *rig = [[RightViewController alloc]init];
//            dele.ddmenu.rightViewController = rig;
//            dele.ddmenu.rootViewController = rootvc;
            
        }
        
        
        

    };
    [LoginService shareInstanced].loginFailure = ^ (id obj){
      
        [self hideHud];
        [self showHudWithString:obj];
    };
}

- (IBAction)registAction:(id)sender {
    
    RegistViewController *revc = [[RegistViewController alloc]init];
    
    
    revc.type = @"1";
    
    revc.isTourist = self.isTourist;
    
    revc.title = @"注册";
    [self.navigationController pushViewController:revc animated:YES];
}

- (IBAction)vistAction:(id)sender {
    
    TabBarViewController *rootvc = [[TabBarViewController alloc] init];
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    dele.window.rootViewController = rootvc;
    
    
    PersonModel *model = [[PersonModel alloc]init];
    UserModel *user = [[UserModel alloc]init];
    user.ftoken = @"";
    model.use = user;
    [[LoginService shareInstanced]saveUserModelWithModel:model];
    
}

- (IBAction)changgePWAction:(id)sender {
    
    RegistViewController *revc = [[RegistViewController alloc]init];
    
    revc.type = @"3";
    
    revc.title = @"忘记密码";
    
     revc.isTourist = self.isTourist;
    
    [self.navigationController pushViewController:revc animated:YES];
    
}
@end

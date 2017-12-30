//
//  ADViewController.m
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ADViewController.h"
#import "ApplyViewController.h"
#import "SendAdvViewController.h"
@interface ADViewController ()<UIAlertViewDelegate>


@property (nonatomic, strong) PersonModel *userModel;

@end

@implementation ADViewController

- (PersonModel *)userModel{
    
    if (!_userModel) {
        
        _userModel = [[LoginService shareInstanced]getUserModel];
    }
    
    return _userModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发红包";
    [self setUpUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(log) name:@"LogOut" object:nil];
}

- (void)log{
    
    self.userModel = nil;
    [self setUpUI];
}
- (void)setUpUI{
    
    AdvModel *adv = self.userModel.adv;
    
    self.btn1.layer.masksToBounds =  YES;
    self.btn1.layer.cornerRadius = 3;
    self.btn2.layer.masksToBounds =  YES;
    self.btn2.layer.cornerRadius = 3;
    
    
    if (adv.flogo.length>0) {
        
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.lab2.hidden = YES;
        self.lab3.hidden = YES;
        self.lab1.text = adv.fcompanyName;
        [self.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ads_Pic_URL,adv.flogo]] placeholderImage:nil];
        
        
        
        
    }
    
    else{
        
        
        self.lab1.text = @"抱歉，您还不是商家";
        self.lab2.text = @"只能成为商家发广告哦";
        self.lab3.text = @"如果有问题请联系客服：13719231234";
        [self.btn1 setTitle:@"申请成为商家" forState:UIControlStateNormal];
        self.btn1.hidden = NO;
        self.btn2.hidden = YES;
        
        
        
    }
    
}

- (IBAction)btn1Action:(UIButton *)sender {
    
    AdvModel *adv = self.userModel.adv;
    
    if (adv.flogo.length>0) {
        
         if ([self.userModel.adv.fisCoupon boolValue]) {
        
            SendAdvViewController *vc = [[SendAdvViewController alloc]init];
            vc.type = @"1";
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
             
         }
         else{
             
            [self showMessage];
            
        }
    }
    
    else{
        
        ApplyViewController *vc = [[ApplyViewController alloc]init];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (IBAction)btn2Action:(UIButton *)sender {
    
    AdvModel *adv = self.userModel.adv;
    
    if (adv.flogo.length>0) {
        
        if ([self.userModel.adv.fisRed boolValue]) {
            
            SendAdvViewController *vc = [[SendAdvViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            vc.type = @"2";
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else{
            
            [self showMessage];
        }
        
    }
}

- (void)showMessage{
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否拨打电话联系获得权限？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [view show];
}

#pragma mark UIAlertViewDelegate
#warning phone
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
     
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://13719231234"]];
    }
}
@end

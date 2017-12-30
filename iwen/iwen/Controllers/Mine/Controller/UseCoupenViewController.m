//
//  UseCoupenViewController.m
//  iwen
//
//  Created by sam on 16/7/3.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "UseCoupenViewController.h"

@interface UseCoupenViewController ()<UIAlertViewDelegate>

@end

@implementation UseCoupenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adname.text = _model.advertName;
    CGFloat money = [_model.fmoney floatValue]/100;
    self.moneyLab.text = [NSString stringWithFormat:@"￥%.2f",money];
    self.nameLab.text =_model.adersName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_model.limitedTime integerValue]/1000];
    self.dateLab.text =[NSString stringWithFormat:@"截止日期：%@",[date formatDateString:nil]];

    self.title = @"优惠券使用";
//    [self.view insertSubview:self.topimgv atIndex:0];
   [self.con insertSubview:self.butImgv atIndex:0];
};


- (IBAction)useCoupenAction:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否使用该优惠券" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        PersonModel *per = [[LoginService shareInstanced]getUserModel];
        [self showHud];
        [[MineService shareInstanced]getFeedWithUid:per.use.ftoken content:self.model.fid];
        [MineService shareInstanced].getFeedSuccess = ^(id obj){
            [self hideHud];
            [self showHudWithString:@"使用成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        [MineService shareInstanced].getFeedFailure = ^(id obj){
          
            [self hideHud];
            [self showHudWithString:obj];
        };
    }
}

@end

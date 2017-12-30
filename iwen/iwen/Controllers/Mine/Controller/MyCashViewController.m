//
//  MyCashViewController.m
//  iwen
//
//  Created by Interest on 16/3/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyCashViewController.h"
#import "GuideViewController.h"
@interface MyCashViewController ()
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation MyCashViewController
{
    
    NSMutableArray *btnList;
    
    NSMutableArray *dataList;
    
    NSInteger seletIndex;
}

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现申请";
    
    dataList = [NSMutableArray array];
    
    btnList = [@[self.btn1,self.btn2,self.btn3,self.btn4,self.btn5,self.btn6]mutableCopy];
    
    for (UIButton *btn in btnList) {
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        btn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
    }
    
    self.toplab.text = [NSString stringWithFormat:@"最多可提现%.2f元",[self.userInfo.use.ftotal floatValue]/100];
    
    [self loadData];
}


- (IBAction)doneAction:(id)sender {
    
    if (seletIndex+1 && dataList.count == 6) {
        
        if (!self.userInfo.use.falipay.length>0) {
            [self showHudWithString:@"请填写支付宝账号！"];
            GuideViewController *vc = [[GuideViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        [[MineService shareInstanced]delAddressWithIds:@{@"token":self.userInfo.use.ftoken,
                                                         @"payCount":self.userInfo.use.falipay,
                                                         @"menoy":dataList[seletIndex][@"famount"]
          
                                                         
                                                         }];
        [self showHud];
        [MineService shareInstanced].delAddressSuccess = ^(id obj){
            
            [self hideHud];
            
            [self showHudWithString:@"提现申请已提交"];
            
            [self.navigationController popViewControllerAnimated:YES];
        };
        [MineService shareInstanced].delAddressFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
        };

    }
}

- (IBAction)cashAction:(UIButton *)sender {
    
    seletIndex = sender.tag;
    
    for (UIButton *btn in btnList) {
    
        btn.selected = NO;
    }
    
    sender.selected = YES;
}


- (void)loadData{
    
    
    [[MineService shareInstanced]getAgreement];
    
    [self showHud];
    [MineService shareInstanced].getAgreementSuccess = ^(id obj){
        
        [self hideHud];
        
        dataList = [obj mutableCopy];
        
        if (dataList.count == 6) {
            
            for (int a= 0; a<btnList.count; a++) {
                
                UIButton *btn = btnList[a];
                
                NSString *fee = [NSString stringWithFormat:@"%@",dataList[a][@"famount"]];
                
                NSString *price = [NSString stringWithFormat:@"%.2f元",[fee floatValue]/100];
                
                [btn setTitle:price forState:UIControlStateNormal];
                
                 [btn setTitle:price forState:UIControlStateSelected];
            }
            
            self.btn1.selected = YES;
        }
        
        
    };
    
    [MineService shareInstanced].getAgreementFailure = ^(id obj){
      
        [self hideHud];
        self.view.userInteractionEnabled = NO;
        [self showHudWithString:obj];
    };
}

@end

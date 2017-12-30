//
//  AccountViewController.m
//  iwen
//
//  Created by sam on 16/1/25.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation AccountViewController
{
    PersonModel *user;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家余额";
    user = [[LoginService shareInstanced]getUserModel];
    
    self.lab.text = [NSString stringWithFormat:@"%.2f元",[user.adv.ftotal floatValue]/100];
}

- (IBAction)pay:(id)sender {
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://13719231234"]];
}


@end

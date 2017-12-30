//
//  AboutViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AboutViewController.h"
#import "AgreeViewController.h"
#import "GViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                = @"关于我们";
    self.view.backgroundColor = BackgroundColor;

}

- (IBAction)sugAction:(id)sender {
    
    AgreeViewController *vc = [[AgreeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)appAction:(id)sender {
    
    GViewController *vc = [[GViewController alloc]init];
    vc.title = @"功能介绍";
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end

//
//  GViewController.m
//  iwen
//
//  Created by sam on 16/10/15.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "GViewController.h"
#import "CustomUserGuideScrollView.h"
@interface GViewController ()

@end

@implementation GViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CustomUserGuideScrollView * guideView = [[CustomUserGuideScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) imageNames:@[@"发ff",@"抢元宝11",@"抢红包11"] isShowPage:YES];
    
    guideView.fin = YES;
    
    [self.view addSubview:guideView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

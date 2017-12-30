//
//  BaseNavigationController.m
//  iwen
//
//  Created by Interest on 15/10/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
       
        
        [self.navigationBar setBarTintColor:BaseColor];
//        [self.navigationBar setTintColor:[UIColor blackColor]];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        
    }
    return self;
}


@end

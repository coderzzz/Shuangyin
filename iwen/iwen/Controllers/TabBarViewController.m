//
//  TabBarViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "TabBarViewController.h"
#import "MineViewController.h"
#import "ADViewController.h"
#import "ExamMainViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (id)init{
    
    self = [super init];
    
    if(self){
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
//        [self.tabBar setTintColor:DEFAULT_GREEN_COLOR];
//        [self.tabBar setBackgroundColor:DEFAULT_SEARCHBAR_COLOR];
        UITabBarItem *item1 = [[UITabBarItem alloc] init];
        item1.tag = 1;
       
        [item1 setTitle:@"看广告"];
        [item1 setImage:[UIImage imageNamed:@"首页2"]];
        [item1 setSelectedImage:[[UIImage imageNamed:@"首页1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:BaseColor}
                             forState:UIControlStateSelected];
       
        
        UITabBarItem *item2 = [[UITabBarItem alloc] init];
        item2.tag = 2;
        
     
        [item2 setTitle:@"发广告"];
        [item2 setImage:[UIImage imageNamed:@"发广告2"]];
        [item2 setSelectedImage:[[UIImage imageNamed:@"发广告1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:BaseColor}
                             forState:UIControlStateSelected];
       
        
        UITabBarItem *item3 = [[UITabBarItem alloc] init];
        item3.tag = 3;
      
        [item3 setTitle:@"个人中心"];
        [item3 setImage:[UIImage imageNamed:@"个人中心2"]];
        [item3 setSelectedImage:[[UIImage imageNamed:@"个人中心"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName:BaseColor}
                             forState:UIControlStateSelected];
        
        
        UITabBarItem *item4 = [[UITabBarItem alloc] init];
        
        item4.tag = 4;
        
     
        ExamMainViewController *homeController      = [[ExamMainViewController alloc] init];
        
        homeController.navigationItem.leftBarButtonItem= nil;
        
        homeController.tabBarItem                   = item1;
        BaseNavigationController *homeNavController = [[BaseNavigationController alloc] initWithRootViewController:homeController];

        
        ADViewController *sVC                = [[ADViewController alloc] init];
        sVC.tabBarItem                              = item2;
        
        sVC.navigationItem.leftBarButtonItem = nil;
        
        BaseNavigationController *sNavController    = [[BaseNavigationController alloc] initWithRootViewController:sVC];
        

        MineViewController *cController       = [[MineViewController alloc] init];
        cController.tabBarItem                      = item3;
        
        cController.navigationItem.leftBarButtonItem = nil;
        
        BaseNavigationController *cNavController    = [[BaseNavigationController alloc] initWithRootViewController:cController];
        
        
        self.viewControllers                        = [NSArray arrayWithObjects:homeNavController,sNavController,cNavController, nil];
        
        self.delegate = self;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(loginSessionFailure)
//                                                     name:LOGIN_SESSION_FAILURE_NEED_LOGIN
//                                                   object:nil];
        
        return  self;
    }
    return  nil;
}

- (void)loadView
{
    [super loadView];
    //修改高度
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tabBarHeight = 49;
    self.tabBar.frame = CGRectMake(0, height-tabBarHeight, width, tabBarHeight);
    self.tabBar.clipsToBounds = YES;
    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
//    transitionView.height = height-tabBarHeight;
    
    CGRect rect = transitionView.frame;
    
    rect.size.height =height-tabBarHeight;
    
    transitionView.frame = rect;
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationPortrait==interfaceOrientation);
}


- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}
@end

//
//  AppDelegate.h
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *player;

@property (strong, nonatomic) DDMenuController *ddmenu;

@end


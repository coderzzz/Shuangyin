//
//  FunctionMacros.h
//  ZhuZhu
//
//  Created by Carl on 15/2/2.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#define ApplicationDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate


#define ResURL(x) [NSString stringWithFormat:@"%@%@",Res_URL_Prefix,x]

#define isIOS7	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

//当前主题颜色
#define ThemeColor  [[ThemeManager shareInstance]getColorWithName:@"Color"]
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//多语言
#define Lan(str)         [[LanManager shareInstance]getlanWithName:str]

#define ONEPix  1/[[UIScreen mainScreen] scale]

#define LineColor  [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1]

#define IsNotFirstLaunched @"IsNotFirstLaunched"
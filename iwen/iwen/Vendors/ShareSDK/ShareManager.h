//
//  ShareManager.h
//  ShaiWaWa
//
//  Created by Carl_Huang on 14-7-25.
//  Copyright (c) 2014年 helloworld. All rights reserved.
//

#import <Foundation/Foundation.h>
//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//以下是ShareSDK必须添加的依赖库：
//1、libicucore.dylib
//2、libz.dylib
//3、libstdc++.dylib
//4、JavaScriptCore.framework

//＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//以下是腾讯SDK的依赖库：
//libsqlite3.dylib

//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//以下是新浪微博SDK的依赖库：
//ImageIO.framework
//libsqlite3.dylib
//AdSupport.framework

//人人SDK头文件
//#import <RennSDK/RennSDK.h>

//GooglePlus SDK头文件
//#import <GooglePlus/GooglePlus.h>
////GooglePlus SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
////以下是GooglePlus SDK的依赖库
////1、CoreMotion.framework
////2、CoreLocation.framework
////3、MediaPlayer.framework
////4、AssetsLibrary.framework
////5、AddressBook.framework
//
////Kakao SDK头文件
//#import <KakaoOpenSDK/KakaoOpenSDK.h>
//
////支付宝SDK
//#import "APOpenAPI.h"
//
//#import <MOBFoundation/MOBFoundation.h>


@interface ShareManager : NSObject

+ (instancetype)sharePlatform;
- (void)configShare;

- (void)share:(SSDKPlatformType)type title:(NSString *)title content:(NSString *)text url:(NSString *)url;

@end

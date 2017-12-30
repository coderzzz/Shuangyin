//
//  LoginService.h
//  iwen
//
//  Created by Interest on 15/10/22.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"
typedef void (^RegistSuccess) (id obj);
typedef void (^RegistFailure) (id obj);

typedef void (^LoginSuccess)  (id obj);
typedef void (^LoginFailure)  (id obj);

typedef void (^ChangePWSuccess) (id obj);
typedef void (^ChangePWFailure) (id obj);

typedef void (^GetCodeSuccess) (id obj);
typedef void (^GetCodeFailure) (id obj);

typedef void (^JudgeCodeSuccess) (id obj);
typedef void (^JudgeCodeFailure) (id obj);

typedef void (^GetAdvertisementSuccess) (id obj);
typedef void (^GetAdvertisementFailure) (id obj);

typedef void (^GetLanuchAdvertiseSuccess) (id obj);
typedef void (^GetLanuchAdvertiseFailure) (id obj);

typedef void (^GetUserDetailSuccess) (id obj);
typedef void (^GetUserDetailFailure) (id obj);

typedef void (^UpDateUserDetailSuccess) (id obj);
typedef void (^UpDateUserDetailFailure) (id obj);


typedef void (^UpDateAvatarSuccess) (id obj);
typedef void (^UpDateAvatarFailure) (id obj);


@interface LoginService : NSObject

@property (nonatomic, strong) UserModel *userModel;

@property (nonatomic, copy)RegistSuccess registSuccess;
@property (nonatomic, copy)RegistFailure registFailure;

@property (nonatomic, copy)LoginSuccess  loginSuccess;
@property (nonatomic, copy)LoginFailure  loginFailure;

@property (nonatomic, copy)ChangePWSuccess changePWSuccess;
@property (nonatomic, copy)ChangePWFailure changePWFailure;

@property (nonatomic, copy)GetCodeSuccess getCodeSuccess;
@property (nonatomic, copy)GetCodeFailure getCodeFailure;

@property (nonatomic, copy)JudgeCodeSuccess judgeCodeSuccess;
@property (nonatomic, copy)JudgeCodeFailure judgeCodeFailure;


@property (nonatomic, copy)GetAdvertisementSuccess getAdvertisementSuccess;
@property (nonatomic, copy)GetAdvertisementFailure getAdvertisementFailure;

@property (nonatomic, copy)GetLanuchAdvertiseSuccess getLanuchAdvertiseSuccess;
@property (nonatomic, copy)GetLanuchAdvertiseFailure getLanuchAdvertiseFailure;

@property (nonatomic, copy)GetUserDetailSuccess getUserDetailSuccess;
@property (nonatomic, copy)GetUserDetailFailure getUserDetailFailure;

@property (nonatomic, copy)UpDateUserDetailSuccess upDateUserDetailSuccess;
@property (nonatomic, copy)UpDateUserDetailFailure upDateUserDetailFailure;

@property (nonatomic, copy)UpDateAvatarSuccess upDateAvatarSuccess;
@property (nonatomic, copy)UpDateAvatarFailure upDateAvatarFailure;


+ (LoginService *)shareInstanced;


- (BOOL)isLogined;


- (void)saveUserModelWithModel:(PersonModel *)model;

- (PersonModel *)getUserModel;

- (void)loginout;

//类型(1--注册  2--修改密码  3--忘记密码)
- (void)getCodeWithPhoneNumber:(NSString *)phoneNumber type:(NSString *)type;

- (void)getScoringWithUid:(NSString *)uid;

- (void)judgeCodeWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code;


- (void)getUserDetailWithID:(NSString *)userId;

- (void)upDateUserWithDictionary:(NSDictionary *)dic;


- (void)getAdvertisementWithType:(NSString *)type;




- (void)registWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code;

- (void)loginWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord;

- (void)changePwWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code;



- (void)getLuanchAdvertisement;



- (void)saveAvatarWithUserId:(NSString *)uid avatarString:(NSString *)avatarString;


@end

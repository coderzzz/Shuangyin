//
//  LoginService.m
//  iwen
//
//  Created by Interest on 15/10/22.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LoginService.h"
#import "AdvertiseMentModel.h"
#import "LuanchAdvertisementModel.h"
#import <objc/runtime.h>
@implementation LoginService

+ (LoginService *)shareInstanced
{
    
    static LoginService * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    
    return this;

}

- (BOOL)isLogined{
    
    PersonModel *model = [self getUserModel];
    
    if (model.use.fphone.length>0) {
        
        return YES;
    }
    
    return NO;
}


- (void)saveUserModelWithModel:(PersonModel *)model{
    
    Adv *temp = [Adv MR_createEntity];
    
    if (model.adv) {
        
        temp.fid = model.adv.fid;
        temp.faddress = model.adv.faddress;
        temp.fwebsite = model.adv.fwebsite;
        temp.flogo = model.adv.flogo;
        temp.ftelPhone = model.adv.ftelPhone;
        temp.fstatus = model.adv.fstatus;
        temp.fcontacts = model.adv.fcontacts;
        temp.fcompanyName = model.adv.fcompanyName;
        temp.ftypeId = model.adv.ftypeId;
        temp.fupdatetime = model.adv.fupdatetime;
        temp.fcreatetime = model.adv.fcreatetime;
        temp.ftotal = model.adv.ftotal;
        temp.fuserId = model.adv.fuserId;
        temp.detial = model.adv.detial;
        temp.fisRed = model.adv.fisRed;
        temp.fisCoupon = model.adv.fisCoupon;

    }
    
    User *myUser = [User MR_createEntity];
    myUser.falipay = model.use.falipay;
    myUser.fcreateTime = model.use.fcreateTime;
    myUser.ffreezeMoney = model.use.ffreezeMoney;
    myUser.fheadImg = model.use.fheadImg;
    myUser.fid = model.use.fid;
    myUser.fpassword = model.use.fpassword;
    myUser.fphone = model.use.fphone;
    myUser.frealName = model.use.frealName;
    myUser.frecommendCode = model.use.frecommendCode;
    myUser.fscore = model.use.fscore;
    myUser.fsex = model.use.fsex;
    myUser.fstatus = model.use.fstatus;
    myUser.ftoken = model.use.ftoken;
    myUser.ftotal = model.use.ftotal;
    myUser.ftpassword = model.use.ftpassword;
    myUser.ftype = model.use.ftype;
    myUser.fage = model.use.fage;
    myUser.fsignature = model.use.fsignature;
    myUser.fnickName = model.use.fnickName;
    myUser.adv = temp;

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
//
//
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    NSArray *ary = [dic allKeys];
//
//    for (int a= 0; a<ary.count; a++) {
//        
//        if (dic[ary[a]] !=[NSNull null] && dic[ary[a]] !=nil) {
//            
//            [userDefaults setObject:dic[ary[a]] forKey:ary[a]];
//        }
//
//    }
//    [userDefaults synchronize];
//}

- (PersonModel *)getUserModel{
    
    PersonModel *personmodel = [[PersonModel alloc]init];
    
    User *myUser = [[User MR_findAll]lastObject];
    
    UserModel *model = [[UserModel alloc]init];
    model.falipay = myUser.falipay;
    model.fcreateTime = myUser.fcreateTime;
    model.ffreezeMoney = myUser.ffreezeMoney;
    model.fheadImg = myUser.fheadImg;
    model.fid = myUser.fid;
    model.fpassword = myUser.fpassword;
    model.fphone = myUser.fphone;
    model.frealName = myUser.frealName;
    model.frecommendCode = myUser.frecommendCode;
    model.fscore = myUser.fscore;
    model.fsex = myUser.fsex;
    model.fstatus = myUser.fstatus;
    model.ftoken = myUser.ftoken;
    model.ftotal = myUser.ftotal;
    model.ftpassword = myUser.ftpassword;
    model.ftype = myUser.ftype;
    model.fsignature = myUser.fsignature;
    model.fage = myUser.fage;
    model.fnickName = myUser.fnickName;
    
    AdvModel *adv = [[AdvModel alloc]init];
    adv.fid = myUser.adv.fid;
    adv.faddress = myUser.adv.faddress;
    adv.fwebsite = myUser.adv.fwebsite;
    adv.flogo = myUser.adv.flogo;
    adv.ftelPhone = myUser.adv.ftelPhone;
    adv.fstatus = myUser.adv.fstatus;
    adv.fcontacts = myUser.adv.fcontacts;
    adv.fcompanyName = myUser.adv.fcompanyName;
    adv.ftypeId = myUser.adv.ftypeId;
    adv.fupdatetime = myUser.adv.fupdatetime;
    adv.fcreatetime = myUser.adv.fcreatetime;
    adv.ftotal = myUser.adv.ftotal;
    adv.fuserId = myUser.adv.fuserId;
    adv.detial = myUser.adv.detial;
    adv.fisCoupon = myUser.adv.fisCoupon;
    adv.fisRed = myUser.adv.fisRed;
    
    personmodel.adv = adv;
    personmodel.use = model;
 
    
    return personmodel;
}

- (void)loginout{
    
    
//    NSArray *subs = [Subject MR_findByAttribute:@"name" withValue:[self getName] andOrderBy:@"disPlayOrder" ascending:YES];

     NSArray *subs = [Adv MR_findAll];
    if (subs.count >0) {
        
        for (Adv *sub in subs) {
            
            [sub MR_deleteEntity];
            
            [[sub managedObjectContext] MR_saveToPersistentStoreAndWait];
            
        }
        
        
    }

}

- (void)getCodeWithPhoneNumber:(NSString *)phoneNumber type:(NSString *)type{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"type":type};
    
    [[HttpService sharedInstance]getCode:dic completionBlock:^(id object) {
        
        if (object) {
            
  
                
                if (_getCodeSuccess) {
                    
                    _getCodeSuccess(object);
                }

            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCodeFailure) {
            
            _getCodeFailure (responseString);
        }
        
    }];
    
}

- (void)getScoringWithUid:(NSString *)uid{
    
    NSDictionary *dic = @{@"uid":uid};
    
    [[HttpService sharedInstance]Scoring:dic completionBlock:^(id object) {
        
        if (object) {
             
            
            
          
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
     
        
    }];
}

- (void)judgeCodeWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"validCode":code};
    
    [[HttpService sharedInstance]judeCode:dic completionBlock:^(id object) {
        
        if (object) {
            
    
                
            if (_judgeCodeSuccess) {
                    
                    
                _judgeCodeSuccess(object);
             
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_judgeCodeFailure){
            
            _judgeCodeFailure(responseString);
        }
        
    }];
    
}


- (void)registWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
    
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord,@"code":code};
    
    [[HttpService sharedInstance]regist:dic completionBlock:^(id object) {
        
        if (object) {
         
//            NSDictionary *dic = (NSDictionary *)object;
//            
//            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
//            [self saveUserModelWithDictionary:dic];
//            if (model) {
            
                if (_registSuccess) {
                    
                    _registSuccess(object);
                }
//
//            }

        }
                                              
      } failureBlock:^(NSError *error, NSString *responseString) {
          
          if (_registFailure) {
              
              _registFailure (responseString);
          }
                                              
       }];

}


- (void)loginWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord};
    
    [[HttpService sharedInstance]login:dic completionBlock:^(id object) {
        
        if (object) {
            

            
            NSDictionary *dic = (NSDictionary *)object;
            
            PersonModel *model = [[PersonModel alloc]initWithDictionary:dic error:nil];
            
            
            
            if (model) {
                
                [self saveUserModelWithModel:model];
                
                if (_loginSuccess) {
                    
                    _loginSuccess(model);
                }
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_loginFailure) {
            
            _loginFailure (responseString);
        }
        
    }];

    
}

- (void)changePwWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
    
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord,@"code":code};
    
    [[HttpService sharedInstance]changePassWord:dic completionBlock:^(id object) {
        
        if (object) {
            
//            NSDictionary *dic = (NSDictionary *)object;
            
//            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
            
//            [self saveUserModelWithDictionary:dic];
//            
//            if (model) {
            
                if (_changePWSuccess) {
                    
                    _changePWSuccess(object);
                }
//                
//            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_changePWFailure) {
            
            _changePWFailure (responseString);
        }
        
    }];

}

- (void)getAdvertisementWithType:(NSString *)type{
    
    
    [[HttpService sharedInstance]getAd:nil completionBlock:^(id object) {
        
        if (object) {
            

            if (_getAdvertisementSuccess) {
                
                _getAdvertisementSuccess (object);
            }
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAdvertisementFailure) {
            
            _getAdvertisementFailure(responseString);
        }
        
    }];
    
    
}

- (void)getLuanchAdvertisement{
    
    [[HttpService sharedInstance]getLanuchAd:nil completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"ad"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                LuanchAdvertisementModel *model = [[LuanchAdvertisementModel alloc]initWithDictionary:dic error:nil];
                
                if (model) {
                    
                    [dataArray addObject:model];
                }
            }
            
            if (_getLanuchAdvertiseSuccess) {
                
                _getLanuchAdvertiseSuccess (dataArray);
            }
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getLanuchAdvertiseFailure) {
            
            _getLanuchAdvertiseFailure(responseString);
        }
        
    }];

}

- (void)getUserDetailWithID:(NSString *)userId{
    
    NSDictionary *dic = @{@"token":userId};
    
    [[HttpService sharedInstance]getUserDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSDictionary *dic = object;
            
            PersonModel *model = [[PersonModel alloc]initWithDictionary:dic error:nil];
            
            
            if (model) {
                
                [[LoginService shareInstanced]saveUserModelWithModel:model];
                
                if (_getUserDetailSuccess) {
                    
                    _getUserDetailSuccess(model);
                }
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getUserDetailFailure) {
            
            _getUserDetailFailure(responseString);
        }
        
    }];

}

- (void)upDateUserWithDictionary:(NSDictionary *)dic{
    
    
    [[HttpService sharedInstance]updUserDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            if (_upDateUserDetailSuccess) {
                
                _upDateUserDetailSuccess(object);
            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upDateUserDetailFailure) {
            
            _upDateUserDetailFailure(responseString);
        }
        
    }];

}

- (void)saveAvatarWithUserId:(NSString *)uid avatarString:(NSString *)avatarString{
    //ad(广告) user(用户) aders(广告商)
    
    NSDictionary *dic = @{@"savePath":uid,@"imgStr":avatarString};
    
    [[HttpService sharedInstance]updUserAvatar:dic completionBlock:^(id object) {
        
        if (object) {
            
            if (_upDateAvatarSuccess) {
                
                _upDateAvatarSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upDateAvatarFailure) {
            
            _upDateAvatarFailure(responseString);
        }
        
    }];
    
    
    
}

@end

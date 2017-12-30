//
//  MineService.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetMyNewsSuccess) (id obj);
typedef void (^GetMyNewsFailure) (id obj);

typedef void (^DelMyNewsSuccess) (id obj);
typedef void (^DelMyNewsFailure) (id obj);

typedef void (^AddAddressSuccess) (id obj);
typedef void (^AddAddressFailure) (id obj);

typedef void (^UpdateAddressSuccess) (id obj);
typedef void (^UpdateAddressFailure) (id obj);

typedef void (^GetAllAddressSuccess) (id obj);
typedef void (^GetAllAddressFailure) (id obj);

typedef void (^DelAddressSuccess) (id obj);
typedef void (^DelAddressFailure) (id obj);

typedef void (^GetCouponSuccess) (id obj);
typedef void (^GetCouponFailure) (id obj);


typedef void (^GetAgreementSuccess) (id obj);
typedef void (^GetAgreementFailure) (id obj);

typedef void (^GetFeedBackSuccess) (id obj);
typedef void (^GetFeedBackFailure) (id obj);

typedef void (^GetFeedSuccess) (id obj);
typedef void (^GetFeedFailure) (id obj);


@interface MineService : NSObject

@property (nonatomic, copy) GetMyNewsSuccess getMyNewsSuccess;
@property (nonatomic, copy) GetMyNewsFailure getMyNewsFailure;
@property (nonatomic, assign) NSInteger      pageIndex;
@property (nonatomic, strong) NSMutableArray *data;



@property (nonatomic, copy) DelMyNewsSuccess delMyNewsSuccess;
@property (nonatomic, copy) DelMyNewsFailure delMyNewsFailure;

@property (nonatomic, copy) AddAddressSuccess addAddressSuccess;
@property (nonatomic, copy) AddAddressFailure addAddressFailure;

@property (nonatomic, copy) UpdateAddressSuccess updateAddressSuccess;
@property (nonatomic, copy) UpdateAddressFailure updateAddressFailure;

@property (nonatomic, copy) GetAllAddressSuccess getAllAddressSuccess;
@property (nonatomic, copy) GetAllAddressFailure getAllAddressFailure;

@property (nonatomic, copy) DelAddressSuccess delAddressSuccess;
@property (nonatomic, copy) DelAddressFailure delAddressFailure;


@property (nonatomic, copy) GetCouponSuccess getCouponSuccess;
@property (nonatomic, copy) GetCouponFailure getCouponFailure;
@property (nonatomic, assign) NSInteger      couPonpageIndex;
@property (nonatomic, strong) NSMutableArray *couPonpagedata;



@property (nonatomic, copy) GetAgreementSuccess getAgreementSuccess;
@property (nonatomic, copy) GetAgreementFailure getAgreementFailure;

@property (nonatomic, copy) GetFeedBackSuccess getFeedBackSuccess;
@property (nonatomic, copy) GetFeedBackFailure getFeedBackFailure;

@property (nonatomic, copy) GetFeedSuccess getFeedSuccess;
@property (nonatomic, copy) GetFeedFailure getFeedFailure;

+ (MineService *)shareInstanced;

//绑定支付宝账号
- (void)addAddressWithId:(NSString *)uid address:(NSString *)address type:(NSString *)type;
//更新密码
- (void)updateAddressWithDictionary:(NSDictionary *)dic;

//修改用户信息
- (void)getAllAddressWithUid:(NSDictionary *)dic;
//获取提现记录
- (void)delNewWithIds:(NSString *)ids;

//获取第一次我的红包记录
- (void)getMyFirstNewsWithUid:(NSString *)uid;
//获取更多我的红包
- (void)getMyMoreNewsWithUid:(NSString *)uid;

//获取第一次我的金币记录
- (void)getFirstCoupenWithUid:(NSString *)uid;
//获取更多我的金币记录
- (void)getMoreCoupenWithUid:(NSString *)uid;

//获取提现金额接口
- (void)getAgreement;
//提现
- (void)delAddressWithIds:(NSDictionary *)dic;










- (void)getFeedBackWithUid:(NSString *)uid content:(NSString *)content;

- (void)getFeedWithUid:(NSString *)uid content:(NSString *)content;



@end

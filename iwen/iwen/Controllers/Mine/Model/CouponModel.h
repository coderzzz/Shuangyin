//
//  CouponModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface CouponModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * uid;

@property (nonatomic, strong) NSString <Optional> * conpon_id;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * end_time;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * send_money;

@end

//
//  AllAddressModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface AllAddressModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * uid;

@property (nonatomic, strong) NSString <Optional> * address;

@property (nonatomic, strong) NSString <Optional> * type;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * receiver_man;

@property (nonatomic, strong) NSString <Optional> * phone;

@property (nonatomic, strong) NSString <Optional> * region;

@property (nonatomic, strong) NSString <Optional> * doorplate;

@property (nonatomic, strong) NSString <Optional> * postalcode;

@end

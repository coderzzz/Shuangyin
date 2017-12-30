//
//  LuanchAdvertisementModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface LuanchAdvertisementModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * ad_name;

@property (nonatomic, strong) NSString <Optional> * ad_url;

@property (nonatomic, strong) NSString <Optional> * platform;

@property (nonatomic, strong) NSString <Optional> * remark;

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * status;


@end

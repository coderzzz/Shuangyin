//
//  AdvertiseMentModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface AdvertiseMentModel : JSONModel


@property (nonatomic, strong) NSString <Optional> * ad_image;

@property (nonatomic, strong) NSString <Optional> * ad_name;

@property (nonatomic, strong) NSString <Optional> * ad_type;

@property (nonatomic, strong) NSString <Optional> * ad_url;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * upd_time;


@end

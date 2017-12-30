//
//  CommonModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface CommonModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * news_id;

@property (nonatomic, strong) NSString <Optional> * uid;

@property (nonatomic, strong) NSString <Optional> * comment;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * username;

@property (nonatomic, strong) NSString <Optional> * avatar;

@end

//
//  CourseTypeModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface CourseTypeModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * fid;

@property (nonatomic, strong) NSString <Optional> * class_name;

@property (nonatomic, strong) NSString <Optional> * class_image;

@property (nonatomic, strong) NSString <Optional> * class_weight;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * stars;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * upd_time;

@property (nonatomic, strong) NSString <Optional> * remark;

@end

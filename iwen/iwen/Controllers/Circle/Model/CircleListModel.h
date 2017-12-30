//
//  CircleListModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"
#import "BlogData.h"
@interface CircleListModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * class_name;

@property (nonatomic, strong) NSString <Optional> * class_image;

@property (nonatomic, strong) NSString <Optional> * read_times_today;

@property (nonatomic, strong) NSString <Optional> * class_sub_class;


@property (nonatomic, strong) NSString <Optional> * fid;

@property (nonatomic, strong) NSString <Optional> * flevle;

@property (nonatomic, strong) NSString <Optional> * fname;

@property (nonatomic, strong) NSString <Optional> * fpid;

@property (nonatomic, strong) NSArray<BlogData,Optional>*child;
@end

//
//  LikeModel.h
//  iwen
//
//  Created by Interest on 15/11/6.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

@protocol LikeModel @end

#import "JSONModel.h"

@interface LikeModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * course_class_id;

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * title;

@end

//
//  LookLikeModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"
#import "LikeModel.h"
@interface LookLikeModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * class_image;

@property (nonatomic, strong) NSString <Optional> * class_name;

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSMutableArray <Optional,LikeModel> *like;

@end

//
//  ForumModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface ForumModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * news_title;

@property (nonatomic, strong) NSString <Optional> * news_stitle;

@property (nonatomic, strong) NSString <Optional> * username;

@property (nonatomic, strong) NSString <Optional> * avatar;

@property (nonatomic, strong) NSString <Optional> * img_url;


@end

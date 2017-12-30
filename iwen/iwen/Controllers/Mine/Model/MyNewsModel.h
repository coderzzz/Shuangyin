//
//  MyNewsModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface MyNewsModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * class_id;

@property (nonatomic, strong) NSString <Optional> * big_class_id;

@property (nonatomic, strong) NSString <Optional> * news_typ;

@property (nonatomic, strong) NSString <Optional> * news_title;

@property (nonatomic, strong) NSString <Optional> * news_thumb;

@property (nonatomic, strong) NSString <Optional> * news_stitle;

@property (nonatomic, strong) NSString <Optional> * news_author;

@property (nonatomic, strong) NSString <Optional> * news_souce;

@property (nonatomic, strong) NSString <Optional> * news_keywords;

@property (nonatomic, strong) NSString <Optional> * news_upcontent;

@property (nonatomic, strong) NSString <Optional> * content;

@property (nonatomic, strong) NSString <Optional> * metakeywords;

@property (nonatomic, strong) NSString <Optional> * avatar;

@end

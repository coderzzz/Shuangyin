//
//  BlogData.h
//  iwen
//
//  Created by Interest on 15/10/28.
//  Copyright (c) 2015年 Interest. All rights reserved.
//


#import <Foundation/Foundation.h>
@protocol BlogData @end
@interface BlogData : JSONModel

@property (nonatomic, strong) NSString <Optional>*title;

@property (nonatomic, strong) NSString <Optional>*content;

@property (nonatomic, strong) NSString <Optional>*base64Str;


@property (nonatomic, strong) NSString <Optional> * fid;

@property (nonatomic, strong) NSString <Optional> * flevle;

@property (nonatomic, strong) NSString <Optional> * fname;

@property (nonatomic, strong) NSString <Optional> * fpid;
@property (nonatomic, strong) NSString <Optional> * child;


@end

//
//  UserListModel.h
//  iwen
//
//  Created by sam on 16/8/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserListModel : JSONModel


@property (nonatomic, strong) NSString <Optional> * fage;

@property (nonatomic, strong) NSString <Optional> * fheadImg;

@property (nonatomic, strong) NSString <Optional> * fid;

@property (nonatomic, strong) NSString <Optional> * frealName;

@property (nonatomic, strong) NSString <Optional> * fscore;

@property (nonatomic, strong) NSString <Optional> * fsex;

@property (nonatomic, strong) NSString <Optional> * fsignature;
@property (nonatomic, strong) NSString <Optional> * fnickName;


@end

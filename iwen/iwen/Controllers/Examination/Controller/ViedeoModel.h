//
//  ViedeoModel.h
//  iwen
//
//  Created by sam on 2017/2/26.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ViedeoModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * fcreateTime;
@property (nonatomic, strong) NSString <Optional> * fheadImg;

@property (nonatomic, strong) NSString <Optional> * fid;

@property (nonatomic, strong) NSString <Optional> * fnickName;

@property (nonatomic, strong) NSString <Optional> * fphone;

@property (nonatomic, strong) NSString <Optional> * frealName;

@property (nonatomic, strong) NSString <Optional> * fsex;

@property (nonatomic, strong) NSString <Optional> * fsignature;

@property (nonatomic, strong) NSString <Optional> * fstatus;

@property (nonatomic, strong) NSString <Optional> * fvideoLikeCount;

@property (nonatomic, strong) NSString <Optional> * fvideoUrl;

@property (nonatomic, strong) NSString <Optional> * fvideocContent;
@property (nonatomic, strong) NSString <Optional> * fvideoUpdateTime;

@end

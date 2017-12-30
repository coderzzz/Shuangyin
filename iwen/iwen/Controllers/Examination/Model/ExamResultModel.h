//
//  ExamResultModel.h
//  iwen
//
//  Created by Interest on 15/11/3.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface ExamResultModel : JSONModel

@property (nonatomic, strong) NSArray  <Optional> * answer_status;

@property (nonatomic, strong) NSString <Optional> * score;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * txt;

@property (nonatomic, strong) NSString <Optional> * type;

@property (nonatomic, strong) NSString <Optional> * use_time;



@property (nonatomic, strong) NSString  <Optional> * area;

@property (nonatomic, strong) NSString <Optional> * endPrice;

@property (nonatomic, strong) NSString <Optional> * fcity;

@property (nonatomic, strong) NSString <Optional> * fclickCount;

@property (nonatomic, strong) NSString <Optional> * fcreateTime;

@property (nonatomic, strong) NSString <Optional> * fid;
@property (nonatomic, strong) NSString <Optional> * fdetail;

@property (nonatomic, strong) NSString <Optional> * fcoordinate;

@property (nonatomic, strong) NSString <Optional> * foldPrice;

@property (nonatomic, strong) NSString <Optional> * fprice;

@property (nonatomic, strong) NSString <Optional> * fimgs;

@property (nonatomic,strong) NSString <Optional> * fphone;

@property (nonatomic,strong) NSString <Optional> * address;
@property (nonatomic,strong) NSString <Optional>* fname;

@property (nonatomic,strong) NSString <Optional> * logo;



@end

//
//  ExamGradeModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface ExamGradeModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * price;

@property (nonatomic, strong) NSString <Optional> * alipay_private_key;

@property (nonatomic, strong) NSString <Optional> * alipay_public_key;

@property (nonatomic, strong) NSString <Optional> * exam_price;

@property (nonatomic, strong) NSString <Optional> * exam_score;

@property (nonatomic, strong) NSString <Optional> * exam_time;

@property (nonatomic, strong) NSString <Optional> * notify_url;

@property (nonatomic, strong) NSString <Optional> * out_trade_no;

@property (nonatomic, strong) NSString <Optional> * partner;

@property (nonatomic, strong) NSString <Optional> * seller_email;

@property (nonatomic, strong) NSString <Optional> * subject;

@property (nonatomic, strong) NSString <Optional> * body;
@property (nonatomic, strong) NSString <Optional> * total_fee;
@end

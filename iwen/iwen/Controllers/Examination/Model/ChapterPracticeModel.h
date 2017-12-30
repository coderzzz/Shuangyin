//
//  ChapterPracticeModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"
#import "OptionModel.h"

@interface ChapterPracticeModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * like_status;

@property (nonatomic, strong) NSString <Optional> * course_class_id;

@property (nonatomic, strong) NSString <Optional> * title;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * weight;

@property (nonatomic, strong) NSString <Optional> * ismulti;

@property (nonatomic, strong) NSString <Optional> * remark;

@property (nonatomic, strong) NSString <Optional> * analysis;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) NSString <Optional> * upd_time;

@property (nonatomic, strong) NSMutableArray <Optional,OptionModel> * option;

/************************************      *************************************************/

//@property (nonatomic,strong) NSMutableArray <Optional>*selectSource;

@property (nonatomic, strong) NSString <Optional> * isFinsh;

@property (nonatomic, strong) NSString <Optional> * examId;

@property (nonatomic, strong) NSString <Optional> * answerString;
/////////////////////















@end

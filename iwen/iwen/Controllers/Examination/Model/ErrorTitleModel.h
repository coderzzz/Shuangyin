//
//  ErrorTitleModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"
#import "ChapterPracticeModel.h"
@interface ErrorTitleModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * exam_id;

@property (nonatomic, strong) NSString <Optional> * tid;

@property (nonatomic, strong) NSString <Optional> * answer;

@property (nonatomic, strong) NSString <Optional> * is_correct;

@property (nonatomic, strong) NSString <Optional> * add_time;

@property (nonatomic, strong) ChapterPracticeModel <Optional> * topic;

@end

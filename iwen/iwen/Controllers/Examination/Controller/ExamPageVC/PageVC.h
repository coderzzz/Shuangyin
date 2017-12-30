//
//  PageVC.h
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//



#import "BaseViewController.h"
#import "DDMenuController.h"


typedef NS_ENUM(NSInteger, ExamType) {
    
    FormalExam,
    
    SimulationExam,
    
    ChapterExam,
    
    OrderExam,
    
    RandomExam,
    
    ErrorExam,
    
    LikeExam
    
    
};

@interface PageVC : BaseViewController

@property (nonatomic,strong) NSMutableArray  *dataSource;

@property (nonatomic,assign) ExamType        examType;

@property (nonatomic,strong) NSString        *chapterId;

@property (nonatomic,strong) NSMutableArray  *chapterArray;

@property (nonatomic,strong) NSString        *errorTid;

@property (nonatomic,strong) NSString        *likeCid;

@property (nonatomic,assign) NSUInteger       likeIndex;

@property (nonatomic,assign) NSString       *tourist;



@end

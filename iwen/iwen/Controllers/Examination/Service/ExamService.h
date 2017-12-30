//
//  ExamService.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetCourseTypeSuccess) (id obj);
typedef void (^GetCourseTypeFailure) (id obj);

typedef void (^GetGradeTypeSuccess) (id obj);
typedef void (^GetGradeTypeFailure) (id obj);

typedef void (^GetPayInfoSuccess) (id obj);
typedef void (^GetPayInfoFailure) (id obj);

typedef void (^GetWxPayInfoSuccess) (id obj);
typedef void (^GetWxPayInfoFailure) (id obj);

typedef void (^GetChapterPracticeSuccess) (id obj);
typedef void (^GetChapterPracticeFailure) (id obj);

typedef void (^GetPracticeSuccess) (id obj);
typedef void (^GetPracticeFailure) (id obj);

typedef void (^GetExamGradeSuccess) (id obj);
typedef void (^GetExamGradeFailure) (id obj);

typedef void (^GetAllowExamSuccess) (id obj);
typedef void (^GetAllowExamFailure) (id obj);

typedef void (^GetExamSuccess) (id obj);
typedef void (^GetExamFailure) (id obj);

typedef void (^GetMnExamSuccess) (id obj);
typedef void (^GetMnExamFailure) (id obj);

typedef void (^SavePracticeSuccess) (id obj);
typedef void (^SavePracticeFailure) (id obj);

typedef void (^UpLoadExamSuccess) (id obj);
typedef void (^UpLoadExamFailure) (id obj);

typedef void (^UpLoadMnExamSuccess) (id obj);
typedef void (^UpLoadMnExamFailure) (id obj);

typedef void (^GetTitleTypeSuccess) (id obj);
typedef void (^GetTitleTypeFailure) (id obj);


typedef void (^CancelExamSuccess) (id obj);
typedef void (^CancelExamFailure) (id obj);


typedef void (^GetExamRecordSuccess) (id obj);
typedef void (^GetExamRecordFailure) (id obj);

typedef void (^GetPraRecordSuccess) (id obj);
typedef void (^GetPraRecordFailure) (id obj);




typedef void (^AddExamLikeSuccess) (id obj);
typedef void (^AddExamLikeFailure) (id obj);

typedef void (^GetAllLikeSuccess) (id obj);
typedef void (^GetAllLikeFailure) (id obj);

typedef void (^GetExamLikeSuccess) (id obj);
typedef void (^GetExamLikeFailure) (id obj);


typedef void (^DelErrorSuccess) (id obj);
typedef void (^DelErrorFailure) (id obj);

typedef void (^GetErrorTitleSuccess) (id obj);
typedef void (^GetErrorTitleFailure) (id obj);


typedef void (^GetRankingSuccess) (id obj,NSString *flag,NSString *type);
typedef void (^GetRankingFailure) (id obj,NSString *type);

@interface ExamService : NSObject

@property (nonatomic, copy) GetCourseTypeSuccess getCourseTypeSuccess;
@property (nonatomic, copy) GetCourseTypeFailure getCourseTypeFailure;

@property (nonatomic, copy) GetGradeTypeSuccess getGradeTypeSuccess;
@property (nonatomic, copy) GetGradeTypeFailure getGradeTypeFailure;

@property (nonatomic, copy) GetPayInfoSuccess getPayInfoSuccess;
@property (nonatomic, copy) GetPayInfoFailure getPayInfoFailure;

@property (nonatomic, copy) GetWxPayInfoSuccess getWxPayInfoSuccess;
@property (nonatomic, copy) GetWxPayInfoFailure getWxPayInfoFailure;

@property (nonatomic, copy) GetChapterPracticeSuccess getChapterPracticeSuccess;
@property (nonatomic, copy) GetChapterPracticeFailure getChapterPracticeFailure;

@property (nonatomic, copy) GetPracticeSuccess getPracticeSuccess;
@property (nonatomic, copy) GetPracticeFailure getPracticeFailure;

@property (nonatomic, copy) GetExamGradeSuccess getExamGradeSuccess;
@property (nonatomic, copy) GetExamGradeFailure getExamGradeFailure;

@property (nonatomic, copy) GetAllowExamSuccess getAllowExamSuccess;
@property (nonatomic, copy) GetAllowExamFailure getAllowExamFailure;

@property (nonatomic, copy) GetExamSuccess getExamSuccess;
@property (nonatomic, copy) GetExamFailure getExamFailure;

@property (nonatomic, copy) GetMnExamSuccess getMnExamSuccess;
@property (nonatomic, copy) GetMnExamFailure getMnExamFailure;

@property (nonatomic, copy) SavePracticeSuccess savePracticeSuccess;
@property (nonatomic, copy) SavePracticeFailure savePracticeFailure;

@property (nonatomic, copy) UpLoadExamSuccess upLoadExamSuccess;
@property (nonatomic, copy) UpLoadExamFailure upLoadExamFailure;

@property (nonatomic, copy) UpLoadMnExamSuccess upLoadMnExamSuccess;
@property (nonatomic, copy) UpLoadMnExamFailure upLoadMnExamFailure;

@property (nonatomic, copy) GetTitleTypeSuccess getTitleTypeSuccess;
@property (nonatomic, copy) GetTitleTypeFailure getTitleTypeFailure;

@property (nonatomic, copy) CancelExamSuccess cancelExamSuccess;
@property (nonatomic, copy) CancelExamFailure cancelExamFailure;

@property (nonatomic, copy) GetExamRecordSuccess getExamRecordSuccess;
@property (nonatomic, copy) GetExamRecordFailure getExamRecordFailure;


@property (nonatomic, copy) GetPraRecordSuccess getPraRecordSuccess;
@property (nonatomic, copy) GetPraRecordFailure getPraRecordFailure;


@property (nonatomic, copy) AddExamLikeSuccess addExamLikeSuccess;
@property (nonatomic, copy) AddExamLikeFailure addExamLikeFailure;

@property (nonatomic, copy) GetAllLikeSuccess getAllLikeSuccess;
@property (nonatomic, copy) GetAllLikeFailure getAllLikeFailure;


@property (nonatomic, copy) GetExamLikeSuccess getExamLikeSuccess;
@property (nonatomic, copy) GetExamLikeFailure getExamLikeFailure;

@property (nonatomic, copy) GetErrorTitleSuccess getErrorTitleSuccess;
@property (nonatomic, copy) GetErrorTitleFailure getErrorTitleFailure;

@property (nonatomic, copy) GetRankingSuccess getRankingSuccess;
@property (nonatomic, copy) GetRankingFailure getRankingFailure;
@property (nonatomic, assign) NSInteger      rangkPageIndex;
@property (nonatomic, strong) NSMutableArray *rankArray;


@property (nonatomic, copy) DelErrorSuccess delErrorSuccess;
@property (nonatomic, copy) DelErrorFailure delErrorFailure;

+ (ExamService *)shareInstenced;

//申请成为广告商
- (void)getChapterPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid;

//获取行业类型
- (void)getCourseType;

//获取地区
- (void)getGradeTypeWithUid:(NSString *)uid;

//发广告
- (void)getPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid;

//发红包
- (void)getGetExamGradeWithType:(NSString *)typeId uid:(NSString *)uid;

//获取广告详情
- (void)getAllowExamWithUid:(NSString *)uid;



//抢红包
- (void)getPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id type:(NSString *)ty city:(NSString *)city;

//删除旗袍说
- (void)delErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid;

//点赞
- (void)addExamLikeWithUid:(NSString *)uid tid:(NSString *)tid type:(NSString *)type;

//发布旗袍说
- (void)upLoadExamWithExamId:(NSString *)string topic_answer:(NSString *)answers time:(NSString *)time video:(NSString *)video;

//修改密码
- (void)getPraRecordWithUid:(NSString *)uid;

- (void)getTitleTypeWithPageIndex:(NSString *)page;


- (void)getExamRecordWithUid:(NSDictionary *)dic type:(NSString *)typ;
//定位获取
- (void)cancleExamWithUid:(NSString *)uid examId:(NSString *)examId;

//普通广告列表
- (void)getFirstRankingWithUid:(NSString *)uid timeType:(NSString *)timeType province:(NSString *)province type:(NSString *)tpe;

- (void)getMoreRankingWithUid:(NSString *)uid timeType:(NSString *)timeType province:(NSString *)province type:(NSString *)tpe;


- (void)getExamWithUid:(NSString *)uid type:(NSString *)type;
- (void)getMnExamWithUid:(NSString *)uid type:(NSString *)type;














- (void)getWxPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id;





- (void)getExamLikeWithUid:(NSString *)uid cid:(NSDictionary *)cid;

- (void)savePracticeWithJsonString:(NSString *)jsonStr time:(NSString *)time;

- (void)upLoadMnExamWithExamId:(NSString *)string topic_answer:(NSString *)answers time:(NSString *)time grade:(NSString *)grade;

















- (void)getErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid;



//用户uid(必填)  页数(选填) 显示时间(1-今天(默认) 2--本周 3--本月  4--全部) 省份(选填,默认全国,其他则传省份名称)







@end

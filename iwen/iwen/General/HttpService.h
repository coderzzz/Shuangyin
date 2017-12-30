//
//  HttpService.h
//  iStudy
//
//  Created by GZInterest on 14/11/22.
//  Copyright (c) 2014年 helloworld. All rights reserved.
//

#import "AFHttp.h"

@interface HttpService : AFHttp

+ (HttpService *)sharedInstance;


/**
 @desc 注册
 */
//TODO:注册
- (void)regist:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

/**
 @desc 获取验证码
 */
//TODO:获取验证码
- (void)getCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

- (void)Scoring:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

/**
 @desc 判断验证吗
 */
//TODO:判断验证吗
- (void)judeCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;


/**
 @desc 意见反馈
 */
//TODO:意见反馈
- (void)feedBack:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;


- (void)feed:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

- (void)upload:(NSDictionary *)parms fileurl:(NSURL *)url  name:(NSString *)name completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

/**
 @desc 登陆
 */
//TODO:登陆
- (void)login:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

/**
 @desc 修改密码
 */
//TODO:修改密码
- (void)changePassWord:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure;

/**
 @desc 获取广告
 */
//TODO:获取广告

- (void)getAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

- (void)getVideo:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc 获取启动页
 */
//TODO:获取启动页

- (void)getLanuchAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc 获取用户详情
 */
//TODO:获取用户详情

- (void)getUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc 更新用户信息
 */
//TODO:更新用户信息

- (void)updUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc 更新用户头像
 */
//TODO:更新用户头像

- (void)updUserAvatar:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc  查看帖子
 */
//TODO: 查看帖子

- (void)getNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc  删除帖子
 */
//TODO: 删除帖子

- (void)delNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc  增加地址
 */
//TODO: 增加地址

- (void)addAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc  更新地址
 */
//TODO: 更新地址

- (void)updAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   全部地址
 */
//TODO:  全部地址
- (void)allAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   删除地址
 */
//TODO:  删除地址
- (void)delAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   优惠券
 */
//TODO:  优惠券
- (void)getCoupon:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   用户协议
 */
//TODO:  用户协议
- (void)getAgreement:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/////////////////////////////////////////////////////////////////////
/**
 @desc   课程分类
 */
//TODO:  课程分类

- (void)getCourseType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getGradeType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   支付信息
 */
//TODO:  支付信息

- (void)getPayInfo:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   微信支付信息
 */
//TODO:  微信支付信息

- (void)getWxPayInfo:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;



/**
 @desc   章节练习
 */
//TODO:  章节练习

- (void)getChapterPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   练习
 */
//TODO:  练习

- (void)getPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getExamGrade:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   允许考试
 */
//TODO:  允许考试

- (void)getAllowExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考试
 */
//TODO:  考试

- (void)getExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   模拟考试
 */
//TODO:  模拟考试

- (void)getMnExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   收藏试题
 */
//TODO:  收藏试题

- (void)getLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   保存练习
 */
//TODO:  保存练习

- (void)savePra:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   取消考试
 */
//TODO:  取消考试

- (void)cancleExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   提交答案
 */
//TODO:  提交答案

- (void)upAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   提交模拟答案
 */
//TODO:  提交模拟答案

- (void)upMnAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考题章节
 */
//TODO:  考题章节

- (void)titleType:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考试纪录
 */
//TODO:  考试纪录

- (void)getExamRecord:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   练习纪录
 */
//TODO:  练习纪录

- (void)getParRecord:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   考试赞
 */
//TODO:  考试赞

- (void)getExamLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   收藏
 */
//TODO:  收藏

- (void)getAllLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   收藏
 */
//TODO:  收藏

- (void)getErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   删除错题
 */
//TODO:  删除错题

- (void)delErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

#pragma mark

/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getCoureList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getCoupenList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getUserList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

- (void)getvList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;
/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getreList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   学习点赞
 */
//TODO:  学习点赞

- (void)signCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   学习详情
 */
//TODO:  学习详情

- (void)getCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   论坛
 */
//TODO:  论坛

- (void)getForum:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

- (void)get1:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   详情
 */
//TODO:  详情

- (void)getNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

- (void)getbabyDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   赞新闻
 */
//TODO:   赞新闻

- (void)signNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   评论新闻
 */
//TODO:  评论新闻

- (void)commonNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

///**
// @desc   删除新闻
// */
////TODO:  删除新闻
//
//- (void)delNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   查看评论
 */
//TODO:  查看评论

- (void)comments:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   删除评论
 */
//TODO:  删除评论

- (void)delcomment:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   发帖
 */
//TODO:  发帖

- (void)addNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;


/**
 @desc   类别
 */
//TODO:  类别

- (void)getCircleList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

/**
 @desc   排行榜
 */
//TODO:  排行榜

- (void)getRanking:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure;

@end

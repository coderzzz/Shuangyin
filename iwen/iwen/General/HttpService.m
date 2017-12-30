//
//  HttpService.m
//  iStudy
//
//  Created by GZInterest on 14/11/22.
//  Copyright (c) 2014年 helloworld. All rights reserved.
//

#import "HttpService.h"
#import <objc/runtime.h>

@implementation HttpService

#pragma mark Life Cycle
- (id)init
{
    if ((self = [super init])) {
        
    }
    return  self;
}

#pragma mark Class Method
+ (HttpService *)sharedInstance
{
    static HttpService * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    return this;
}



#pragma mark Private Methods


- (BOOL)filterError:(NSDictionary *)obj failureBlock:(void (^)(NSError *, NSString *))failure
{
    if(obj == nil)
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    if(![obj isKindOfClass:[NSDictionary class]])
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    if(obj[@"code"] == nil)
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    
    
    
    if([obj[@"code"] intValue] != NO_Error)
    {
        if(obj[@"baseMsg"] != [NSNull null] || obj[@"err_msg"] != nil)
        {
            if(failure) failure(nil,obj[@"baseMsg"]);
      
        }
        return YES;
    }
//    
//    if(obj[@"baseMsg"] == nil || obj[@"baseMsg"] == [NSNull null])
//    {
//        if(failure) failure(nil,@"未知错误");
//        return YES;
//    }
    
    return NO;
}


#pragma mark - Override
/**
 @desc 重写父类的方法，添加http头部参数
 */
- (void)get:(NSString *)url parameters:(NSDictionary *)parameters  completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
   
    [super get:[NSString stringWithFormat:@"%@%@",Res_URL_Prefix,url] parameters:parameters completionBlock:success failureBlock:failure];
}




- (void)post:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
//    [self setPostWithUrl:url params:params];
    
    [super post:[NSString stringWithFormat:@"%@%@",Res_URL_Prefix,url] withParams:params completionBlock:success failureBlock:failure];
    
}


- (void)postTopic:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
//    [self setPostWithUrl:url params:params];
//    
//    [super post:Res_TOPICURL_Prefix withParams:[self setPostWithUrl:url params:params] completionBlock:success failureBlock:failure];
    
}

- (void)postStudy:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
//    [self setPostWithUrl:url params:params];
//    
//    [super post:Res_StudyURL_Prefix withParams:[self setPostWithUrl:url params:params] completionBlock:success failureBlock:failure];
    
}




#pragma mark

- (void)regist:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
    
    [self post:Register withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }

    } failureBlock:failure];

}

/**
 @desc 获取验证码
 */
//TODO:获取验证码
- (void)getCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    [self get:sendValidCode parameters:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"baseMsg"]);
        }
        
    } failureBlock:failure];
}

- (void)Scoring:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:IndexLogin withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"baseMsg"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 判断验证吗
 */
//TODO:判断验证吗
- (void)judeCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:JudgeCode withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}
/**
 @desc 意见反馈
 */
//TODO:意见反馈
- (void)feedBack:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    [self post:FeedBack withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

- (void)feed:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:Feed withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

- (void)upload:(NSDictionary *)parms fileurl:(NSURL *)url  name:(NSString *)name completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
   
//    [self uploadFile:@"http://120.76.112.202/api/upload" withParams:parms fileURL:url fileKey:name completionBlock:^(id obj) {
//        BOOL isError = [self filterError:obj failureBlock:failure];
//        if (isError) {
//            return ;
//        }
//        if(success)
//        {
//            success(obj);
//        }
//        
//    } failureBlock:failure];
    
    
//    [opera setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat xx = totalBytesExpectedToWrite;
//        CGFloat yy = totalBytesWritten;
//        CGFloat pro = yy/xx;
//        progress(pro);
//    }];
//    [opera start];
}

- (void)login:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:DoLogin withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
    
}


/**
 @desc 修改密码
 */
//TODO:修改密码
- (void)changePassWord:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    
    [self post:UpdPassword withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 获取广告
 */
//TODO:获取广告

- (void)getAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:Ad withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
 
}

- (void)getVideo:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:Video withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];

    
}



/**
 @desc 获取启动页
 */
//TODO:获取启动页

- (void)getLanuchAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:LanuchAd withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc 获取用户详情
 */
//TODO:获取用户详情

- (void)getUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UsePersonal withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc 更新用户信息
 */
//TODO:更新用户信息

- (void)updUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UpdPersonal withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 更新用户头像
 */
//TODO:更新用户头像

- (void)updUserAvatar:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:SaveAvatar withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc  查看帖子
 */
//TODO: 查看帖子

- (void)getNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self post:MyNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc  删除帖子
 */
//TODO: 删除帖子

- (void)delNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
    
}

/**
 @desc  增加地址
 */
//TODO: 增加地址

- (void)addAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:NewAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc  更新地址
 */
//TODO: 更新地址

- (void)updAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UpdAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   全部地址
 */
//TODO:  全部地址
- (void)allAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:upComment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   删除地址
 */
//TODO:  删除地址
- (void)delAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   优惠券
 */
//TODO:  优惠券
- (void)getCoupon:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:LookCoupon withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   用户协议
 */
//TODO:  用户协议
- (void)getAgreement:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self post:GetAgreement withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

#pragma mark  topic

/**
 @desc   课程分类
 */
//TODO:  课程分类

- (void)getCourseType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:CourseType withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getGradeType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:AllExamGrade withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   支付信息
 */
//TODO:  支付信息

- (void)getPayInfo:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    NSString *str;
    
    if ([type isEqualToString:@"1"]) { //1抢红包,2抢优惠
        
        str = @"getRed";
    }
    else{
        
        str = @"getCoupon";
    }
    
    [self post:str withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure]; 
    
    
}
/**
 @desc   微信支付信息
 */
//TODO:  微信支付信息

- (void)getWxPayInfo:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:WxPay withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   章节练习
 */
//TODO:  章节练习

- (void)getChapterPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:ApplyAdvert withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   练习
 */
//TODO:  练习

- (void)getPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:Practice withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"baseMsg"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getExamGrade:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:ExamGrade withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}
/**
 @desc   允许考试
 */
//TODO:  允许考试

- (void)getAllowExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self post:AllowExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试
 */
//TODO:  考试

- (void)getExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:Exam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   模拟考试
 */
//TODO:  模拟考试

- (void)getMnExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    
    [self post:MnExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   收藏试题
 */
//TODO:  收藏试题

- (void)getLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:MnTopicAnswer withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   保存练习
 */
//TODO:  保存练习

- (void)savePra:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:SavePractice withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   取消考试
 */
//TODO:  取消考试

- (void)cancleExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:CancelExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   提交答案
 */
//TODO:  提交答案

- (void)upAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:TopicAnswer withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}
/**
 @desc   提交模拟答案
 */
//TODO:  提交模拟答案

- (void)upMnAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    [self postTopic:MnTopicAnswer withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}
/**
 @desc   考题章节
 */
//TODO:  考题章节

- (void)titleType:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:TitleType withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}


/**
 @desc   考试纪录
 */
//TODO:  考试纪录

- (void)getExamRecord:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    NSString *str;
    if ([type isEqualToString:@"1"]) {//hongbao
        
        str = @"getStatisticsByAdId";
    }
    else{
        
        str = @"getStatisticsByCouponId";
    }
    [self post:str withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   练习纪录
 */
//TODO:  练习纪录

- (void)getParRecord:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:PracticeRecord withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}


/**
 @desc   考试赞
 */
//TODO:  考试赞

- (void)getExamLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:MyLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

- (void)getAllLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:LookLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   收藏
 */
//TODO:  收藏

- (void)getErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:ErrorDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}
/**
 @desc   删除错题
 */
//TODO:  删除错题

- (void)delErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelEtitle withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

#pragma mark study

/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getCoureList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:CourseList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

- (void)getCoupenList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:CoupenList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

- (void)getUserList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UserList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

- (void)getvList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:VList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}




- (void)getreList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:ClassLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc   学习点赞
 */
//TODO:  学习点赞

- (void)signCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:Sign withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   学习详情
 */
//TODO:  学习详情

- (void)getCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:CourseDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   论坛
 */
//TODO:  论坛

- (void)getForum:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:GetForum withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}
- (void)get1:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    NSString *url1;
    if ([type isEqualToString:@"red"]) {
        
        url1 = @"getRedRecord";
    }
    else{
        url1 = @"getCouponRecord";
    }
    [self post:url1 withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   详情
 */
//TODO:  详情

- (void)getNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:GetNewsDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];

}

- (void)getbabyDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:GetNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    

    
}

/**
 @desc   赞新闻
 */
//TODO:   赞新闻

- (void)signNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:NewSign withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   评论新闻
 */
//TODO:  评论新闻

- (void)commonNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:Comment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   查看评论
 */
//TODO:  查看评论

- (void)comments:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:LookComment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   删除评论
 */
//TODO:  删除评论

- (void)delcomment:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelComment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   发帖
 */
//TODO:  发帖

- (void)addNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:AddNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   类别
 */
//TODO:  类别

- (void)getCircleList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:CircleList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   排行榜
 */
//TODO:  排行榜

- (void)getRanking:(NSDictionary *)parms type:(NSString *)type completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    NSString *str;
    

    if ([type isEqualToString:@"2"]) {//红包
        
        str = @"getRedAdvertList";
    }
    else{
        
         str = @"getAdvertList";
        
    }
    
    [self post:str withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"obj"]);
        }
        
    } failureBlock:failure];
    
}



@end


//
//  LearnService.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetCourseListSuccess) (id obj);
typedef void (^GetCourseListFailure) (id obj);


typedef void (^GetUserListSuccess) (id obj);
typedef void (^GetUserListFailure) (id obj);



typedef void (^GetCoupenListSuccess) (id obj);
typedef void (^GetCoupenListFailure) (id obj);

typedef void (^GetReListSuccess) (id obj);
typedef void (^GetReListFailure) (id obj);

typedef void (^GetVideoListSuccess) (id obj);
typedef void (^GetVideoListFailure) (id obj);




typedef void (^SignCourseSuccess) (id obj);
typedef void (^SignCourseFailure) (id obj);

typedef void (^GetCourseSuccess) (id obj);
typedef void (^GetCourseFailure) (id obj);

@interface LearnService : NSObject

@property (nonatomic, copy)GetReListSuccess getReListSuccess;
@property (nonatomic, copy)GetReListFailure getReListFailure;


@property (nonatomic, copy)GetVideoListSuccess getVideoListSuccess;
@property (nonatomic, copy)GetVideoListFailure getVideoListFailure;
@property (nonatomic, assign) NSInteger     vIndex;
@property (nonatomic, strong) NSMutableArray *vSource;




@property (nonatomic, copy)GetCourseListSuccess getCourseListSuccess;
@property (nonatomic, copy)GetCourseListFailure getCourseListFailure;

@property (nonatomic, copy)GetCoupenListFailure getCoupenListFailure;
@property (nonatomic, copy)GetCoupenListSuccess getCoupenListSuccess;


@property (nonatomic, copy)GetUserListSuccess getUserListSuccess;
@property (nonatomic, copy)GetUserListFailure getUserListFailure;

@property (nonatomic, assign) NSInteger     pageIndex;
@property (nonatomic, strong) NSMutableArray *dataSource;


@property (nonatomic, assign) NSInteger     userIndex;
@property (nonatomic, strong) NSMutableArray *userSource;


@property (nonatomic, assign) NSInteger     coupageIndex;
@property (nonatomic, strong) NSMutableArray *coudataSource;


@property (nonatomic, assign) NSInteger     repageIndex;
@property (nonatomic, strong) NSMutableArray *redataSource;


@property (nonatomic, copy)SignCourseSuccess signCourseSuccess;
@property (nonatomic, copy)SignCourseFailure signCourseFailure;

@property (nonatomic, copy)GetCourseSuccess getCourseSuccess;
@property (nonatomic, copy)GetCourseFailure getCourseFailure;

+(LearnService *)shareInstanced;

//获取旗袍说
- (void)getFirstCourseListWithType:(NSString *)type;

- (void)getMoreCourseListWithType:(NSString *)type;

- (void)getFirstUserList;

- (void)getMoreUserList;


- (void)getFirstvList;

- (void)getMorevList;


- (void)getFirstCoupenListWithType:(NSString *)type;

- (void)getMoreCoupenListWithType:(NSString *)type;

- (void)getFirstReListWithDic:(NSMutableDictionary *)dic;

- (void)getMoreReListWithDic:(NSMutableDictionary *)dic;





- (void)signCourseWithUid:(NSString *)uid cid:(NSString *)cid;

- (void)getCourseWithUid:(NSString *)uid cid:(NSString *)cid;






@end

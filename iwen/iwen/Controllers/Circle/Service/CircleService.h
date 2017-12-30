//
//  CircleService.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetForumSuccess) (id obj);
typedef void (^GetForumFailure) (id obj);

typedef void (^GetNewsDetailSuccess) (id obj);
typedef void (^GetNewsDetailFailure) (id obj);



typedef void (^GetOnSuccess) (id obj);
typedef void (^GetOnFailure) (id obj);
typedef void (^GetOffSuccess) (id obj);
typedef void (^GetOffFailure) (id obj);

typedef void (^Get1Success) (id obj);
typedef void (^Get1Failure) (id obj);



typedef void (^SignNewSuccess) (id obj);
typedef void (^SignNewFailure) (id obj);

typedef void (^CommentNewSuccess) (id obj);
typedef void (^CommentNewFailure) (id obj);

typedef void (^GetCommentSuccess) (id obj);
typedef void (^GetCommentFailure) (id obj);

typedef void (^DelCommentSuccess) (id obj);
typedef void (^DelCommentFailure) (id obj);

typedef void (^AddNewsSuccess) (id obj);
typedef void (^AddNewsFailure) (id obj);

typedef void (^GetCircleListSuccess) (id obj);
typedef void (^GetCircleListFailure) (id obj);

//typedef void (^DelNewSuccess) (id obj);
//typedef void (^DelNewFailure) (id obj);

@interface CircleService : NSObject

@property (nonatomic, copy) GetForumSuccess getForumSuccess;
@property (nonatomic, copy) GetForumFailure getForumFailure;

@property (nonatomic, assign) NSInteger    pageIndex;
@property (nonatomic, strong) NSMutableArray *dataSource;




@property (nonatomic, copy) GetOnSuccess getonSuccess;
@property (nonatomic, copy) GetOnFailure getonFailure;
@property (nonatomic, assign) NSInteger    onpageIndex;
@property (nonatomic, strong) NSMutableArray *ondataSource;
@property (nonatomic, copy) GetOffSuccess getOffSuccess;
@property (nonatomic, copy) GetOffFailure getOffFailure;
@property (nonatomic, assign) NSInteger    offpageIndex;
@property (nonatomic, strong) NSMutableArray *offdataSource;


@property (nonatomic, copy) Get1Success get1Success;
@property (nonatomic, copy) Get1Failure get1Failure;
@property (nonatomic, assign) NSInteger    page1Index;
@property (nonatomic, strong) NSMutableArray *data1Source;


@property (nonatomic, copy) GetNewsDetailSuccess getNewsDetailSuccess;
@property (nonatomic, copy) GetNewsDetailFailure getNewsDetailFailure;

@property (nonatomic, copy) SignNewSuccess signNewSuccess;
@property (nonatomic, copy) SignNewFailure signNewFailure;

@property (nonatomic, copy) CommentNewSuccess commentNewSuccess;
@property (nonatomic, copy) CommentNewFailure commentNewFailure;

@property (nonatomic, copy) GetCommentSuccess getCommentSuccess;
@property (nonatomic, copy) GetCommentFailure getCommentFailure;

@property (nonatomic, assign) NSInteger     commonPageIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) DelCommentSuccess delCommentSuccess;
@property (nonatomic, copy) DelCommentFailure delCommentFailure;

@property (nonatomic, copy) AddNewsSuccess addNewsSuccess;
@property (nonatomic, copy) AddNewsFailure addNewsFailure;

@property (nonatomic, copy) GetCircleListSuccess getCircleListSuccess;
@property (nonatomic, copy) GetCircleListFailure getCircleListFailure;

//@property (nonatomic, copy) DelNewSuccess delNewSuccess;
//@property (nonatomic, copy) DelNewFailure delNewFailure;


+ (CircleService *)shareInstaced;

//获取红包广告
- (void)getFirstForumWithId:(NSString *)typeId;
//获取红包广告
- (void)getMoreForumWithId:(NSString *)typeId;


//
- (void)getFirst1WithId:(NSString *)typeId type:(NSString *)type;
//
- (void)getMore1WithId:(NSString *)typeId type:(NSString *)type;




- (void)getFirstCommentWithId:(NSString *)typeId;

- (void)getMoreCommentWithId:(NSString *)typeId;



- (void)getFirstOnWithId:(NSString *)typeId;

- (void)getMoreOnWithId:(NSString *)typeId;

- (void)getFirstOffWithId:(NSString *)typeId;

- (void)getMoreOffWithId:(NSString *)typeId;







- (void)getNewsDetailWithId:(NSString *)typeId uid:(NSString *)uid;

- (void)signNewsWithId:(NSString *)typeId uid:(NSString *)uid;


















- (void)commentNewsWithId:(NSString *)typeId uid:(NSString *)uid comment:(NSString *)comment;

//- (void)delNewsWithId:(NSString *)typeId uid:(NSString *)uid;




- (void)delCommentWithId:(NSString *)typeId uid:(NSString *)uid;

- (void)addNewsWitDic:(NSDictionary *)dic;

- (void)getCircleList;


@end

//
//  CircleService.m
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CircleService.h"

@implementation CircleService

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.pageIndex = 1;
        self.dataSource = [NSMutableArray array];
        
        self.commonPageIndex = 1;
        self.dataArray = [NSMutableArray array];
        
        
        self.onpageIndex = 1;
        self.ondataSource = [NSMutableArray array];
        
        self.page1Index = 1;
        self.data1Source = [NSMutableArray array];
        
        self.offpageIndex = 1;
        self.offdataSource = [NSMutableArray array];
        
    }
    return self;
}

+ (CircleService *)shareInstaced
{
    static CircleService *this = nil;
    
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        this = [[self alloc]init];
        
    });
    
    return this;
}

#pragma mark

- (void)getFirstForumWithId:(NSString *)typeId
{
    [self.dataSource removeAllObjects];
    
    self.pageIndex = 1;

    [self getForumWithId:typeId];
}

- (void)getMoreForumWithId:(NSString *)typeId
{
    
    self.pageIndex++;
    
    [self getForumWithId:typeId];
}


- (void)getForumWithId:(NSString *)typeId{
    
   NSDictionary *dic = @{@"adersId":typeId,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],@"adType":@1};
    
    [[HttpService sharedInstance]getForum:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            
            [self.dataSource addObjectsFromArray:ary];
            
            if (_getForumSuccess) {
                
                _getForumSuccess(self.dataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getForumFailure) {
            
            _getForumFailure(responseString);
        }
        
    }];
    
}

#pragma mark
//
- (void)getFirst1WithId:(NSString *)typeId type:(NSString *)type{
    
    [self.data1Source removeAllObjects];
    
    self.page1Index = 1;
    
    [self get1WithId:typeId type:type];
}
//
- (void)getMore1WithId:(NSString *)typeId type:(NSString *)type{
    
    self.page1Index++;
    
    [self get1WithId:typeId type:type];

}

- (void)get1WithId:(NSString *)token type:(NSString *)t{
    
    NSDictionary *dic;
    if ([t isEqualToString:@"red"]) {
        
         dic = @{@"adId":token,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.page1Index]};
    }
    else{
        
         dic = @{@"couponId":token,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.page1Index]};
    }
   
    
    [[HttpService sharedInstance]get1:dic type:t completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            
            [self.data1Source addObjectsFromArray:ary];
            
            if (_get1Success) {
                
                _get1Success(self.data1Source);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_get1Failure) {
            
            _get1Failure(responseString);
        }
        
    }];

    
}
#pragma mark
- (void)getFirstOnWithId:(NSString *)typeId{
    
    [self.ondataSource removeAllObjects];
    self.onpageIndex = 1;
    [self getonWithid:typeId];
}

- (void)getMoreOnWithId:(NSString *)typeId{
    self.onpageIndex = self.onpageIndex + 1;
    [self getonWithid:typeId];
}

- (void)getonWithid:(NSString *)token{
    
    NSDictionary *dic = @{@"token":token,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.onpageIndex],@"status":@1};
    
    [[HttpService sharedInstance]getbabyDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            
            [self.ondataSource addObjectsFromArray:ary];
            
            if (_getonSuccess) {
                
                _getonSuccess(self.ondataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getonFailure) {
            
            _getonFailure(responseString);
        }
        
    }];

    
    
}

- (void)getFirstOffWithId:(NSString *)typeId{
    
    [self.offdataSource removeAllObjects];
    self.offpageIndex = 1;
    [self getoffWithid:typeId];
    
}

- (void)getMoreOffWithId:(NSString *)typeId{
    self.offpageIndex = self.offpageIndex + 1;
    [self getoffWithid:typeId];
}
- (void)getoffWithid:(NSString *)token{
    
    NSDictionary *dic = @{@"token":token,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.offpageIndex],@"status":@0};
    
    [[HttpService sharedInstance]getbabyDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            
            [self.offdataSource addObjectsFromArray:ary];
            
            if (_getOffSuccess) {
                
                _getOffSuccess(self.offdataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getOffFailure) {
            
            _getOffFailure(responseString);
        }
        
    }];
    
    
    
}
#pragma mark

- (void)getNewsDetailWithId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"status":typeId,@"token":uid};
    
//    status	优惠券状态:0未使用，1已过期，2已使用
    
    [[HttpService sharedInstance]getNewsDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSArray *ary = object;
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in ary) {
                
                CourseListModel *model = [[CourseListModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    [temp addObject:model];
                }
            }
            if (temp.count>0) {
               
                if (_getNewsDetailSuccess) {
                    
                    _getNewsDetailSuccess(temp);
                }

               
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getNewsDetailFailure) {
            
            _getNewsDetailFailure(responseString);
        }
        
    }];

}
- (void)signNewsWithId:(NSString *)typeId uid:(NSString *)uid
{
    
    NSDictionary *dic = @{@"aderId":uid};
    
    [[HttpService sharedInstance]signNewsDetail:dic completionBlock:^(id object) {
        
        NSArray *ary = object;
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in ary) {
            
            CourseListModel *model = [[CourseListModel alloc]initWithDictionary:dic error:nil];
            if (model) {
                [temp addObject:model];
            }
        }

        
        if (temp.count>0) {
            
            if (_signNewSuccess) {
                
                _signNewSuccess(temp);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_signNewFailure) {
            
            _signNewFailure(responseString);
        }
        
    }];
 
}

- (void)commentNewsWithId:(NSString *)typeId uid:(NSString *)uid comment:(NSString *)comment{
    
    NSDictionary *dic = @{@"news_id":typeId,@"uid":uid,@"comment":comment};
    
    [[HttpService sharedInstance]commonNewsDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSDictionary *dic = object;
            
            CommonModel *model = [[CommonModel alloc]initWithDictionary:dic error:nil];
            
            if (model) {
                
                if (_commentNewSuccess) {
                    
                    _commentNewSuccess(model);
                }
                
            }
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_commentNewFailure) {
            
            _commentNewFailure(responseString);
        }
        
    }];
}

- (void)delNewsWithId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"id":typeId,@"uid":uid};
//    
//    [[HttpService sharedInstance]signNewsDetail:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//            if (_signNewSuccess) {
//                
//                _signNewSuccess(object);
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_signNewFailure) {
//            
//            _signNewFailure(responseString);
//        }
//        
//    }];
}

- (void)getFirstCommentWithId:(NSString *)typeId{
    
    [self.dataArray removeAllObjects];
    
    self.commonPageIndex = 1;
    
    [self getCommentsWithId:typeId];
}

- (void)getMoreCommentWithId:(NSString *)typeId{
    
    self.commonPageIndex++;
    
    [self getCommentsWithId:typeId];
    
}


- (void)getCommentsWithId:(NSString *)typeId{
    
    NSDictionary *dic = @{@"adersId":typeId,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.commonPageIndex],@"adType":@2};
    
    [[HttpService sharedInstance]comments:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            [self.dataArray addObjectsFromArray:ary];
            
            if (_getCommentSuccess) {
                
                _getCommentSuccess(self.dataArray);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCommentFailure) {
            
            _getCommentFailure(responseString);
        }
        
    }];
    
}

- (void)delCommentWithId:(NSString *)typeId uid:(NSString *)uid{
    
   
    
    [[HttpService sharedInstance]delcomment:nil completionBlock:^(id object) {
        
        if (object) {
            
            if (_delCommentSuccess) {
                
                _delCommentSuccess(object);
            }
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_delCommentFailure) {
            
            _delCommentFailure(responseString);
        }
        
    }];
    
}

- (void)addNewsWitDic:(NSDictionary *)dic{
    
    [[HttpService sharedInstance]addNews:dic completionBlock:^(id object) {
        
        if (object) {
            
            if (_addNewsSuccess) {
                
                _addNewsSuccess(object);
            }
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_addNewsFailure) {
            
            _addNewsFailure(responseString);
        }
        
    }];

}

- (void)getCircleList{
    
    
    [[HttpService sharedInstance]getCircleList:nil completionBlock:^(id object) {
        
        NSMutableArray *ary = object;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for(NSDictionary *dic in ary){
            
            CircleListModel *model = [[CircleListModel alloc]initWithDictionary:dic error:nil];
            
            if (model) {
                
                [dataArray addObject:model];
            }
            
        }
        
        if (_getCircleListSuccess) {
            
            _getCircleListSuccess(dataArray);
        }

    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCircleListFailure) {
            
            _getCircleListFailure(responseString);
        }
        
    }];
    
}


@end

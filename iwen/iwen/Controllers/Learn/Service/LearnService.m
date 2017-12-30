//
//  LearnService.m
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LearnService.h"

@implementation LearnService

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.pageIndex = 1;
        self.dataSource = [NSMutableArray array];
        
        
        self.vIndex = 1;
        self.vSource = [NSMutableArray array];
        
        self.userIndex = 1;
        self.userSource = [NSMutableArray array];
        
        self.repageIndex = 1;
        self.redataSource= [NSMutableArray array];
        
        self.coupageIndex = 1;
        self.coudataSource = [NSMutableArray array];
    }
    return self;
}

+ (LearnService *)shareInstanced{
    
    static LearnService *this = nil;
    
    static dispatch_once_t onesToken;
    
    dispatch_once(&onesToken, ^{
        
        this = [[self alloc]init];
        
    });
    
    return this;
}

#pragma mark

- (void)getFirstCourseListWithType:(NSString *)type{
    
    [self.dataSource removeAllObjects];
    
    self.pageIndex = 1;
    
    [self getCourseListWithType:type];
    
    
}


- (void)getCourseListWithType:(NSString *)type{
    
    NSDictionary *dic;
    
    if (type.length>0) {
        
        if ([type hasPrefix:@"user"]) {
            
            type = [type stringByReplacingOccurrencesOfString:@"user" withString:@""];
            
            dic = @{@"userId":type,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
        }
        else{
            
            dic = @{@"token":type,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
        }
       
    }
    else{
        
        dic = @{@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
    }
    
    
    [[HttpService sharedInstance]getCoureList:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                CourseListModel *model = [[CourseListModel alloc]initWithDictionary:dic error:nil];
                
                if (model) {
                    
                    if (type.length>0) {
                        
                        model.my = @"1";
                    }
                    
                    [dataArray addObject:model];
                }
            }
            
            [self.dataSource addObjectsFromArray:dataArray];
            
            if (_getCourseListSuccess) {
                
                _getCourseListSuccess (self.dataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCourseListFailure) {
            
            _getCourseListFailure(responseString);
        }
        
    }];

}

- (void)getMoreCourseListWithType:(NSString *)type{
    
    self.pageIndex ++;
    
    [self getCourseListWithType:type];

}



- (void)getFirstUserList{
    
    [self.userSource removeAllObjects];
    self.userIndex = 1;
    [self getUserList];
}

- (void)getMoreUserList{
    
    self.userIndex++;
     [self getUserList];
}

- (void)getUserList{
     NSDictionary *dic = @{@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.userIndex]};
   
    [[HttpService sharedInstance]getUserList:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                UserListModel *model = [[UserListModel alloc]initWithDictionary:dic error:nil];
                [dataArray addObject:model];
            }
            
            [self.userSource addObjectsFromArray:dataArray];
            
            if (_getUserListSuccess) {
                
                _getUserListSuccess (self.userSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getUserListFailure) {
            
            _getUserListFailure(responseString);
        }
        
    }];

}


- (void)getFirstvList{
    
    [self.vSource removeAllObjects];
    self.vIndex = 1;
    [self getvList];
}

- (void)getMorevList{
    self.vIndex++;
    [self getvList];
}
- (void)getvList{
    NSDictionary *dic = @{@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.vIndex]};
    
    [[HttpService sharedInstance]getvList:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                ViedeoModel *model = [[ViedeoModel alloc]initWithDictionary:dic error:nil];
                [dataArray addObject:model];
            }
            
            [self.vSource addObjectsFromArray:dataArray];
            
            if (_getVideoListSuccess) {
                
                _getVideoListSuccess (self.vSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getVideoListFailure) {
            
            _getVideoListFailure(responseString);
        }
        
    }];
    
}


- (void)getFirstCoupenListWithType:(NSString *)type{
    
    [self.coudataSource removeAllObjects];
    
    self.coupageIndex = 1;
    
    [self getCoupenListWithType:type];
    
}

- (void)getMoreCoupenListWithType:(NSString *)type{
    
    self.coupageIndex ++;
    
    [self getCoupenListWithType:type];
}

- (void)getCoupenListWithType:(NSString *)type{
    
    NSDictionary *dic;
    
    if (type.length>0) {
        
        dic = @{@"adTypeId":type,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.coupageIndex]};
    }
    else{
        
        dic = @{@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.coupageIndex]};
    }
    
    
    [[HttpService sharedInstance]getCoupenList:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                CourseListModel *model = [[CourseListModel alloc]initWithDictionary:dic error:nil];
                 [dataArray addObject:model];
            }
            
            [self.coudataSource addObjectsFromArray:dataArray];
            
            if (_getCoupenListSuccess) {
                
                _getCoupenListSuccess (self.coudataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCoupenListFailure) {
            
            _getCoupenListFailure(responseString);
        }
        
    }];
    
}

- (void)getFirstReListWithDic:(NSMutableDictionary *)dic{
    
    self.repageIndex = 1;
    [self.redataSource removeAllObjects];
    [self getReListWithDic:dic];
    
}

- (void)getMoreReListWithDic:(NSMutableDictionary *)dic{
    
    self.pageIndex ++;
    
    [self getReListWithDic:dic];
}


- (void)getReListWithDic:(NSMutableDictionary *)dic{
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.repageIndex] forKey:@"pageNO"];
    [[HttpService sharedInstance]getreList:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                ExamResultModel *model = [[ExamResultModel alloc]initWithDictionary:dic error:nil];
                [dataArray addObject:model];
            }
            
            [self.redataSource addObjectsFromArray:dataArray];
            
            if (_getReListSuccess) {
                
                _getReListSuccess (self.redataSource);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getReListFailure) {
            
            _getReListFailure(responseString);
        }
        
    }];
    

}











































- (void)signCourseWithUid:(NSString *)uid cid:(NSString *)cid{
    
    NSDictionary *dic = @{@"uid":uid,@"cid":cid};
    
    [[HttpService sharedInstance]signCoure:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_signCourseSuccess) {
                
                _signCourseSuccess (object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_signCourseFailure) {
            
            _signCourseFailure(responseString);
        }
        
    }];
    
}

- (void)getCourseWithUid:(NSString *)uid cid:(NSString *)cid{
    
    NSDictionary *dic = @{@"uid":uid,@"cid":cid};
    
    [[HttpService sharedInstance]getCoure:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSDictionary *dic = object;
            
            CourseListModel *model = [[CourseListModel alloc]initWithDictionary:dic error:nil];
            
            if (model) {
                
                if (_getCourseSuccess) {
                    
                    _getCourseSuccess(model);
                }
                
            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCourseFailure) {
            
            _getCourseFailure(responseString);
        }
        
    }];
    
}

@end

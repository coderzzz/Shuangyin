//
//  ExamService.m
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamService.h"

@implementation ExamService
{
    
    NSString *type;
}
- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.rangkPageIndex = 1;
        
        self.rankArray = [NSMutableArray array];
        
    }
    
    return self;
}

+ (ExamService *)shareInstenced{
    
    static ExamService *this = nil;
    
    static dispatch_once_t onesToken;
    
    dispatch_once(&onesToken, ^{
        
        this = [[self alloc]init];
    });
    
    return this;

}

#pragma mark


- (void)getCourseType{
    
    [[HttpService sharedInstance]getCourseType:nil completionBlock:^(id objdct) {
    
        
        if (objdct) {
            
//            NSMutableArray *ary = objdct;
//            
//            NSMutableArray *dataArray = [NSMutableArray array];
//            
//            for (NSDictionary *dic in ary) {
//                
//                CourseTypeModel *model = [[CourseTypeModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model];
//                }
//            }
//            
            if (_getCourseTypeSuccess) {
                
                _getCourseTypeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCourseTypeFailure) {
            
            _getCourseTypeFailure(responseString);
        }
        
    }];
    
}

- (void)getGradeTypeWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]getGradeType:@{@"pid":uid} completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            if (_getGradeTypeSuccess) {
                
                _getGradeTypeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getGradeTypeFailure) {
            
            _getGradeTypeFailure(responseString);
        }
        
    }];
    
}

- (void)getPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id type:(NSString *)ty city:(NSString *)city{
    
    NSString *str;
    
    if ([ty isEqualToString:@"1"]) { //1抢红包,2抢优惠
        
        str = @"adId";
    }
    else{
        
        str = @"couponId";
    }
    
    
    NSDictionary *dic = @{@"questionId":grade_id,@"token":uid,str:fee,@"answer":coupon_id,@"area":city};
    
    [[HttpService sharedInstance]getPayInfo:dic type:ty completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
          
                if (_getPayInfoSuccess) {
                    
                    _getPayInfoSuccess(objdct);
                }
//                
//            }
//            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPayInfoFailure) {
            
            _getPayInfoFailure(responseString);
        }
        
    }];

}

- (void)getWxPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id{
    
    NSDictionary *dic = @{@"grade_id":grade_id,@"uid":uid,@"total_fee":fee,@"coupon_id":coupon_id};
    
    [[HttpService sharedInstance]getWxPayInfo:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct;
            
            
            if (_getWxPayInfoSuccess) {
                
                _getWxPayInfoSuccess(dic);
            }
                
         
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getWxPayInfoFailure) {
            
            _getWxPayInfoFailure(responseString);
        }
        
    }];
    
}

- (void)getChapterPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"obj":typeId,@"token":uid};
    
    [[HttpService sharedInstance]getChapterPractice:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
           
            
            if (_getChapterPracticeSuccess) {
                
                _getChapterPracticeSuccess(objdct);
            }
   
        }
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getChapterPracticeFailure) {
            
            _getChapterPracticeFailure(responseString);
        }
        
    }];
 
}

- (void)getPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"obj":typeId,@"token":uid};
    
    [[HttpService sharedInstance]getPractice:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            if (_getPracticeSuccess) {
                
                _getPracticeSuccess(objdct);
            }
            
        }
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPracticeFailure) {
            
            _getPracticeFailure(responseString);
        }
        
    }];
}

- (void)getGetExamGradeWithType:(NSString *)typeId uid:(NSString *)uid{
    
     NSDictionary *dic = @{@"obj":typeId,@"token":uid};
    
    [[HttpService sharedInstance]getExamGrade:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
                if (_getExamGradeSuccess) {
                    
                    _getExamGradeSuccess(objdct);
                }
              
            }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamGradeFailure) {
            
            _getExamGradeFailure(responseString);
        }
        
    }];
    
}

- (void)getAllowExamWithUid:(NSString *)uid{
    
    
    NSDictionary *dic = @{@"advertId":uid};
    
    [[HttpService sharedInstance]getAllowExam:dic completionBlock:^(id objdct) {
        
       
        
        if (objdct) {
           
            if (_getAllowExamSuccess) {
                
                _getAllowExamSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAllowExamFailure) {
            
            _getAllowExamFailure(responseString);
        }
        
    }];
    
}

- (void)getExamWithUid:(NSString *)uid type:(NSString *)type{
    
    NSDictionary *dic = @{@"adersId":uid};
    
    [[HttpService sharedInstance]getExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            
            if (_getExamSuccess) {
                
                _getExamSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamFailure) {
            
            _getExamFailure(responseString);
        }
        
    }];
    
}

- (void)getMnExamWithUid:(NSString *)uid type:(NSString *)type{
    
    NSDictionary *dic = @{@"releaseId":uid};
    
    [[HttpService sharedInstance]getMnExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct[@"release"];
            
            ExamResultModel *model = [[ExamResultModel alloc]initWithDictionary:dic error:nil];
            model.txt = objdct[@"releaseUser"][@"frealName"];
            model.logo = objdct[@"releaseUser"][@"fheadImg"];
            if (_getMnExamSuccess) {
                
                _getMnExamSuccess(model);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getMnExamFailure) {
            
            _getMnExamFailure(responseString);
        }
        
    }];
    
    
}

- (void)getExamLikeWithUid:(NSString *)uid cid:(NSDictionary *)cid{
    
    
    [[HttpService sharedInstance]getLike:cid completionBlock:^(id objdct) {
        
        
        if (objdct) {
            

            if (_getExamLikeSuccess) {
                
                _getExamLikeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamLikeFailure) {
            
            _getExamLikeFailure(responseString);
        }
        
    }];
    
    
}

- (void)savePracticeWithJsonString:(NSString *)jsonStr time:(NSString *)time{
    
    NSDictionary *dic = @{@"id":jsonStr};
    
    [[HttpService sharedInstance]savePra:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
           
            if (_savePracticeSuccess) {
                
                _savePracticeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_savePracticeFailure) {
            
            _savePracticeFailure(responseString);
        }
        
    }];
    
}



- (void)upLoadExamWithExamId:(NSString *)string topic_answer:(NSString *)answers time:(NSString *)time video:(NSString *)video{
    
    NSDictionary *dic;
    if (video.length >3) {
        
        dic= @{@"token":string,@"fcontent":answers,@"fvideo":video};
    }
    else{
        
        dic= @{@"token":string,@"fcontent":answers,@"fimgs":time};
    }
    
    [[HttpService sharedInstance]upAnswer:dic completionBlock:^(id objdct) {
        if (objdct) {
            
    
                
                if (_upLoadExamSuccess) {
                    
                    
                    _upLoadExamSuccess(objdct);
                }
                
        }
            
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upLoadExamFailure) {
            
            _upLoadExamFailure(responseString);
        }
        
    }];

}

- (void)upLoadMnExamWithExamId:(NSString *)string topic_answer:(NSString *)answers time:(NSString *)time grade:(NSString *)grade{
    
    NSDictionary *dic = @{@"topic_answer":answers,@"use_time":time,@"grade":grade};
    
    [[HttpService sharedInstance]upMnAnswer:dic completionBlock:^(id objdct) {
        if (objdct) {
            
            NSDictionary *dic = objdct;
            
            ExamResultModel *model = [[ExamResultModel alloc]initWithDictionary:dic error:nil];
            
            if (model) {
                
                if (_upLoadMnExamSuccess) {
                    
                    
                    _upLoadMnExamSuccess(model);
                }
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upLoadMnExamFailure) {
            
            _upLoadMnExamFailure(responseString);
        }
        
    }];

    
}

- (void)getTitleTypeWithPageIndex:(NSString *)page{
    

    
    [[HttpService sharedInstance]titleType:@{@"pageNO":page} completionBlock:^(id objdct) {
        if (objdct) {
            
            NSMutableArray *ary = [objdct[@"list"]mutableCopy];
            
            if (_getTitleTypeSuccess) {
                
                _getTitleTypeSuccess(ary);
                
            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getTitleTypeFailure) {
            
            _getTitleTypeFailure(responseString);
        }
        
    }];
    
}


- (void)cancleExamWithUid:(NSString *)uid examId:(NSString *)examId{
    
    
    NSDictionary *dic = @{@"areaName":uid};
    
    [[HttpService sharedInstance]cancleExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_cancelExamSuccess) {
                
                _cancelExamSuccess(objdct[@"list"]);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_cancelExamFailure) {
            
            _cancelExamFailure(responseString);
        }
        
    }];
    

}

- (void)getExamRecordWithUid:(NSDictionary *)dic type:(NSString *)typ{
    
//    NSDictionary *dic = @{@"adId":uid};
    
    [[HttpService sharedInstance]getExamRecord:dic type:typ completionBlock:^(id objdct) {
        
            if (_getExamRecordSuccess) {
                
                _getExamRecordSuccess(objdct);
            }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamRecordFailure) {
            
            _getExamRecordFailure(responseString);
        }
        
    }];
}

- (void)getPraRecordWithUid:(NSString *)uid{
    
    NSDictionary *dic = @{@"phone":uid};
    
    [[HttpService sharedInstance]getParRecord:dic completionBlock:^(id objdct) {
        
        if (objdct) {
            
            
            
            if (_getPraRecordSuccess) {
                
                _getPraRecordSuccess(objdct[@"baseMsg"]);
            }
        }
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPraRecordFailure) {
            
            _getPraRecordFailure(responseString);
        }
        
    }];
    
}

- (void)addExamLikeWithUid:(NSString *)uid tid:(NSString *)tid type:(NSString *)type22 {
    
    
    NSDictionary *dic = @{@"token":uid,type22:tid};
    
    [[HttpService sharedInstance]getExamLike:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_addExamLikeSuccess) {
                
                _addExamLikeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_addExamLikeFailure) {
            
            _addExamLikeFailure(responseString);
        }
        
    }];
}

- (void)getAllLikeWithUid:(NSString *)uid type:(NSString *)type{
    
    NSDictionary *dic = @{@"uid":uid,@"type":type};
    
    [[HttpService sharedInstance]getAllLike:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSMutableArray *ary = objdct;
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                LookLikeModel *model = [[LookLikeModel alloc]initWithDictionary:dic error:nil];
                
                if (model) {
                    
                    [dataArray addObject:model];
                }
            }
            
            if (_getAllLikeSuccess) {
                
                _getAllLikeSuccess(dataArray);
            }
            
        }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAllLikeFailure) {
            
            _getAllLikeFailure(responseString);
        }
        
    }];
}

- (void)getErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid{
    
    NSDictionary *dic = @{@"uid":uid,@"class_id":tid};
    
    [[HttpService sharedInstance]getErrorTitle:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {

            
            NSMutableArray *ary = objdct;
            
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
                ChapterPracticeModel *model = [[ChapterPracticeModel alloc]initWithDictionary:dic error:nil];
                
                if (model) {
                    
                    [dataArray addObject:model];
                }
            }

            if (_getErrorTitleSuccess) {
                
                _getErrorTitleSuccess(dataArray);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getErrorTitleFailure) {
            
            _getErrorTitleFailure(responseString);
        }
        
    }];

}

- (void)delErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid{
    
    NSDictionary *dic = @{@"token":uid,@"id":tid};
    
    [[HttpService sharedInstance]delErrorTitle:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            if (_delErrorSuccess) {
                
                _delErrorSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_delErrorFailure) {
            
            _delErrorFailure(responseString);
        }
        
    }];
    
}

- (void)getFirstRankingWithUid:(NSString *)uid timeType:(NSString *)timeType province:(NSString *)province type:(NSString *)tpe{
    
    self.rangkPageIndex = 1;

    
    [self.rankArray removeAllObjects];
    
    NSDictionary *dic = @{@"areaNo":uid,@"pageNO":@"1",@"adTypeId":timeType,@"filter":province};
    
    [self getRankingWithDic:dic type:tpe];
    
}

- (void)getMoreRankingWithUid:(NSString *)uid timeType:(NSString *)timeType province:(NSString *)province type:(NSString *)tpe{
    
    self.rangkPageIndex++;
    
    
    NSDictionary *dic = @{@"areaNo":uid,@"pageNO":[NSString stringWithFormat:@"%ld",self.rangkPageIndex],@"adTypeId":timeType,@"filter":province};
    
    [self getRankingWithDic:dic type:tpe];
    
}


- (void)getRankingWithDic:(NSDictionary *)dic type:(NSString *)tpe{
    
    
    
    [[HttpService sharedInstance]getRanking:dic type:tpe completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct;
            
            
                
               [self.rankArray addObjectsFromArray:dic[@"list"]];
            
                if (_getRankingSuccess) {
                    
                    _getRankingSuccess (self.rankArray,nil,type);
                }

            
        }
  
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getRankingFailure) {
            
            _getRankingFailure(responseString,type);
        }
        
    }];

}


@end

//
//  MineService.m
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MineService.h"

@implementation MineService


- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.pageIndex = 1;
        
        self.data = [@[]mutableCopy];
        
        
        self.couPonpageIndex = 1;
        self.couPonpagedata =[@[]mutableCopy];
    }
    return self;
}


+ (MineService *)shareInstanced
{
    static MineService     *this = nil;
    static dispatch_once_t  oneToken;
    
    dispatch_once(&oneToken, ^{
        
        this = [[self alloc]init];
        
    });
    
    return this;
}


#pragma mark

- (void)getMyFirstNewsWithUid:(NSString *)uid{
    
   [self.data removeAllObjects];
    
    self.pageIndex = 1;
    

    [self getMyNewsWithUid:uid];
    
}

- (void)getMyMoreNewsWithUid:(NSString *)uid{
    
    self.pageIndex++;
    
    [self getMyNewsWithUid:uid];
    
}

- (void)getMyNewsWithUid:(NSString *)uid
{
    NSDictionary *dic = @{@"token":uid,@"type":@1,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
    
    [[HttpService sharedInstance]getNews:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];

            
            [self.data addObjectsFromArray:ary];
            
            if (_getMyNewsSuccess) {
                
                _getMyNewsSuccess(self.data);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getMyNewsFailure) {
            
            _getMyNewsFailure(responseString);
        }
        
    }];

}

- (void)getFirstCoupenWithUid:(NSString *)uid{
    
    [self.couPonpagedata removeAllObjects];
    
    self.couPonpageIndex = 1;
    
    
    [self getCoupenWithUid:uid];
    
}
- (void)getMoreCoupenWithUid:(NSString *)uid{
    
    self.couPonpageIndex++;
    
    [self getCoupenWithUid:uid];
}

- (void)getCoupenWithUid:(NSString *)uid{
    
    NSDictionary *dic = @{@"token":uid,@"type":@0,@"pageNO":[NSString stringWithFormat:@"%ld",(long)self.couPonpageIndex]};
    
    [[HttpService sharedInstance]getCoupon:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSMutableArray *ary = object[@"list"];
            
//            NSMutableArray *dataArray = [NSMutableArray array];
//            
//            for (NSDictionary *dic in ary) {
//                
//                CouponModel *model = [[CouponModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model];
//                }
//            }
//            
            [self.couPonpagedata addObjectsFromArray:ary];
            
            if (_getCouponSuccess) {
                
                _getCouponSuccess(self.couPonpagedata);
            }
            
        }
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCouponFailure) {
            
            _getCouponFailure(responseString);
        }
        
    }];
    
}

- (void)delNewWithIds:(NSString *)ids{
    
    NSDictionary *dic = @{@"token":ids};
    
    [[HttpService sharedInstance]delNews:dic completionBlock:^(id object) {
        
        if (object) {
            

            if (_delMyNewsSuccess) {
                
                _delMyNewsSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_delMyNewsFailure) {
            
            _delMyNewsFailure(responseString);
        }
        
    }];

}

- (void)addAddressWithId:(NSString *)uid address:(NSString *)address type:(NSString *)type{
    
    NSDictionary *dic = @{@"token":uid,@"count":address,@"readname":type};
    
    [[HttpService sharedInstance]addAds:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_addAddressSuccess) {
                
                _addAddressSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_addAddressFailure) {
            
            _addAddressFailure(responseString);
        }
        
    }];
    
}

- (void)updateAddressWithDictionary:(NSDictionary *)dic{
    

    
    [[HttpService sharedInstance]updAds:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_updateAddressSuccess) {
                
                _updateAddressSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_updateAddressFailure) {
            
            _updateAddressFailure(responseString);
        }
        
    }];
}

- (void)getAllAddressWithUid:(NSDictionary *)dic{
    
 
    [[HttpService sharedInstance]allAds:dic completionBlock:^(id object) {
        
        if (object) {
            
                if (_getAllAddressSuccess) {
                    
                    _getAllAddressSuccess(object);
                }
            }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAllAddressFailure) {
            
            _getAllAddressFailure(responseString);
        }
        
    }];
}

- (void)delAddressWithIds:(NSDictionary *)dic{
    
    
    [[HttpService sharedInstance]delAds:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_delAddressSuccess) {
                
                _delAddressSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_delAddressFailure) {
            
            _delAddressFailure(responseString);
        }
        
    }];
}



- (void)getAgreement{
    
    [[HttpService sharedInstance]getAgreement:nil completionBlock:^(id object) {
        
        if (object) {
            
            NSDictionary *dic = object;
            
            if (_getAgreementSuccess) {
                
                _getAgreementSuccess(dic);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAgreementFailure) {
            
            _getAgreementFailure(responseString);
        }
        
    }];
    
    
}

- (void)getFeedBackWithUid:(NSString *)uid content:(NSString *)content{
    
     NSDictionary *dic = @{@"token":uid,@"content":content};
    
    [[HttpService sharedInstance]feedBack:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_getFeedBackSuccess) {
                
                _getFeedBackSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getFeedBackFailure) {
            
            _getFeedBackFailure(responseString);
        }
        
    }];
    
}

- (void)getFeedWithUid:(NSString *)uid content:(NSString *)content{
    
    NSDictionary *dic = @{@"token":uid,@"couponRecordId":content};
    
    [[HttpService sharedInstance]feed:dic completionBlock:^(id object) {
        
        if (object) {
            
            
            if (_getFeedSuccess) {
                
                _getFeedSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getFeedFailure) {
            
            _getFeedFailure(responseString);
        }
        
    }];
}

@end

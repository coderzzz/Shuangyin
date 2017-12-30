//
//  RankingUserModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@protocol  RankingUserModel@end

@interface RankingUserModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * uid;

@property (nonatomic, strong) NSString <Optional> * usetime;

@property (nonatomic, strong) NSString <Optional> * username;

@property (nonatomic, strong) NSString <Optional> * province;

@property (nonatomic, strong) NSString <Optional> * exam_score;

@property (nonatomic, strong) NSString <Optional> * ranking_id;

@end

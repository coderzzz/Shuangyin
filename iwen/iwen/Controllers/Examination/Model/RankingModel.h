//
//  RankingModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"
#import "RankingUserModel.h"
@interface RankingModel : JSONModel


@property (nonatomic, strong) NSArray <Optional,RankingUserModel> *Ranking;

@property (nonatomic, strong) NSString <Optional> * ranking_id;

@end

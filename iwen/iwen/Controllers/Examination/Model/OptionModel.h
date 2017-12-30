//
//  OptionModel.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@protocol OptionModel @end

@interface OptionModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * tid;

@property (nonatomic, strong) NSString <Optional> * id;

@property (nonatomic, strong) NSString <Optional> * content;

@property (nonatomic, strong) NSString <Optional> * weight;

@property (nonatomic, strong) NSString <Optional> * status;

@property (nonatomic, strong) NSString <Optional> * is_answer;

/************************************      *************************************************/

@property (nonatomic, strong) NSString <Optional> * isSelect;



@end

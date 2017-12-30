//
//  Choose.h
//  iwen
//
//  Created by Interest on 15/11/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Subject;

@interface Choose : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * tid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * is_answer;
@property (nonatomic, retain) NSString * isSelect;
@property (nonatomic, retain) NSNumber * disPlayOrder;
@property (nonatomic, retain) Subject *subject;

@end

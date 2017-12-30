//
//  Subject.h
//  iwen
//
//  Created by Interest on 15/11/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choose;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * likeStatue;
@property (nonatomic, retain) NSString * courseId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * ismulti;
@property (nonatomic, retain) NSString * analysis;
@property (nonatomic, retain) NSString * isFinsh;
@property (nonatomic, retain) NSString * examId;
@property (nonatomic, retain) NSString * answerString;
@property (nonatomic, retain) NSNumber * disPlayOrder;
@property (nonatomic, retain) NSSet *chooses;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addChoosesObject:(Choose *)value;
- (void)removeChoosesObject:(Choose *)value;
- (void)addChooses:(NSSet *)values;
- (void)removeChooses:(NSSet *)values;

@end

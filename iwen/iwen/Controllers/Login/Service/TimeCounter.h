//
//  TimeCounter.h
//  ZhuZhu
//
//  Created by Carl on 15/2/3.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CountBlock)(int counter);
@interface TimeCounter : NSObject
@property(nonatomic,assign) int counter;
@property(nonatomic,strong) NSTimer * timer;
@property(nonatomic,strong) NSBlockOperation * operation;
@property(nonatomic,copy) CountBlock countBlock;
- (id)initWithCounter:(int)counter;
- (void)start;
- (void)stop;
- (void)destory;
@end

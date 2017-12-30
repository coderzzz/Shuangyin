//
//  TimeCounter.m
//  ZhuZhu
//
//  Created by Carl on 15/2/3.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "TimeCounter.h"

@implementation TimeCounter

- (id)initWithCounter:(int)counter
{
    if((self = [super init])) {
        self.counter = counter;
    }
    return self;
}


- (void)createTimerWithInterval:(int)interval
{
    _operation = [NSBlockOperation blockOperationWithBlock:^{
        _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture] interval:interval target:self selector:@selector(count:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }];
    [_operation start];
}

- (void)start
{
    [self createTimerWithInterval:1];
    [_timer setFireDate:[NSDate date]];
    [_timer fire];
}

- (void)stop
{
    if(_timer != nil && [_timer isValid])
    {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)destory
{
    [_timer invalidate];
    _timer = nil;
    [_operation cancel];
    _operation = nil;
}

- (void)count:(NSTimer *)timer
{
    if(_counter <= 0)
    {
        [self destory];
        return ;
    }
    
    _counter = _counter - 1;
    if(_countBlock) _countBlock(_counter);
}

@end

//
//  TimerView.m
//  iwen
//
//  Created by Interest on 15/11/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "TimerView.h"

@implementation TimerView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.lable.textAlignment = NSTextAlignmentCenter;
        
        self.lable.font    = [UIFont systemFontOfSize:12];
        
        self.lable.textColor = [UIColor whiteColor];
        
        [self addSubview:self.lable];
        
        self.lable.text = @"00:00:00";
        
        self.userInteractionEnabled = YES;
        
//        [self startTime];
       
    }
    
    return self;
}

- (void)startTime{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(next) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
     self.beginDate = [NSDate date];
}

- (void)next{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    
    NSDate *nowdate = [NSDate date];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    unsigned int unitFlags=NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:self.beginDate toDate:nowdate options:0];
    
    NSString *hour =[NSString stringWithFormat:@"%ld",[d hour]];
    
    if ([d hour]<10) {
        
        hour = [NSString stringWithFormat:@"0%ld",[d hour]];
        
    }
    
    NSString *min =[NSString stringWithFormat:@"%ld",[d minute]];
    
    if ([d minute]<10) {
        
        min = [NSString stringWithFormat:@"0%ld",[d minute]];
        
    }
    
    NSString *second =[NSString stringWithFormat:@"%ld",[d second]];
    
    if ([d second]<10) {
        
        second = [NSString stringWithFormat:@"0%ld",[d second]];
        
    }
   
    self.lable.text = [NSString stringWithFormat:@"%@:%@:%@",hour,min,second];
    


}


- (void)stopTimer{
    
    [self.timer invalidate];
    
    self.timer = nil;
}


@end

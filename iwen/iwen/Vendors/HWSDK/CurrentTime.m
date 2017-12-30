//
//  CurrentTime.m
//  Hisea
//
//  Created by GZInterest on 14-10-20.
//  Copyright (c) 2014年 GZInterest. All rights reserved.
//

#import "CurrentTime.h"

@implementation CurrentTime

-(NSString*)lessThanTen:(NSInteger)number{
    NSString* str;
    if (number < 10) {
        str = [NSString stringWithFormat:@"0%d",(int)number];
    }else{
        str = [NSString stringWithFormat:@"%d",(int)number];
    }
    return str;
}

-(void)getTimeInfoWithDate:(NSDate*)date CurrentTime:(CurrentTime*)currentTime
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* comps;
    
    // 年月日获得
    
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
            
                       fromDate:date];
    
    currentTime.year = [currentTime lessThanTen:[comps year]];
    
    currentTime.month = [currentTime lessThanTen:[comps month]];
    
    currentTime.day = [currentTime lessThanTen:[comps day]];
    
    //    NSLog(@"year:%@ month: %@, day: %@", currentTime.year, currentTime.month, currentTime.day);
    
    
    
    //当前的时分秒获得
    
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
            
                       fromDate:date];
    
    currentTime.hour = [currentTime lessThanTen:[comps hour]];
    
    currentTime.minute = [currentTime lessThanTen:[comps minute]];
    
    currentTime.second = [currentTime lessThanTen:[comps second]];
    
    //    NSLog(@"hour:%@ minute: %@, second: %@", currentTime.hour, currentTime.minute, currentTime.second);
    
    
    
    // 周几和星期几获得
    
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
            
                       fromDate:date];
    
    currentTime.week = [NSString stringWithFormat:@"%ld",(long)[comps weekOfYear]]; // 今年的第几周
    
    NSString* str;
    switch ([comps weekday]) {  // 星期几（注意，周日是“1”，周一是“2”。。。。）
        case 1: str = @"星期日"; break;
        case 2: str = @"星期一"; break;
        case 3: str = @"星期二"; break;
        case 4: str = @"星期三"; break;
        case 5: str = @"星期四"; break;
        case 6: str = @"星期五"; break;
        case 7: str = @"星期六"; break;
    }
    
    
    currentTime.weekday = str;
    
    currentTime.weekdayOrdinal = [NSString stringWithFormat:@"%ld",(long)[comps weekdayOrdinal]]; // 这个月的第几周
}

+(CurrentTime*)shareCurrentTime{
    NSDate* date = [NSDate date];
    
    CurrentTime* currentTime = [[CurrentTime alloc]init];
    [currentTime getTimeInfoWithDate:date CurrentTime:currentTime];
    
    return currentTime;
}

-(CurrentTime*)initWithDate:(NSDate *)date
{
    CurrentTime* currentTime = [[CurrentTime alloc]init];
    [self getTimeInfoWithDate:date CurrentTime:currentTime];
    
    return currentTime;
}

+(NSString*)getExactTimeWith:(CurrentTime*)timeInfo{
    NSString* exactTime;
    int differenceCount = 0;
    CurrentTime* currentTime = [CurrentTime shareCurrentTime];
    
    if ([currentTime.year isEqualToString:timeInfo.year]) { //今年
        if ([currentTime.month isEqualToString:timeInfo.month]) {   //今月
            if ([currentTime.weekdayOrdinal isEqualToString:timeInfo.weekdayOrdinal]) {   //本周
                if ([currentTime.day isEqualToString:timeInfo.day]) {   //今日
                    exactTime = [NSString stringWithFormat:@"%@:%@",timeInfo.hour,timeInfo.minute];
                }else{  //不是今日
                    differenceCount = [currentTime.day intValue] - [timeInfo.day intValue];
                    switch (differenceCount) {
                        case 1: exactTime = [NSString stringWithFormat:@"昨天 %@:%@",timeInfo.hour,timeInfo.minute]; break;
                        default: exactTime = [NSString stringWithFormat:@"%@ %@:%@",timeInfo.weekday,timeInfo.hour,timeInfo.minute]; break;
                    }
                }
            }else{  //不是本周
                //exactTime = [NSString stringWithFormat:@"%@-%@ %@:%@",timeInfo.month,timeInfo.day,timeInfo.hour,timeInfo.minute];
                exactTime = [NSString stringWithFormat:@"%@-%@",timeInfo.month,timeInfo.day];
            }
        }else{  //不是今月
            //exactTime = [NSString stringWithFormat:@"%@-%@ %@:%@",timeInfo.month,timeInfo.day,timeInfo.hour,timeInfo.minute];
            exactTime = [NSString stringWithFormat:@"%@-%@",timeInfo.month,timeInfo.day];
        }
    }else{  //不是今年
        //exactTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",timeInfo.year,timeInfo.month,timeInfo.day,timeInfo.hour,timeInfo.minute];
        exactTime = [NSString stringWithFormat:@"%@-%@-%@",timeInfo.year,timeInfo.month,timeInfo.day];
    }
    
    return exactTime;
}



@end

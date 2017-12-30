//
//  CurrentTime.h
//  Hisea
//
//  Created by GZInterest on 14-10-20.
//  Copyright (c) 2014年 GZInterest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentTime : NSObject

@property (nonatomic,strong) NSString* year;
@property (nonatomic,strong) NSString* month;
@property (nonatomic,strong) NSString* day;
@property (nonatomic,strong) NSString* hour;
@property (nonatomic,strong) NSString* minute;
@property (nonatomic,strong) NSString* second;
@property (nonatomic,strong) NSString* week;
@property (nonatomic,strong) NSString* weekday;
@property (nonatomic,strong) NSString* weekdayOrdinal;

+(CurrentTime*)shareCurrentTime;
-(CurrentTime*)initWithDate:(NSDate*)date;
+(NSString*)getExactTimeWith:(CurrentTime*)timeInfo;
@end

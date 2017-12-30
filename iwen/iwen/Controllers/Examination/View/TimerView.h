//
//  TimerView.h
//  iwen
//
//  Created by Interest on 15/11/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerView : UIView

@property (nonatomic,strong) UILabel * lable;

@property (nonatomic,strong) NSTimer * timer;

@property (nonatomic,strong) NSDate  * beginDate;

- (void)stopTimer;

- (void)startTime;


@end

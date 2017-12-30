//
//  GDView.m
//  iwen
//
//  Created by sam on 2017/3/24.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import "GDView.h"

@implementation GDView
{
    UILabel *label1;
    UILabel *label2;
    dispatch_source_t timer1;
    NSTimer *timer;
    BOOL wichOne;
    int count;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label1.font = [UIFont systemFontOfSize:13];
        [self addSubview:label1];
        
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
         label2.font = [UIFont systemFontOfSize:13];
        [self addSubview:label2];
        

    }
    return self;
}

- (void)timer{
    
    
}

- (void)setTurnArray:(NSArray *)turnArray {
    
    
    _turnArray = turnArray;
    count = 1;
    if (_turnArray.count == 0) {
        return;
    }
    if (_turnArray.count == 1) {
//        label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label1.text = _turnArray[0];
//        [self addSubview:label1];
    }else{
//        label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label1.text = _turnArray[0];
//        [self addSubview:label1];
        
//        label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        label2.text = _turnArray[1];
//        [self addSubview:label2];
        
        
        if (timer1) {
            
            dispatch_source_cancel(timer1);
        }
        
        timer1= dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(timer1, DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer1, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                count++;
                if (count>_turnArray.count-1) {
                    count = 0;
                }
                [UIView animateWithDuration:0.3 animations:^{
                    if (!wichOne) {
                        label1.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
                        label2.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                    }
                    if (wichOne) {
                        label1.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                        label2.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
                    }
                } completion:^(BOOL finished) {
                    wichOne = !wichOne;
                    if ((int)label1.frame.origin.y==-self.frame.size.height) {
                        label1.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
                        label1.text = _turnArray[count];
                    }
                    if ((int)label2.frame.origin.y==-self.frame.size.height) {
                        label2.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
                        label2.text = _turnArray[count];
                    }
                }];
            });
            
        });
        dispatch_resume(timer1);
//        if (timer) {
//            
//            [timer fire];
//            timer = nil;
//        }
//        timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timer)
//                                               userInfo:@"aaaa" repeats:YES];
    }
}

@end

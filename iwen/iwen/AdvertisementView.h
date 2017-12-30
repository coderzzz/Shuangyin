//
//  AdvertisementView.h
//  iwen
//
//  Created by Interest on 15/10/19.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertisementViewDelegate <NSObject>

@optional

- (void)didTapImageViewAtIndex:(NSInteger )index;


@end


@interface AdvertisementView : UIScrollView<UIScrollViewDelegate>


@property (nonatomic, weak)    id<AdvertisementViewDelegate>dele;

@property (nonatomic, strong)  NSMutableArray *urlArray;

@property (nonatomic, strong)  NSTimer        *timer;

-(void)stopTimer;
- (void)startTime;
@end

//
//  CustomUserGuideScrollView.h
//  HWSDK
//
//  Created by Carl on 14-1-12.
//  Copyright (c) 2014年 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUserGuideScrollView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;

@property (nonatomic, assign) BOOL   fin;

- (id)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames isShowPage:(BOOL)isShow;
- (void)finish:(BOOL)animted;
@end

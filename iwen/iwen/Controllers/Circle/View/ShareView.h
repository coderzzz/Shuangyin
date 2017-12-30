//
//  ShareView.h
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareView;

@protocol ZZShareViewDelegate <NSObject>

@optional

- (void)shareView:(ShareView *)shareView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface ShareView : UIView

@property (nonatomic,weak) id<ZZShareViewDelegate> delegate;

@property (nonatomic,assign) BOOL   isShowing;

@property (nonatomic,strong) UIView *buttonView;

- (void)dismiss;


- (void)showInView:(UIView *)view;



@end

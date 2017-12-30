//
//  SignInViewController.h
//  ZhuZhu
//
//  Created by GZInterest on 15/2/5.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "CommonViewController.h"

@protocol SignInViewControllerDelegate <NSObject>

@optional

- (void)didSelectWithCoordinate:(NSString *)str;


@end

@interface SignInViewController : BaseViewController
@property (nonatomic, weak) id<SignInViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *coord;

@end

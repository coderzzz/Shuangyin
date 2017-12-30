//
//  CoupenViewController.h
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@protocol CoupenViewControllerDelegate <NSObject>

@optional

- (void)didSelectCoupenId:(NSString *)coupenId;

@end

@interface CoupenViewController : BaseViewController

@property (weak, nonatomic) id<CoupenViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collecview;
@property (nonatomic,assign) NSString       *tourist;

@end

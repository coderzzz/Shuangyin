//
//  LearnMainViewController.h
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearnMainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collecview;

@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (copy, nonatomic) NSString *city;


@end

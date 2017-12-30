//
//  ExamCardViewController.h
//  iwen
//
//  Created by Interest on 15/11/2.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@protocol ExamCardViewControllerDelegate <NSObject>

@optional

- (void)didSelectItemWithIndex:(NSUInteger)index;

@end


@interface ExamCardViewController : BaseViewController

@property (weak, nonatomic) id <ExamCardViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectview;

@property (nonatomic,strong) NSMutableArray *dataSource;




@end

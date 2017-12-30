//
//  ForumViewController.h
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface ForumViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collecview;

@property (strong,nonatomic) CircleListModel *model;

@end

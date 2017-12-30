//
//  RecordViewController.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *recordView;

@property (weak, nonatomic) IBOutlet UICollectionView *collecRecordView;


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *recordflow;


@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (copy, nonatomic) NSString *adid;

// 1 hongbao ,2 putong
@property (copy, nonatomic) NSString *type;
@end

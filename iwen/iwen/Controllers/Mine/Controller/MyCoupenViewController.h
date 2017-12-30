//
//  MyCoupenViewController.h
//  iwen
//
//  Created by Interest on 16/7/2.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface MyCoupenViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIView *perView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segm;
- (IBAction)segAction:(UISegmentedControl *)sender;

@end

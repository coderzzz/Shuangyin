//
//  ReViewController.h
//  iwen
//
//  Created by sam on 16/7/3.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface ReViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UITextField *text;

@property (nonatomic, copy) NSString *word;

@property (weak, nonatomic) IBOutlet UIView *topVIew;

@property (copy, nonatomic) NSString *city;
@property (strong, nonatomic) CircleListModel *model;

@property (strong, nonatomic) IBOutlet UIView *pullView;

@property (weak, nonatomic) IBOutlet UITableView *pullTable;
- (IBAction)hidepull:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

//
//  WeicoViewController.h
//  iwen
//
//  Created by Interest on 16/3/11.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface WeicoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

//1,旗袍说，2，我的旗袍说
@property (copy, nonatomic) NSString *type;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;


- (IBAction)segAction:(id)sender;



@end

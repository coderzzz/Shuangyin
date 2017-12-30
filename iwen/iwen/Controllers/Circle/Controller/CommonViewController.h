//
//  CommonViewController.h
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface CommonViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *buttomView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic,strong) NSString *newsId;

- (IBAction)sendAction:(id)sender;

@end

//
//  LearnDetailViewController.h
//  iwen
//
//  Created by Interest on 15/11/6.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface LearnDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSString *cid;

@property (strong, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *subLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (nonatomic,assign) NSString       *tourist;

@property (weak, nonatomic) IBOutlet UIToolbar *toobar;


@end

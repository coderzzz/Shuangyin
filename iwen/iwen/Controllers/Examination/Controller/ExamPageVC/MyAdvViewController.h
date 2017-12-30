//
//  MyAdvViewController.h
//  iwen
//
//  Created by Interest on 16/3/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface MyAdvViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (nonatomic, copy) NSString *adid;
@property (strong, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@property (weak, nonatomic) IBOutlet UILabel *lab;



@end

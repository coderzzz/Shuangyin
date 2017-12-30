//
//  containViewController.h
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

@protocol ContainViewControllerDelegate <NSObject>


@end


#import "BaseViewController.h"


@interface containViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic) id data;

@property (nonatomic,strong) NSString *examType;

@end

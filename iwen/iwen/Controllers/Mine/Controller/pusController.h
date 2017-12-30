//
//  pusController.h
//  iwen
//
//  Created by sam on 16/10/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface pusController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *token;


@end

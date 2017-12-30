//
//  MySaveViewController.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface MySaveViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, copy) NSString *recity;
@property (nonatomic, copy) NSString *city;
//
////类型(0--收藏 1--错题)
//@property (strong, nonatomic) NSString *type;
//
//
//@property (nonatomic,assign) NSString       *tourist;
@end

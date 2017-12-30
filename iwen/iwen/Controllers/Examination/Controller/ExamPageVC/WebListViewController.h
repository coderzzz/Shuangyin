//
//  WebListViewController.h
//  iwen
//
//  Created by Carl on 15/11/18.
//  Copyright © 2015年 Interest. All rights reserved.
//
@protocol WebDele <NSObject>

@optional
-(void)did:(CircleListModel *)mod;

@end
#import "BaseViewController.h"

@interface WebListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic)id<WebDele>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITableView *tableview2;


@end

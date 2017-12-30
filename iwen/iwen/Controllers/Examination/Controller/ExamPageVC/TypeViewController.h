//
//  TypeViewController.h
//  iwen
//
//  Created by Interest on 16/3/4.
//  Copyright © 2016年 Interest. All rights reserved.
//

@protocol TypeViewControllerDelegate <NSObject>

@optional

- (void)didSelectDic:(NSDictionary *)dic;


@end

#import "BaseViewController.h"



@interface TypeViewController : BaseViewController

@property (weak, nonatomic) id <TypeViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableview;




@end

//
//  CityViewController.h
//  iwen
//
//  Created by Interest on 16/3/5.
//  Copyright © 2016年 Interest. All rights reserved.
//

@protocol CityViewControllerDelegate <NSObject>

@optional

- (void)didSelectCityWithdic:(NSDictionary *)dic;


@end

#import "BaseViewController.h"

@interface CityViewController : BaseViewController

@property (weak, nonatomic) id<CityViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *table1;

@property (weak, nonatomic) IBOutlet UITableView *table2;

@property (weak, nonatomic) IBOutlet UITableView *table3;

@end

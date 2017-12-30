//
//  ApplyViewController.h
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface ApplyViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIView *headview;

@property (strong, nonatomic) IBOutlet UIView *footview;

@property (weak, nonatomic) IBOutlet UIButton *logobtn;

- (IBAction)logoAciton:(UIButton *)sender;

- (IBAction)upAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

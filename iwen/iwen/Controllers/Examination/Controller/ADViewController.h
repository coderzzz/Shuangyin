//
//  ADViewController.h
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface ADViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UILabel *lab1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIImageView *imgv;

- (IBAction)btn1Action:(UIButton *)sender;

- (IBAction)btn2Action:(UIButton *)sender;











@end

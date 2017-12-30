//
//  MyreCell.h
//  iwen
//
//  Created by sam on 16/10/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyreCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *oldpri;
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UILabel *blue;
@property (weak, nonatomic) IBOutlet UILabel *clicklab;

@property (weak, nonatomic) IBOutlet UIButton *rebtn;



@end

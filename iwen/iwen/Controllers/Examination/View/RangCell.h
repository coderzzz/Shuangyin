//
//  RangCell.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *scoreLab;


@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *one;


@end

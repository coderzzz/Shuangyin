//
//  Exam0ptionCell.h
//  iwen
//
//  Created by Interest on 15/10/30.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exam0ptionCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *lab;

- (void)btnBorderColorWitch:(UIColor *)color;

@end

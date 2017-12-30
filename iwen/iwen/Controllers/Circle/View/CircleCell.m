//
//  CircleCell.m
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

- (void)awakeFromNib {
    
    self.selectionStyle           = UITableViewCellSelectionStyleNone;
    

    self.lineLab.backgroundColor  = SeparatorColor;
    self.lineLab.frame            = CGRectMake(0, 99, ScreenWidth, 1/[UIScreen mainScreen].scale);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

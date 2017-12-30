//
//  RangCell.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RangCell.h"

@implementation RangCell

- (void)awakeFromNib {
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lineLab.backgroundColor = SeparatorColor;
    
    self.one.constant            = 1/[UIScreen mainScreen].scale;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  BlogContenCell.m
//  iwen
//
//  Created by Interest on 15/11/6.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BlogContenCell.h"

@implementation BlogContenCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.contenLab.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LearningCell.m
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LearningCell.h"

@implementation LearningCell

- (void)awakeFromNib {
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineLab.backgroundColor = SeparatorColor;
    self.imgv.layer.masksToBounds = YES;
    self.onePixelHeightConstraint.constant = 1/[UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AnswerCell.m
//  iwen
//
//  Created by Interest on 15/11/3.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AnswerCell.h"

@implementation AnswerCell

- (void)awakeFromNib {
    
    self.lineLab.backgroundColor = SeparatorColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AnalysisCell.m
//  iwen
//
//  Created by Interest on 15/11/3.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AnalysisCell.h"

@implementation AnalysisCell

- (void)awakeFromNib {
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.title.textColor = BaseColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

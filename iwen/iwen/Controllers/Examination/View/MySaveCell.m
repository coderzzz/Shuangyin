//
//  MySaveCell.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MySaveCell.h"

@implementation MySaveCell

- (void)awakeFromNib {
   
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = BackgroundColor;
    
    self.topLine.backgroundColor = BaseColor;
    
    self.buttomLine.backgroundColor = BaseColor;
    
    self.lineLab.backgroundColor = SeparatorColor;
    
    self.one.constant            = 1/[UIScreen mainScreen].scale;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

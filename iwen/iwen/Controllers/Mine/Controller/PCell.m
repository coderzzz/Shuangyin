//
//  PersonCell.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "PCell.h"

@implementation PCell

- (void)awakeFromNib {
   
    self.selectionStyle                = UITableViewCellSelectionStyleNone;
    self.headimage.layer.masksToBounds = YES;
    self.headimage.layer.cornerRadius  = self.headimage.bounds.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

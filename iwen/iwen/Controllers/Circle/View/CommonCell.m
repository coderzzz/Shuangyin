//
//  CommonCell.m
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

- (void)awakeFromNib {
    
    
    self.imgv.layer.masksToBounds = YES;
    self.imgv.layer.cornerRadius  = self.imgv.bounds.size.width/2;
    
    self.selectionStyle   = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

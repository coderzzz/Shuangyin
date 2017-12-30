//
//  MainCell.m
//  iwen
//
//  Created by Interest on 15/10/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    
    self.headImgv.layer.masksToBounds = YES;
    self.headImgv.layer.cornerRadius = self.headImgv.bounds.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  UserListCell.m
//  iwen
//
//  Created by sam on 16/8/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "UserListCell.h"

@implementation UserListCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.ageLab.layer.masksToBounds = YES;
    self.ageLab.layer.cornerRadius = 3;
    
    self.sexLab.layer.masksToBounds = YES;
    self.sexLab.layer.cornerRadius = 3;
    
    self.counLab.layer.masksToBounds = YES;
    self.counLab.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  PutOnCell.m
//  iwen
//
//  Created by sam on 16/1/25.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "PutOnCell.h"

@implementation PutOnCell

- (void)awakeFromNib {
   
    self.imgv.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MyreCell.m
//  iwen
//
//  Created by sam on 16/10/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyreCell.h"

@implementation MyreCell

- (void)awakeFromNib {
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.rebtn.layer.masksToBounds = YES;
    self.rebtn.layer.cornerRadius = 5;
    self.rebtn.layer.borderWidth = 1;
    self.rebtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

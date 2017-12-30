//
//  CoupenCell.m
//  iwen
//
//  Created by sam on 16/6/30.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "CoupenCell.h"

@implementation CoupenCell

- (void)awakeFromNib {
    
    [self insertSubview:self.bgimgv atIndex:0];
    self.imgv.layer.masksToBounds = YES;
    self.imgv.layer.cornerRadius = self.imgv.frame.size.width/2;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

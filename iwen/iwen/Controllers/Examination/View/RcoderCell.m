//
//  RcoderCell.m
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RcoderCell.h"
#define BgColor [UIColor colorWithRed:235.0/255.0 green:236.0/255.0 blue:237.0/255.0 alpha:1]
@implementation RcoderCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor   = BgColor;
    
    self.onePixConstraint.constant = 1/[UIScreen mainScreen].scale;
    
    self.one.constant = 1/[UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)BtnAction:(id)sender {
    
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rcoderCell:didSelectButtonType:)]) {
        
        [self.delegate rcoderCell:self didSelectButtonType:(RcoderCellButtonType)btn.tag];
    }
    
}
@end

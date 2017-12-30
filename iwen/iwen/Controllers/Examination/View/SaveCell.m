//
//  SaveCell.m
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "SaveCell.h"

#define BgColor [UIColor colorWithRed:248.0/255.0 green:249.0/255.0 blue:250.0/255.0 alpha:1]

@implementation SaveCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.butomLine.backgroundColor = SeparatorColor;
    
    self.centerLine.backgroundColor = SeparatorColor;
    
    self.backgroundColor   = BgColor;
    
    self.onePixConstraint.constant = 1/[UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveCell:didSelectButtonType:)]) {
        
        [self.delegate saveCell:self didSelectButtonType:(SaveCellButtonType)btn.tag];
    }
    
}
@end

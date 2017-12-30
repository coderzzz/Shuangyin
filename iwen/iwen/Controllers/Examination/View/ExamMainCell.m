//
//  ExamMainCell.m
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamMainCell.h"



@implementation ExamMainCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    self.onePixConstraint.constant = 1/[UIScreen mainScreen].scale;
    
    self.one.constant = 1/[UIScreen mainScreen].scale;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(examTap:)];
    
    [self.imgv addGestureRecognizer:tap];

}



- (IBAction)btnAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(examMainCell:didSelectButtonType:)]) {
        
        [self.delegate examMainCell:self didSelectButtonType:(ExamMainCellButtonType)btn.tag];
    }
    
}

- (IBAction)examTap:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(examMainCell:didSelectButtonType:)]) {
        
        [self.delegate examMainCell:self didSelectButtonType:ExamMainCellFormalExam];
    }
}
- (IBAction)pressAction:(UIButton *)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(examMainCell:didSelectButtonType:)]) {
        
        [self.delegate examMainCell:self didSelectButtonType:(ExamMainCellButtonType)btn.tag];
    }
}
@end

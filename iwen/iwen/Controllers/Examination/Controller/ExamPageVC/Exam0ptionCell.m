//
//  Exam0ptionCell.m
//  iwen
//
//  Created by Interest on 15/10/30.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "Exam0ptionCell.h"

@implementation Exam0ptionCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
   
}

- (void)btnBorderColorWitch:(UIColor *)color
{
    
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = self.btn.bounds.size.width/2;
    
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = [color CGColor];
}

@end

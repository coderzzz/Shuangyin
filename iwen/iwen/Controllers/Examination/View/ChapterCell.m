//
//  ChapterCell.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ChapterCell.h"

@implementation ChapterCell

- (void)awakeFromNib {
   
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

    
    self.lineLab.backgroundColor = SeparatorColor;
    
    self.one.constant  = 1/[UIScreen mainScreen].scale;
}



@end

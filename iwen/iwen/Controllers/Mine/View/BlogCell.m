//
//  BlogCell.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BlogCell.h"

#define CellBackGroundColor [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0]
#define DarkViewBackGroundColor [UIColor colorWithWhite:0.4 alpha:0.4]
@implementation BlogCell

- (void)awakeFromNib {
    
    self.layer.masksToBounds          = YES;
    self.layer.cornerRadius           = 4.0;
    ;
//    self.backgroundColor              = CellBackGroundColor;
    
    self.headimgv.layer.masksToBounds = YES;
    self.headimgv.layer.cornerRadius  = self.headimgv.bounds.size.width/2;
    self.imgv.contentMode             = UIViewContentModeScaleAspectFill;
    self.darkView.backgroundColor     = DarkViewBackGroundColor;
    
}

@end

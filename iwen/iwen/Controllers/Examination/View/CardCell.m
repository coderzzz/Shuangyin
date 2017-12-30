//
//  CardCell.m
//  iwen
//
//  Created by Interest on 15/11/2.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib {
   
    self.lab.layer.masksToBounds = YES;
    self.lab.layer.cornerRadius = self.lab.bounds.size.width/2;
    
    self.lab.layer.borderWidth = 1;
    self.lab.layer.borderColor = [BaseColor CGColor];
}






@end

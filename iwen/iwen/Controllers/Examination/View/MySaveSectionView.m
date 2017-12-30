//
//  MySaveSectionView.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MySaveSectionView.h"

@implementation MySaveSectionView

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        
      
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MySaveSectionView" owner:self options:nil];
        
        self = [arrayOfViews objectAtIndex:0];
        
        self.topLineLab.backgroundColor = SeparatorColor;
        
        self.topOne.constant            = 1/[UIScreen mainScreen].scale;
        
        self.buttomLine.backgroundColor = SeparatorColor;
        
        self.buttomOne.constant         = 1/[UIScreen mainScreen].scale;
        
        self.lineLab.backgroundColor    = BaseColor;
        
        self.topLineLab.hidden = YES;
//        self.buttomLine.hidden = YES;
        
    
        
        }
    
    return self;
    
}

@end

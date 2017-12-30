//
//  ExamSectionView.m
//  iwen
//
//  Created by Interest on 15/10/30.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamSectionView.h"

@implementation ExamSectionView

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"ExamSectionView" owner:self options:nil] firstObject];
        
    }
    
    return self;
}

@end

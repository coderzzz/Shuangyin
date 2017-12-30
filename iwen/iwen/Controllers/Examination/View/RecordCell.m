//
//  RecordCell.m
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

- (void)awakeFromNib {
   
    self.lineLab.backgroundColor = SeparatorColor;
    
   
}


- (void)setModel:(NSDictionary *)model{
    
    if (model) {
        
        _model = model;
        
        [self updateUi];
        
    }
}

- (void)updateUi{
    
//    if ([self.model.sumnum intValue]>=100) {
//        
//        self.baseView.frame = CGRectMake(15, 10, 30, 190);
//        
//        CGFloat h = [self.model.correctnum floatValue]/[self.model.sumnum floatValue]*190;
//        
//        
//        self.buttomView.frame = CGRectMake(0, 190-h, 30, h);
//        
//    }
//    
////    else if ([self.model.sumnum intValue]>=50 && [self.model.sumnum intValue]<100) {
////        
////        NSLog(@"ddd");
//    
////    }
//    else{
//        
        CGFloat topH = [self.model[@"clickCount"] intValue]*10;
        if (topH>=200) {
            topH =200;
        }
    
        self.baseView.frame = CGRectMake(15, 200-topH+20, 30, topH);
        self.click.text = [NSString stringWithFormat:@"%@",self.model[@"clickCount"]];
        self.click.frame =CGRectMake(0, 200-topH, 60, 21);

    
}


@end

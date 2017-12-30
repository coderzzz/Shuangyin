//
//  PayView.m
//  iwen
//
//  Created by Interest on 15/11/11.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "PayView.h"

@implementation PayView

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil] firstObject];
        
        [self setUpUi];
    }
    
    return self;
}

- (void)setUpUi{
    

    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    
    self.TitleView.backgroundColor = BackgroundColor;
    
    self.feeLab.textColor  = [UIColor colorWithRed:253.0/255.0 green:79.0/255.0 blue:95.0/255.0 alpha:1];
    
    
    
}


- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 1 || sender.tag == 2 || sender.tag == 3 || sender.tag == 4 || sender.tag == 5 || sender.tag == 6 || sender.tag == 7 || sender.tag == 8 || sender.tag == 9) {
        
        [self.leftBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.cenBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.rightBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.bomLeftBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.bomCenterBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.bomRightBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.tkLeftBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.tkCenterBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [self.tkRightBtn setImage:[UIImage imageNamed:@"椭圆-6-拷贝-4"] forState:UIControlStateNormal];
        
        [sender setImage:[UIImage imageNamed:@"初级"] forState:UIControlStateNormal];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressBtnWithTag:)]) {
        
        [self.delegate didPressBtnWithTag:sender.tag];
    }
    
}
@end

//
//  MnVIew.m
//  iwen
//
//  Created by Interest on 15/12/1.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import "MnVIew.h"

@implementation MnVIew

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"MnView" owner:self options:nil] firstObject];
        
        [self setUpUi];
    }
    
    return self;
}

- (void)setUpUi{
    
     self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];

}
- (IBAction)BtnAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapBtnWithTag:)]) {
        
        [self.delegate didTapBtnWithTag:btn.tag];
    }
}
@end

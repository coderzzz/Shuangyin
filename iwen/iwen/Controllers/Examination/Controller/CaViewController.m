//
//  CaViewController.m
//  iwen
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "CaViewController.h"

@interface CaViewController ()

@end

@implementation CaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.caId.length>0) {
        
        [[ExamService shareInstenced]savePracticeWithJsonString:self.caId time:nil];
        [ExamService shareInstenced].savePracticeSuccess = ^(id obj){
            NSString *coneten = [NSString stringWithFormat:@"%@",obj[@"fcontent"]];
            
            NSData *data = [coneten dataUsingEncoding:NSUTF8StringEncoding];
            NSAttributedString *att = [[NSAttributedString alloc]initWithHTMLData:data documentAttributes:nil];
            self.textview.attributedString = att;
            
        };
    }
    
    // Do any additional setup after loading the view from its nib.
}




@end

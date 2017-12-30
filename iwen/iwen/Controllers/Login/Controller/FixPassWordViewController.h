//
//  FixPassWordViewController.h
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixPassWordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *passWordField;


@property (weak, nonatomic) IBOutlet UITextField *secPWField;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;


@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *mycode;

- (IBAction)doneAction:(id)sender;

@property (nonatomic, strong) NSString *isTourist;



@end

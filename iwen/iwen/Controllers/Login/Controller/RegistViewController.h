//
//  RegistViewController.h
//  iwen
//
//  Created by Interest on 15/10/9.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UITextField *wordField;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (weak, nonatomic) IBOutlet UIButton *txtBtn;

@property (copy, nonatomic) NSString *type;

@property (nonatomic, strong) NSString *isTourist;
@property (weak, nonatomic) IBOutlet UIView *bumView;



- (IBAction)getWordAction:(id)sender;

- (IBAction)nextAction:(id)sender;

- (IBAction)checkAction:(id)sender;

- (IBAction)txtAction:(id)sender;





@end

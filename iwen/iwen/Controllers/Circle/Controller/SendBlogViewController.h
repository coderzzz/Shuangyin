//
//  SendBlogViewController.h
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface SendBlogViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet UIButton *imgvBtn;

- (IBAction)selectimg:(id)sender;

@property (nonatomic,assign) NSString       *tourist;

@end

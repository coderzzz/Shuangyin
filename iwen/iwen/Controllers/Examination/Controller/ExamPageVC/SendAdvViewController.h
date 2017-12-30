//
//  SendAdvViewController.h
//  iwen
//
//  Created by sam on 16/3/4.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface SendAdvViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *probtn;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UIImageView *img1;

@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property (weak, nonatomic) IBOutlet UIImageView *img3;

@property (weak, nonatomic) IBOutlet UIImageView *img4;

@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (weak, nonatomic) IBOutlet UIImageView *img6;

@property (weak, nonatomic) IBOutlet UIImageView *img7;

@property (weak, nonatomic) IBOutlet UIImageView *img8;

@property (weak, nonatomic) IBOutlet UIImageView *img9;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIView *footView;

- (IBAction)addQ:(id)sender;

- (IBAction)up:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *qView;


@property (weak, nonatomic) IBOutlet UITextView *qtext;

@property (weak, nonatomic) IBOutlet UITextField *atext;

- (IBAction)qaction:(id)sender;

- (IBAction)addImage:(UIButton *)sender;

- (IBAction)cancleQ:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UITextField *redMony;

@property (weak, nonatomic) IBOutlet UITextField *redCount;

@property (weak, nonatomic) IBOutlet UILabel *myMoneyLab;

- (IBAction)sendRedAction:(UIButton *)sender;

- (IBAction)hieRedAction:(UITapGestureRecognizer *)sender;

@property (copy, nonatomic) NSString *type;



@end

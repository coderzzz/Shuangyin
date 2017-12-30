//
//  GuideViewController.h
//  
//
//  Created by Interest on 15/12/3.
//
//

#import "BaseViewController.h"

@interface GuideViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextField *alitext;

@property (weak, nonatomic) IBOutlet UITextField *nametext;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

- (IBAction)doneAction:(id)sender;


@end

//
//  BlogTypeViewController.h
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"
#import "BlogData.h"
@interface BlogTypeViewController : BaseViewController
- (IBAction)searaciton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textf;

@property (weak, nonatomic) IBOutlet UICollectionView *collecview;
@property (weak, nonatomic) IBOutlet UIButton *searchbtn;

@property (strong, nonatomic) NSString *city;

@end

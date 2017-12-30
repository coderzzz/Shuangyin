//
//  CaViewController.h
//  iwen
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"
#import "DTCoreText.h"
@interface CaViewController : BaseViewController

@property (copy, nonatomic) NSString *caId;
@property (weak, nonatomic) IBOutlet DTAttributedTextView *textview;

@end

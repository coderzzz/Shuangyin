//
//  LearningCell.h
//  iwen
//
//  Created by Interest on 15/10/15.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearningCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixelHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *imgv;

@property (weak, nonatomic) IBOutlet UIImageView *typeLab;

@property (weak, nonatomic) IBOutlet UILabel *titLab;


@property (weak, nonatomic) IBOutlet UILabel *redlab;
@property (weak, nonatomic) IBOutlet UIImageView *redimgv;

@property (weak, nonatomic) IBOutlet UILabel *reamlab;









@property (weak, nonatomic) IBOutlet UILabel *subLab;

@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@property (weak, nonatomic) IBOutlet UIButton *liekBtn;

@end

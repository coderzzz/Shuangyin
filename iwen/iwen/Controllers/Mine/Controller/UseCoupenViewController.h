//
//  UseCoupenViewController.h
//  iwen
//
//  Created by sam on 16/7/3.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@interface UseCoupenViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *con;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *adname;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *butImgv;

@property (weak, nonatomic) IBOutlet UIImageView *topimgv;
- (IBAction)useCoupenAction:(UIButton *)sender;

@property (nonatomic, strong) CourseListModel *model;










@end

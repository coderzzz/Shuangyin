//
//  MySaveSectionView.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySaveSectionView : UIView


@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UILabel *topLineLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOne;
@property (weak, nonatomic) IBOutlet UILabel *buttomLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomOne;

@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tap;


@end

//
//  RecordCell.h
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@property (weak, nonatomic) IBOutlet UILabel *click;


@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UIView *buttomView;

@property (strong, nonatomic) NSDictionary *model;

- (void)setNomalColor;

- (void)setSElectedColor;

@end

//
//  WeiCoCell.h
//  iwen
//
//  Created by Interest on 16/3/11.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiCoCell;
@protocol WeiCoCellDelegate <NSObject>

@optional

- (void)didShowPhotoWithModel:(CourseListModel *)model;

- (void)didDelPhotoWithModel:(CourseListModel *)model;

- (void)didLikePhotoWithModel:(id)model;

- (void)didPlayWithModel:(ViedeoModel *)model cell:(WeiCoCell *)cell;
@end

@interface WeiCoCell : UITableViewCell

@property (weak, nonatomic) id <WeiCoCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *headview;
@property (weak, nonatomic) IBOutlet UIView *playview;

@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UILabel *datelab;

@property (weak, nonatomic) IBOutlet UILabel *contenLab;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property (weak, nonatomic) IBOutlet UIView *darkview;

@property (weak, nonatomic) IBOutlet UIButton *viderbtn;

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *btn5;

@property (weak, nonatomic) IBOutlet UIButton *btn6;

@property (weak, nonatomic) IBOutlet UIButton *btn7;

@property (weak, nonatomic) IBOutlet UIButton *btn8;

@property (weak, nonatomic) IBOutlet UIButton *btn9;


@property (weak, nonatomic) IBOutlet UIButton *delbtn;


- (IBAction)deleAction:(UIButton *)sender;



- (IBAction)addLike:(id)sender;




@property (strong, nonatomic) CourseListModel *model;
@property (strong, nonatomic) ViedeoModel *vmodel;


+ (CGFloat )heihtForModel:(CourseListModel *)model;
+ (CGFloat )heihtForvModel:(ViedeoModel *)model;





@end

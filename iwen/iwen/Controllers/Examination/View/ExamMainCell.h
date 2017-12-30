//
//  ExamMainCell.h
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

@class ExamMainCell;

typedef NS_ENUM(NSInteger, ExamMainCellButtonType) {
    
    
    ExamMainCellFormalExam     = 0, 
    ExamMainCellSimulation     = 1,   // 模拟考试
    ExamMainCellChapter        = 2,   // 章节练习
    ExamMainCellOrder          = 3,   // 顺序练习
    ExamMainCellRandom         = 4    // 随机练习
    
};

@protocol ExamMainCellDelegate <NSObject>

@required

- (void)examMainCell:(ExamMainCell *)examMainCell didSelectButtonType:(ExamMainCellButtonType)examMainCellButtonType;

@end


#import <UIKit/UIKit.h>



@interface ExamMainCell : UITableViewCell

@property (nonatomic, weak) id<ExamMainCellDelegate>delegate;

- (IBAction)pressAction:(UIButton *)sender;




@property (weak, nonatomic) IBOutlet UILabel *hlineLab;

@property (weak, nonatomic) IBOutlet UILabel *vlineLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *one;

@property (weak, nonatomic) IBOutlet UIImageView *imgv;


@property (weak, nonatomic) IBOutlet UIButton *leftbtn;

@property (weak, nonatomic) IBOutlet UILabel *leftlab;

@property (weak, nonatomic) IBOutlet UIButton *cenbtn;

@property (weak, nonatomic) IBOutlet UILabel *cenlab;

@property (weak, nonatomic) IBOutlet UIButton *rigbtn;

@property (weak, nonatomic) IBOutlet UILabel *riglab;




- (IBAction)btnAction:(id)sender;

- (IBAction)examTap:(id)sender;


@end

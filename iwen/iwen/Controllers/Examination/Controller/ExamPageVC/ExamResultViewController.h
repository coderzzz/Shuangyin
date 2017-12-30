//
//  ExamResultViewController.h
//  iwen
//
//  Created by Interest on 15/11/2.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"

@protocol ExamResultViewController <NSObject>

@optional

- (void)tryAgin;

@end


@interface ExamResultViewController : BaseViewController

@property (weak, nonatomic) id <ExamResultViewController> delegate;

@property (strong, nonatomic) ExamResultModel *resultModel;

@property (strong, nonatomic) NSString *examId;

@property (weak, nonatomic) IBOutlet UILabel *titLab;

@property (weak, nonatomic) IBOutlet UIButton *tryBtn;

- (IBAction)tryAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UILabel *statuLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;


//@property (weak, nonatomic) IBOutlet UICollectionView *collectview;
//
//
//@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;

@property (weak, nonatomic) IBOutlet UIImageView *leftImgv;

@property (weak, nonatomic) IBOutlet UIImageView *centerImgv;





@end

//
//  PayView.h
//  iwen
//
//  Created by Interest on 15/11/11.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayViewDelegate <NSObject>

@optional

- (void)didPressBtnWithTag:(NSInteger)tag;


@end

@interface PayView : UIView

@property (weak, nonatomic) id<PayViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *TitleView;

@property (weak, nonatomic) IBOutlet UILabel *feeLab;

- (IBAction)btnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *weiChatBtn;

@property (weak, nonatomic) IBOutlet UIButton *aliBtn;


@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *cenBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *bomLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *bomCenterBtn;
@property (weak, nonatomic) IBOutlet UIButton *bomRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *tkLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *tkCenterBtn;
@property (weak, nonatomic) IBOutlet UIButton *tkRightBtn;

@property (weak, nonatomic) IBOutlet UIButton *coupenBtn;





@end

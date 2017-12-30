//
//  RcoderCell.h
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

@class RcoderCell;

typedef NS_ENUM(NSInteger, RcoderCellButtonType) {
    
    RcoderCellRecode       ,   //
    RcoderCellRange        ,   //
    RcoderCellQuery        ,   //

};

@protocol RcoderCellDelegate <NSObject>

@required

- (void)rcoderCell:(RcoderCell *)rcoderCell didSelectButtonType:(RcoderCellButtonType)rcoderCellButtonType;

@end
#import <UIKit/UIKit.h>

@interface RcoderCell : UITableViewCell

@property (nonatomic,weak) id<RcoderCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *one;

- (IBAction)BtnAction:(id)sender;


@end

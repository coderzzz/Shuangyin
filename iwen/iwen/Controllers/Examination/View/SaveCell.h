//
//  SaveCell.h
//  iwen
//
//  Created by Interest on 15/10/16.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

@class SaveCell;

typedef NS_ENUM(NSInteger, SaveCellButtonType) {
    
    SaveCellMyError       ,   //
    SaveCellMySave        ,   //
  
    
};

@protocol SaveCellDelegate <NSObject>

@required

- (void)saveCell:(SaveCell *)saveCell didSelectButtonType:(SaveCellButtonType)saveCellButtonType;


@end
#import <UIKit/UIKit.h>

@interface SaveCell : UITableViewCell

@property (nonatomic,weak) id<SaveCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *butomLine;

@property (weak, nonatomic) IBOutlet UILabel *centerLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixConstraint;

- (IBAction)btnAction:(id)sender;



@end

//
//  MddCell.h
//  iwen
//
//  Created by sam on 16/8/6.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MddCellDelegate <NSObject>

@optional
- (void)didTapWithModel:(id)model;

@end

@interface MddCell : UITableViewCell

@property (weak, nonatomic) id<MddCellDelegate>delegate;
- (void)layoutWithArray:(NSArray *)array;
@end

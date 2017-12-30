//
//  UserListCell.h
//  iwen
//
//  Created by sam on 16/8/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImgv;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *ageLab;

@property (weak, nonatomic) IBOutlet UILabel *sexLab;

@property (weak, nonatomic) IBOutlet UILabel *counLab;
@property (weak, nonatomic) IBOutlet UILabel *sigLab;




@end

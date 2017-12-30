//
//  logoutCell.m
//  iwen
//
//  Created by Interest on 15/10/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "logoutCell.h"
#define TitleLabFont       [UIFont systemFontOfSize:14]
#define TitleLabTextColor  [UIColor redColor]

@implementation logoutCell

- (void)awakeFromNib {
   
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLab               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        self.titleLab.font          = TitleLabFont;
        self.titleLab.textColor     = TitleLabTextColor;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.text          = @"退出账号";
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

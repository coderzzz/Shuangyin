//
//  MddCell.m
//  iwen
//
//  Created by sam on 16/8/6.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MddCell.h"

@implementation MddCell

{
    NSMutableArray *btnList;
    NSMutableArray *titleList;
    NSMutableArray *contenList;
    NSMutableArray *dataList;
}
- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUpUI];
}

- (void)setUpUI{
    
    btnList = [NSMutableArray array];
    titleList = [NSMutableArray array];
    contenList = [NSMutableArray array];
    dataList = [NSMutableArray array];
    CGFloat space = 10.f;
    CGFloat width = (ScreenWidth- 4 * space)/3;
    
    for (int i=0; i<3; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i+1) * space + width * i, 4 , width, 110)];
        UILabel *titlab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, 110 + 4 * 2, width, 21)];
        UILabel *contenlab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, 110 + 4 * 3 +21, width, 21)];
        contenlab.textColor= [UIColor darkGrayColor];
        contenlab.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.contentView addSubview:titlab];
        [self.contentView addSubview:contenlab];
        [btnList addObject:btn];
        [titleList addObject:titlab];
        [contenList addObject:contenlab];
    }
}


- (void)tap:(UIButton *)btn{
    
    NSDictionary *dic = dataList[btn.tag];
    [self.delegate didTapWithModel:dic];
    
}
- (void)layoutWithArray:(NSArray *)array{
    
    
    
    for (int a=0; a<3; a++) {
        
        UIButton *btn = btnList[a];
        UILabel *lab = titleList[a];
        UILabel *contenlab = contenList[a];
        
        btn.hidden = YES;
        lab.hidden = YES;
        contenlab.hidden = YES;
        
    }
    
    
    if (array.count>0) {
        
        [dataList removeAllObjects];
        [dataList addObjectsFromArray:array];
        
        
        for (int a=0; a<array.count; a++) {
            
            NSDictionary *dic = array[a];
            UIButton *btn = btnList[a];
            btn.hidden = NO;
            UILabel *lab = titleList[a];
            lab.hidden = NO;
            UILabel *contenlab = contenList[a];
            lab.text = dic[@"adName"];
            contenlab.hidden = NO;
            NSString *imgurls = [NSString stringWithFormat:@"%@",dic[@"adImg"]];
            NSArray *ary =[imgurls componentsSeparatedByString:@","];
            NSString *str = [ary firstObject];
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]] forState:UIControlStateNormal];
            contenlab.text = [NSString stringWithFormat:@"剩余数量:%@",dic[@"fredRemainNum"]];
            //                    NSNumber *nu = butomList[indexPath.row][@"fAdvtype"];
            
            
            
        }
        
    }
    
}



@end

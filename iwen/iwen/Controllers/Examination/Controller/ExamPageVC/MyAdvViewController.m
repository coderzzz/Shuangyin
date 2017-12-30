//
//  MyAdvViewController.m
//  iwen
//
//  Created by Interest on 16/3/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyAdvViewController.h"
#import "DetCell.h"
#import "DetailCell.h"
#import "LearningCell.h"
#import "SignInViewController.h"
@interface MyAdvViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyAdvViewController

{
    NSDictionary *dataDic;
    
    NSMutableArray *leftList;
    
    NSMutableArray *rightList;
    
    NSMutableArray *butomList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商家中心";
    
    leftList = [@[@"联系人",@"联系电话",@"商家官网",@"商家地址",@"查看地图"]mutableCopy];
    
    UINib *detNib = [UINib nibWithNibName:@"DetCell" bundle:nil];
    
    UINib *detailNib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    
    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"detail"];
    
    [self.tableview registerNib:detNib forCellReuseIdentifier:@"DetCell"];
    
    UINib *nib1 = [UINib nibWithNibName:@"LearningCell" bundle:nil];
    
    
    [self.tableview registerNib:nib1 forCellReuseIdentifier:@"learCell"];
    
    [self.tableview setTableHeaderView:self.headview];
    
    [self.tableview clearSeperateLine];
    [self loadata];
}

- (void)loadata{
    
    [[ExamService shareInstenced]getExamWithUid:self.adid type:nil];
    
    [ExamService shareInstenced].getExamSuccess = ^(id obj){
        
        dataDic = obj;
        
        
        //        self.adname.text = dataDic[@"ad"][@"fname"];
        //        self.adword.text = dataDic[@"ad"][@"fterm"];
        
        NSString *str = dataDic[@"aders"][@"flogo"];
        
        [self.imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ads_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
        self.lab.text =dataDic[@"aders"][@"fcompanyName"];
        
        
        NSString  *userNam =[NSString stringWithFormat:@"%@",dataDic[@"aders"][@"fcontacts"]];
        
        if (!userNam.length>0 || [userNam isEqualToString:@"<null>"]) {
            
            userNam = @"";
        }
        
        NSString  *address =[NSString stringWithFormat:@"%@",dataDic[@"aders"][@"ftelPhone"]];
        
        if (!address.length>0) {
            
            address = @"";
        }
        NSString  *addressname =[NSString stringWithFormat:@"%@",dataDic[@"aders"][@"fwebsite"]];
        
        if (!addressname.length>0) {
            
            addressname = @"";
        }
        NSString  *adersWebsite =[NSString stringWithFormat:@"%@",dataDic[@"aders"][@"faddress"]];
        
        if (!adersWebsite.length>0) {
            
            adersWebsite = @"";
        }
        
        
        rightList = [@[userNam,address,addressname,adersWebsite,@""]mutableCopy];
        
        butomList = [dataDic[@"page"][@"list"] mutableCopy];
        
        [self.tableview reloadData];
    };
    
    [ExamService shareInstenced].getExamFailure = ^(id obj){
        
   
        
    };
}

#pragma table

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 5;
    }
    
    return butomList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"detail"];
    //
    //    [self.tableview registerNib:detNib forCellReuseIdentifier:@"DetCell"];
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row ==0) {
            
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
            
            cell.toplab.text = @"商家详情";
            
            cell.lab.text =  [NSString stringWithFormat:@"%@",dataDic[@"aders"][@"detial"]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        else{
            
            DetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetCell"];
            
            if (dataDic) {
                
                cell.cenlab.text = rightList[indexPath.row-1];
            }
            cell.leflab.text = leftList[indexPath.row-1];
            
            
            return cell;
            
        }
    }
    else{
        
        LearningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"learCell"];
        
        cell.titLab.text = butomList[indexPath.row][@"fname"];
        
        [cell.readBtn setTitle:[NSString stringWithFormat:@"%@",butomList[indexPath.row][@"fclickConut"]] forState:UIControlStateNormal];
        
        NSArray *ary =[butomList[indexPath.row][@"fadvertImgIds"] componentsSeparatedByString:@","];
        NSString *str = [ary firstObject];
        
        
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
        
        NSNumber *nu =butomList[indexPath.row][@"fAdvtype"];
        
        if ([nu isEqualToNumber:@0]) {
            
            cell.redimgv.hidden = YES;
            cell.redlab.hidden = YES;
        }
        else{
            cell.redimgv.hidden = NO;
            cell.redlab.hidden = NO;
            
        }

        return cell;
    }

}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
//        DetailViewController *my = [[DetailViewController alloc]init];
//        
//        id advid = butomList[indexPath.row][@"fid"];
//        
//        if (advid) {
//            
//            my.advId = advid;
//            
//            my.title = @"广告详情";
//            
//            my.hidesBottomBarWhenPushed = YES;
//            
//            [self.navigationController pushViewController:my animated:YES];
//            
//        }
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        
        SignInViewController *vc = [[SignInViewController alloc]init];
        
        vc.coord = dataDic[@"aders"][@"fcoordinate"];
        
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            NSString *content =  [NSString stringWithFormat:@"%@",dataDic[@"aders"][@"detial"]];
            
            CGFloat labh = [RTLabel getHightWithString:content andSizeValue:14 andWidth:ScreenWidth-16];
            if (labh<22) {
                
                labh = 22;
            }
            
            return 50+labh;
        }
        
        return 44;
        
    }
    
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}



@end

//
//  ExamMainViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamMainViewController.h"
#import "LearningCell.h"
#import "ExamMainCell.h"
#import "MySaveViewController.h"
#import "RcoderCell.h"
#import "SaveCell.h"
#import "RangeViewController.h"
#import "AdvertisementView.h"
#import "DetailViewController.h"
#import "RecordViewController.h"
#import "PageVC.h"
#import "DDMenuController.h"
#import "RightViewController.h"
#import "WebListViewController.h"
#import "PersonCenterViewController.h"
#import "WeicoViewController.h"
#import "LearnMainViewController.h"
#import "BlogTypeViewController.h"
#import "CaViewController.h"
#import "MddCell.h"
#import "GDView.h"
#import <AMapLocationKit/AMapLocationKit.h>
@interface ExamMainViewController ()<UITableViewDelegate,UITableViewDataSource,ExamMainCellDelegate,RcoderCellDelegate,SaveCellDelegate,MddCellDelegate,AdvertisementViewDelegate>

@property (nonatomic, strong) AdvertisementView *adView;

@property (nonatomic, strong) UserModel         *userInfo;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation ExamMainViewController
{
    
    NSMutableArray *topList;
    
    NSMutableArray *butomList;
    
    GDView *view1;
    
    NSString *indexstr;
    
    NSString *city;
    NSString *recity;
    
    NSMutableArray *carouseList;
    
}
#pragma mark getter
//- (UserModel *)userInfo{
//    
//    if (_userInfo == nil) {
//        
//        _userInfo = [[LoginService shareInstanced]getUserModel];
//    }
//    
//    return _userInfo;
//}
- (AdvertisementView *)adView{
    
    if (_adView == nil) {
        
        _adView = [[AdvertisementView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
        
    }
    
    return _adView;
    
}


#pragma mark ViewLife cyle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.adView startTime];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.adView stopTimer];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpUI];
    
    city = @"广东省广州市天河区";

    [AMapLocationServices sharedServices].apiKey =@"a6d882491c36a12e80fa4f63677902be";

    view1 = [[GDView alloc]initWithFrame:CGRectMake(50, 328, ScreenWidth - 70, 30)];
    view1.turnArray = @[@"",@""];
    [self.headview addSubview:view1];
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    self.locationManager = [[AMapLocationManager alloc]init];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    self.locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager.reGeocodeTimeout = 3;
    
    // 带逆地理（返回坐标和地址信息）
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"%@",error);
                return;
           
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            
            recity = regeocode.city;
            city = [NSString stringWithFormat:@"%@%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.street,regeocode.number];
        }
    }];

}
- (void)setUpUI{
    
    
    
//    self.title = @"广告";
    
    topList = [NSMutableArray array];
    butomList = [NSMutableArray array];
  
    UINib *nib = [UINib nibWithNibName:@"ExamMainCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"mainCell"];
    

    
    UINib *nib1 = [UINib nibWithNibName:@"MddCell" bundle:nil];
    
//    [self.view addSubview:self.tableview];
    
  
    
    [self.tableview registerNib:nib1 forCellReuseIdentifier:@"mddd"];
    
    
    UINib *nib2 = [UINib nibWithNibName:@"RcoderCell" bundle:nil];
    
    [self.tableview registerNib:nib2 forCellReuseIdentifier:@"recoderCell"];
    
    self.tableview.backgroundColor = BackgroundColor;
    
    
    UINib *nib3 = [UINib nibWithNibName:@"SaveCell" bundle:nil];
    
    [self.tableview registerNib:nib3 forCellReuseIdentifier:@"saveCell"];

  
    [self config];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[LoginService shareInstanced]getAdvertisementWithType:@"0"];

    }];
    
    PersonModel *userModel = [[LoginService shareInstanced]getUserModel];
    NSString *token = userModel.use.ftoken?userModel.use.ftoken:@"";
    [[HttpService sharedInstance]getVideo:@{@"token":token} completionBlock:nil failureBlock:nil];
//    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//        [[ExamService shareInstenced]getTitleTypeWithPageIndex:indexstr];
//    }];

    [self.tableview.header beginRefreshing];
}

- (void)config{
    
    [LoginService shareInstanced].getAdvertisementFailure = ^(id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
    };
    
    [LoginService shareInstanced].getAdvertisementSuccess = ^ (id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
        indexstr = @"2";
        
        NSArray *ary = obj[@"carouselList"];
        
        topList = [obj[@"recommendList"] mutableCopy];
        
        [butomList removeAllObjects];
        
        
        
        
        butomList =[NSMutableArray array];
        NSMutableArray *list =[obj[@"recommendList"] mutableCopy];
        NSArray *nolist = [obj[@"noticeList"] copy];
        
        NSMutableArray *tls = [NSMutableArray array];
        for (NSDictionary *dic in nolist) {
            
            NSString *fcon = dic[@"fcontent"];
            [tls addObject:fcon];
        }
        view1.turnArray = tls;
        
        int i = (int)list.count;
        
        int rows = (int)ceilf(i/3.0);

//        for (int a=0; a<i; a++) {
        
        for (int x =0; x<rows; x++) {
            
            NSMutableArray *rowsData = [NSMutableArray array];
            for (int a=0; a<3; a++) {
             
                int index = x * 3 + a;
                
                
                if (index<i) {
                    
                    NSDictionary *dic = list[index];
                    [rowsData addObject:dic];
    
                }
                
            }
            [butomList addObject:rowsData];
            
            
        }

        NSMutableArray *temp = [NSMutableArray array];
        
        for (NSDictionary *dic in ary) {
            
            NSString *str = dic[@"fcoverImg"];
            
            [temp addObject:[NSString stringWithFormat:@"%@%@",Top_Pic_URL,str]];
        }
        carouseList = [NSMutableArray array];
        [carouseList addObjectsFromArray:ary];
        self.adView.urlArray = temp;
        self.adView.dele = self;
        [self.headview addSubview:self.adView];
        
        [self.tableview setTableHeaderView:self.headview];
        
        [self.tableview reloadData];
        
    };

    
//    
//    [ExamService shareInstenced].getTitleTypeSuccess= ^(id obj){
//        
//
//        indexstr = [NSString stringWithFormat:@"%ld",[indexstr integerValue]+1];
//        
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//        [butomList addObjectsFromArray:obj];
//        [self.tableview reloadData];
//
//    };
//    
//     [ExamService shareInstenced].getTitleTypeFailure = ^(id obj){
//        
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//        
//    };
    
    
    
}

#pragma mark Action

- (IBAction)refresh:(UIButton *)sender {
    
    [self.tableview.header beginRefreshing];
}

- (IBAction)weicoaction:(UIButton *)sender {
    
    WeicoViewController *vc = [[WeicoViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.title = @"旗袍说";
    vc.type = @"1";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)getRedAction:(UIButton *)sender {
    
    
    
    if (sender.tag == 0) {
        
        LearnMainViewController *vc = [[LearnMainViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.city = city;
         [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        MySaveViewController *vc = [[MySaveViewController alloc]init];
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.recity = recity;
        vc.city = city;
        vc.title = @"抢红包";
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

- (IBAction)pushReAction:(id)sender {
    
    BlogTypeViewController *vc = [[BlogTypeViewController alloc]init];
    vc.title = @"信息分类";
    vc.city = recity;
    vc.hidesBottomBarWhenPushed = YES;
   [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Service
#pragma mark AdvertisementViewDelegate
- (void)didTapImageViewAtIndex:(NSInteger )index{
    
    NSDictionary *model = carouseList[index];
    NSString *fid = model[@"fid"];
    CaViewController *vc = [[CaViewController alloc]init];
    vc.caId = [NSString stringWithFormat:@"%@",fid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ExamMainCellDelegate

- (void)examMainCell:(ExamMainCell *)examMainCell didSelectButtonType:(ExamMainCellButtonType)examMainCellButtonType{
    
    DetailViewController *my = [[DetailViewController alloc]init];
    
    id advid = topList[examMainCellButtonType][@"id"];
    
    if (advid) {
        
        my.advId = advid;
        my.city = city;
        my.title = @"广告详情";
        
        my.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:my animated:YES];
        
    }
    

    
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        
        return butomList.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//  
//    if (indexPath.section == 1) {
    
        MddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mddd"];
        
        NSMutableArray *ary = butomList[indexPath.row];
        [cell layoutWithArray:ary];
        cell.delegate = self;
        
//        cell.titLab.text = butomList[indexPath.row][@"fname"];
//        
//        [cell.readBtn setTitle:[NSString stringWithFormat:@"%@",butomList[indexPath.row][@"fclickConut"]] forState:UIControlStateNormal];
//        
//        NSArray *ary =[butomList[indexPath.row][@"fadvertImgIds"] componentsSeparatedByString:@","];
//        NSString *str = [ary firstObject];
//        
//
// 
//        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
//        
//        NSNumber *nu = butomList[indexPath.row][@"fAdvtype"];
//        
//        if ([nu isEqualToNumber:@0]) {
//            
//            cell.redimgv.hidden = YES;
//            cell.redlab.hidden = YES;
//        }
//        else{
//            cell.redimgv.hidden = NO;
//            cell.redlab.hidden = NO;
//            
//        }
        return cell;
//    }
    
   
}
- (void)didTapWithModel:(id)model{
    
    DetailViewController *my = [[DetailViewController alloc]init];
    
    id advid = [NSString stringWithFormat:@"%@",model[@"id"]];
    
    if (advid) {
        
        my.advId = advid;
        my.city = city;
    
        my.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:my animated:YES];
        
    }
    
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    MySaveViewController *my = [[MySaveViewController alloc]init];
    
//    DetailViewController *my = [[DetailViewController alloc]init];
//    
//    id advid = butomList[indexPath.row][@"fid"];
//    
//    if (advid) {
//        
//        my.advId = advid;
//        
//        my.title = @"广告详情";
//        
//        my.hidesBottomBarWhenPushed = YES;
//        
//        [self.navigationController pushViewController:my animated:YES];
//
//    }
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section ==1) {
//        
//        return 160;
//    }

        return 160;
}




@end

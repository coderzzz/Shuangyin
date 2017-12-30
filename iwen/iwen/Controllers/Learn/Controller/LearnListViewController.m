//
//  LearnListViewController.m
//  iwen
//
//  Created by Interest on 15/12/24.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import "LearnListViewController.h"
#import "LearnDetailViewController.h"
#import "TitleCell.h"
#import "LearningCell.h"
#import "CoupenCell.h"
@interface LearnListViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableview;


@end

@implementation LearnListViewController
{
    NSMutableArray *imgs;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.tableview reloadData];
//}
- (UITableView *)tableview{
    
    if (_tableview == nil) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-46) style:UITableViewStylePlain];
        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.dataSource = self;
        
        _tableview.delegate = self;
        
    
////        static dispatch_once_t onesToken;
//        
////        dispatch_once(&onesToken, ^{
////            
////            NSLog(@"1111");
//        
        
    
//        _tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableData)];
        
        _tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self configTableView];
            
            [self loadTableData];
        }];
        
        
        _tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           
            [self configTableView];
            
            [self loadMoreTableData];
        }];

    }
    
    return _tableview;
}


- (void)setData:(id)data{
    
    if (data) {
        
        _data = data;
        
        LearnListModel *model = self.data;
        
        NSMutableArray *ary = model.data;
        
        if (ary.count>0) {
            
            [self.tableview reloadData];
        }
        else{
            
            
            [self.tableview.header beginRefreshing];
        }
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib1 = [UINib nibWithNibName:@"CoupenCell" bundle:nil];
    
    [self.view addSubview:self.tableview];
    
    NSArray *art = @[@"背景1",@"背景2",@"背景3",@"背景4"];
    imgs = [NSMutableArray array];
    for (int i= 0; i<100; i++) {
        
        [imgs addObjectsFromArray:art];
    }
    
    [self.tableview registerNib:nib1 forCellReuseIdentifier:@"CoupenCel"];
    
}

- (void)loadTableData{
    
    LearnListModel *model = self.data;
    
    [model.data removeAllObjects];
    
    [[LearnService shareInstanced]getFirstCoupenListWithType:self.selectedId];
    
}

- (void)loadMoreTableData{
    
    [[LearnService shareInstanced]getMoreCoupenListWithType:self.selectedId];
    
}

- (void)configTableView{
    
 
    
    [LearnService shareInstanced].getCoupenListSuccess = ^(id obj){
        
         LearnListModel *model = self.data;

        model.data = (NSMutableArray *)obj;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            NSLog(@"reload");
            
            [self.tableview reloadData];
            
            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];

            
        });
        
        
    };
    
    [LearnService shareInstanced].getCoupenListFailure = ^(id obj){
        
        [self showHudWithString:obj];
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
    };
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LearnListModel *model = self.data;;
    
    return model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CoupenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoupenCel"];
    
    LearnListModel *mod = self.data;
    

    if (indexPath.row<mod.data.count) {
        
        CourseListModel *model = mod.data[indexPath.row];
        
        NSArray *ary = [model.fadvertImgIds componentsSeparatedByString:@","];
        
        NSString *imgurl = [ary firstObject];
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,imgurl]]];
        cell.leftLab.text = model.fname;
        CGFloat money = [model.fredMoney floatValue]/100;
        cell.toplab.text = [NSString stringWithFormat:@"￥%.2f",money];
        cell.remainLab.text = [NSString stringWithFormat:@"剩余%@",model.fredRemainNum];
        cell.midlab.text =model.fname;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.flimitedTime integerValue]/1000];
        
        
        cell.butLab.text =[NSString stringWithFormat:@"截止日期：%@",[date formatDateString:nil]];
        
            
        cell.bgimgv.image = [UIImage imageNamed:imgs[indexPath.row]];

        
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LearnListModel *mod = self.data;
    
    CourseListModel *model = mod.data[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.city =self.city;
    vc.advId = model.fid;
    [self.navigationController pushViewController:vc animated:YES];
    
//    LearnDetailViewController *vc = [[LearnDetailViewController alloc]init];
//    
////    vc.cid = model.id;
//    
//    
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


@end

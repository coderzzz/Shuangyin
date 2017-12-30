//
//  MySaveViewController.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "MySaveViewController.h"
#import "LearningCell.h"
#import "MXPullDownMenu.h"
@interface MySaveViewController ()<UITableViewDataSource,UITableViewDelegate,MXPullDownMenuDelegate>

@property (nonatomic,strong) PersonModel *userInfo;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation MySaveViewController
{
    NSMutableArray *list;
    NSMutableArray *areas;
    
    
    NSString *areaNo;
    NSString *adTypeId;
    NSString *filter;
    
    
    
}
#pragma mark getter
- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
    }
    
    return _dataSource;
    
}


- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        
        _selectArray = [NSMutableArray array];
    }
    
    return _selectArray;
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI{
    UINib *nib1 = [UINib nibWithNibName:@"LearningCell" bundle:nil];


    [self.tableview registerNib:nib1 forCellReuseIdentifier:@"learCell"];
    
    areaNo = @"";
    adTypeId = @"";
    filter = @"";
    
    
    [self config];
    
    NSString *type;
    
    if ([self.title isEqualToString:@"抢红包"]) {
        
        type = @"2";
    }
    else{
        
        type = @"1";
    }
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstRankingWithUid:areaNo timeType:adTypeId province:filter type:type];
        
    }];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMoreRankingWithUid:areaNo timeType:adTypeId province:filter type:type];
    }];

    
}

- (void)config{
    
    
    [ExamService shareInstenced].getRankingSuccess = ^(id obj,NSString *flag,NSString *type){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
        self.dataSource = [obj mutableCopy];
        [self.tableview reloadData];
    };
    
     [ExamService shareInstenced].getRankingFailure = ^(id obj,NSString *type){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
    };
    
    
    
}

#pragma mark Action

#pragma mark Service

- (void)loadData{
    
    [[ExamService shareInstenced]getCourseType];
    
    [self showHud];
    [ExamService shareInstenced].getCourseTypeSuccess = ^(id obj){
        
        [self hideHud];
        NSDictionary *temp = @{@"fid":@"",@"fname":@"不限",@"fpid":@"0"};
        list = [obj mutableCopy];
        [list insertObject:temp atIndex:0];
        NSMutableArray *namelist = [NSMutableArray array];
        for (NSDictionary *dic in list) {
            
            [namelist addObject:dic[@"fname"]];
            
        }
        if (!self.recity.length>0) self.recity = @"广州市";
        [[ExamService shareInstenced]cancleExamWithUid:self.recity examId:nil];
        
        [ExamService shareInstenced].cancelExamSuccess = ^(id obj){
            
            NSDictionary *temp = @{@"areaName":@"不限",@"areaNo":@""};
            areas = [obj mutableCopy];
            [areas insertObject:temp atIndex:0];
            NSMutableArray *citylist = [NSMutableArray array];
            for (NSDictionary *dic in areas) {
                
                [citylist addObject:dic[@"areaName"]];
                
            }
            
            
            NSArray *testArray;
            testArray = @[ namelist,citylist, @[@"最新广告排序", @"热门广告排序", @"平台推荐广告", @"红包广告金额排序", @"红包数量排序"]];
            
            areaNo = [areas firstObject][@"areaNo"];
            
            adTypeId = [list firstObject][@"fid"];
            
            filter = @"1";
            
            [self.tableview.header beginRefreshing];
            
            MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:BaseColor];
            menu.delegate = self;
            menu.frame = CGRectMake(0,0, ScreenWidth, 40);
            [self.view addSubview:menu];
            
        };
        
        [ExamService shareInstenced].cancelExamFailure = ^(id obj){
          
            
        };
        
    };
    
    [ExamService shareInstenced].getCourseTypeFailure = ^(id obj){
        
        [self hideHud];
    };
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%ld -- %ld", (long)column, (long)row);
    
    if (column == 0) {
        
         adTypeId = list[row][@"fid"];
        
    }
    if (column == 1) {
        
         areaNo = areas[row][@"areaNo"];
        
    }
    
    if (column == 2) {
        
       filter = [NSString stringWithFormat:@"%ld",row+1];
    }
    
    [self.tableview.header beginRefreshing];
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LearningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"learCell"];
    
    cell.titLab.text = self.dataSource[indexPath.row][@"fname"];
    cell.reamlab.text = [NSString stringWithFormat:@"剩余:%@",self.dataSource[indexPath.row][@"fredRemainNum"]];
    [cell.readBtn setTitle:[NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"fclickConut"]] forState:UIControlStateNormal];
    CGFloat time =[[NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"fcreatetime"]] floatValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    [cell.liekBtn setTitle:[date formatDateString:nil] forState:UIControlStateNormal];
    NSString *imgstr = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"fadvertImgIds"]];
    if (imgstr.length>6) {
        
        NSArray *ary =[imgstr componentsSeparatedByString:@","];
        NSString *str = [ary firstObject];
        
        
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
    }
   
    
    NSNumber *nu =self.dataSource[indexPath.row][@"fAdvtype"];
    
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

#pragma mark UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *my = [[DetailViewController alloc]init];
    
    id advid = self.dataSource[indexPath.row][@"fid"];
    
    if (advid) {
        
        my.advId = advid;
        
        my.title = @"广告详情";
        my.city = self.city;
        my.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:my animated:YES];
        
    }
    
    
}


@end

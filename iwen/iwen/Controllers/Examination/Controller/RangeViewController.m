//
//  RangeViewController.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RangeViewController.h"
#import "RangCell.h"
#import "PageVC.h"
#import "RangPickerView.h"

//#import "Company.h"
//#import "Depart.h"
@interface RangeViewController ()<UITableViewDataSource,UITableViewDelegate,RangPickerViewDelegate>

@property (nonatomic, strong) RangPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *cityArray;

@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, strong) UserModel      *userInfo;

@property (nonatomic, strong) NSString       *province;

@property (nonatomic, strong) NSString       *time;


@end

@implementation RangeViewController


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUi];
}

- (void)setUpUi{
    
    self.title = @"排行榜";
    
    
    [self.tableview setTableHeaderView:self.headview];
    
    self.tableview.backgroundColor = BackgroundColor;
    
    self.headImgv.layer.masksToBounds = YES;
    
    self.headImgv.layer.cornerRadius  = self.headImgv.bounds.size.width/2;
    
    [self.headImgv sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avatar] placeholderImage:DefaultAvatar];
    
    self.buttomView.backgroundColor   = BaseColor;
    
    [self.examBtn setTitleColor:BaseColor forState:UIControlStateNormal];
     self.examBtn.layer.masksToBounds   = YES;
    
    self.examBtn.layer.cornerRadius    = 3;
    
    UINib *nib = [UINib nibWithNibName:@"RangCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"myRangCell"];
    
    [self configTableData];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
    [self.tableview.header beginRefreshing];
    

}


- (void)reloadButomViewWithFlag:(NSString *)flag{
    
    if ([flag isEqualToString:@"0"]) {
        
        self.lab.text = @"你还没有考试!";
        
        self.examBtn.hidden = NO;
    }
    else{
        
        self.lab.text = [NSString stringWithFormat:@"你的排名为%@",flag];
        
        self.examBtn.hidden = YES;
        
    }
    
}


#pragma mark Action





- (IBAction)examAction:(id)sender {
    
    PageVC *vc = [[PageVC alloc]init];
    
    vc.examType = FormalExam;

    [self.navigationController pushViewController:vc animated:YES];

    
}
- (IBAction)leftAction:(id)sender {

    self.pickerView.dataSource = self.cityArray;
    
    self.pickerView.rangPickerViewType = RangPickerViewProvince;
    
    [self.pickerView showInView:self.view];
    
}

- (IBAction)rightAction:(id)sender {
    
    
    self.pickerView.dataSource = self.dateArray;
    
    self.pickerView.rangPickerViewType = RangPickerViewDate;
    
    [self.pickerView showInView:self.view];
    
}


#pragma mark Service

- (void)configTableData{
    
    [ExamService shareInstenced].getRankingSuccess = ^(id obj,NSString *flag,NSString *type){
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        self.tableData = obj;
        
        [self reloadButomViewWithFlag:flag];
        
        [self.tableview reloadData];
        
        
    };
    
    [ExamService shareInstenced].getRankingFailure = ^(id obj,NSString *type){
        
        
        if ([type isEqualToString:@"first"]) {
            
            [self.tableData removeAllObjects];
            
            [self.tableview reloadData];
            
            [self reloadButomViewWithFlag:@"0"];
        }
        
        
        [self.tableview.header endRefreshing];
        
        [self.tableview.footer endRefreshing];
        
        [self showHudWithString:obj];
        
    };
    
    
}

- (void)loadFirstData{
    
//    [[ExamService shareInstenced]getFirstRankingWithUid:self.userInfo.uid timeType:self.time province:self.province];
    
}

- (void)loadMoreData{
    
//    
//    [[ExamService shareInstenced]getMoreRankingWithUid:self.userInfo.uid timeType:self.time province:self.province];
}



#pragma mark RangPickerViewDelegate

- (void)pickerView:(RangPickerView *)pickerView didSelectedString:(NSString  *)string rangPickerViewType:(RangPickerViewType)rangPickerViewType{
    
    
    if (rangPickerViewType == RangPickerViewProvince) {
        
        NSLog(@"province  %@",string);
        
        [self.leftBtn setTitle:string forState:UIControlStateNormal];
        
        self.province = string;
        
        [self.tableview.header beginRefreshing];
    }
    else{
        
        //(1-今天(默认) 2--本周 3--本月  4--全部)
        
        if ([string isEqualToString:@"今日"]) self.time = @"1";
        
        if ([string isEqualToString:@"本周"]) self.time = @"2";
        
        if ([string isEqualToString:@"本月"]) self.time = @"3";
        
        if ([string isEqualToString:@"全部"]) self.time = @"4";
        
        [self.tableview.header beginRefreshing];
        
        [self.rightBtn setTitle:string forState:UIControlStateNormal];
        
    }
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<self.tableData.count) {
    
    RangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myRangCell"];
    
    
        
    RankingUserModel *model = self.tableData[indexPath.row];
    
    cell.nameLab.text = model.username;
    
    cell.scoreLab.text = [NSString stringWithFormat:@"%@分",model.exam_score];
    
    cell.timeLab.text = model.usetime;
    
    NSString *imageName;
    
    if (indexPath.row>=4) {
        
        imageName = self.imageArray[3];
    }
    else{
        
        imageName = self.imageArray[indexPath.row];
    }
    
    [cell.btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [cell.btn setTitle:model.ranking_id forState:UIControlStateNormal];

   
    
    
    return cell;
    }
    
    else{
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark getter

- (NSString *)province{
    
    if (_province == nil) {
        
//        _province = self.userInfo.province;
        
        if (!_province.length>0) {
            
            _province = @"全国";
        }
    }
    
    return _province;
}

- (NSString *)time{
    
    if (_time == nil) {
        
        
        _time = @"4";
    }
    return _time;
}


- (UserModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    
    return _userInfo;
}

- (RangPickerView *)pickerView{
    
    if (_pickerView == nil) {
        
        _pickerView = [[RangPickerView alloc]init];
        
        _pickerView.delegate = self;
    }
    
    return _pickerView;
}

- (NSMutableArray *)cityArray{
    
    if (_cityArray == nil) {
        
        
        _cityArray = [@[@"全国"]mutableCopy];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        for (NSDictionary *dic in data) {
            
            
            [_cityArray addObject:dic[@"State"]];
        }
        
        
    }
    
    return _cityArray;
}

- (NSMutableArray *)tableData{
    
    if (_tableData== nil) {
        
        _tableData = [@[]mutableCopy];
        
    }
    
    return _tableData;
    
}

- (NSMutableArray *)dateArray{
    
    if (_dateArray == nil) {
        
        _dateArray = [@[@"今日",@"本周",@"本月",@"全部"]mutableCopy];
        
    }
    
    return _dateArray;
    
}

- (NSMutableArray *)imageArray{
    
    if (_imageArray == nil) {
        
        _imageArray = [@[@"首页-排行榜-金牌",@"首页-排行榜-银牌",@"首页-排行榜-铜牌",@"首页-排行榜--绿牌"]mutableCopy];
        
    }
    
    return _imageArray;
    
}

@end

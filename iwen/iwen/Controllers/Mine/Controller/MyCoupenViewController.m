//
//  MyCoupenViewController.m
//  iwen
//
//  Created by Interest on 16/7/2.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyCoupenViewController.h"
#import "HMSegmentedControl.h"
#import "CoupenCell.h"
#import "UseCoupenViewController.h"
@interface MyCoupenViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) HMSegmentedControl* segmentedControl;
@property (nonatomic, strong) PersonModel      *userInfo;

@property (nonatomic, strong) UITableView *tab1;
@property (nonatomic, strong) UITableView *tab2;
@property (nonatomic, strong) UITableView *tab3;
@end

@implementation MyCoupenViewController


{
    
    
    NSMutableArray *imgs;
    NSMutableArray *tab1List;
    NSMutableArray *tab2List;
    NSMutableArray *tab3List;
    NSMutableArray *dataSource;
}

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}
#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableview];
    
    NSArray *art = @[@"背景1",@"背景2",@"背景3",@"背景4"];
    imgs = [NSMutableArray array];
    for (int i= 0; i<100; i++) {
        
        [imgs addObjectsFromArray:art];
    }


    [self setupUi];
}

- (void)setupUi
{
    

    self.segm.frame = CGRectMake(0, 0, 120, 30);
    self.navigationItem.titleView = self.segm;
    tab1List = [NSMutableArray array];
    tab2List = [NSMutableArray array];
    tab3List = [NSMutableArray array];
    dataSource = [NSMutableArray array];
    
    //    self.tableview.backgroundColor = BackgroundColor;
    
    _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"未使用",@"已过期",@"已使用"]];
    [_segmentedControl setFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [_segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [_segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
    [_segmentedControl setSelectionIndicatorHeight:2];
    
    _segmentedControl.segmentEdgeInset = UIEdgeInsetsZero;
    
    [_segmentedControl setFont:[UIFont systemFontOfSize:16]];
    
    [_segmentedControl setSelectedTextColor:[UIColor redColor]];
    [_segmentedControl setSelectionIndicatorColor:[UIColor redColor]];
    _segmentedControl.selectedSegmentIndex = 0;
    
    [self.perView addSubview:_segmentedControl];
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    self.scrollview.frame = CGRectMake(0,50, ScreenWidth, ScreenHeight-64-50);
    
    self.scrollview.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight-64-50);
    
    _tab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    
    _tab1.dataSource = self;
    _tab1.delegate = self;
    _tab1.showsHorizontalScrollIndicator = NO;
    
    _tab1.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:_tab1];
    
    _tab2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-64-50)];
    
    _tab2.dataSource = self;
    _tab2.delegate = self;
    _tab2.showsHorizontalScrollIndicator = NO;
    [self.scrollview addSubview:_tab2];
    
    _tab3 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight-64-50)];
    
    _tab3.dataSource = self;
    _tab3.delegate = self;
    _tab3.showsHorizontalScrollIndicator = NO;
    [self.scrollview addSubview:_tab3];
    
    
    
    _tab1.separatorColor = SeparatorColor;
    
    [_tab1 clearSeperateLine];
    
    _tab2.separatorColor = SeparatorColor;
    
    [_tab2 clearSeperateLine];
    
    _tab3.separatorColor = SeparatorColor;
    
    [_tab3 clearSeperateLine];
    
     [self.tab1 registerNibWithName:@"CoupenCell" reuseIdentifier:@"CoupenCel"];
     [self.tab2 registerNibWithName:@"CoupenCell" reuseIdentifier:@"CoupenCel"];
     [self.tab3 registerNibWithName:@"CoupenCell" reuseIdentifier:@"CoupenCel"];
     [self.tableview registerNibWithName:@"CoupenCell" reuseIdentifier:@"CoupenCel"];
    
    
    
    __weak MyCoupenViewController * weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        
        if (index == 0) {
            
            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
            if([tab1List count] == 0)
            {
            
                [weakSelf loadDataWithType:@"0"];
            }
        }else if (index == 1) {
           
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
            if([tab2List count] == 0)
            {
                
                [weakSelf loadDataWithType:@"1"];
            }
            
        }else if (index == 2) {
//            [weakSelf showHud];
//            [weakSelf hideHuw:2];
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth*2, 0) animated:YES];
            if(!([tab3List count] > 0))
            {
                
                [weakSelf loadDataWithType:@"2"];
            }
            
        }
        
    }];
//3e163c67-bb8d-4a7e-906f-51fb8c474e0e
    [self.view addSubview:self.perView];
    
    [self loadDataWithType:@"0"];
    [self loadAd];
}

- (void)loadAd{
    
    if (self.userInfo.adv.fid.length>0) {
       
        [[CircleService shareInstaced]signNewsWithId:nil uid:self.userInfo.adv.fid];
        [CircleService shareInstaced].signNewSuccess = ^(id obj){
            
            
            dataSource = [obj mutableCopy];
            [self.tableview reloadData];
            
            
        };
        [CircleService shareInstaced].signNewFailure = ^(id obj){
            
        };
        
    }
    
    
}




-(void)loadDataWithType:(NSString *)type
{
    [CircleService shareInstaced].getNewsDetailSuccess = ^(id obj){
        
        if ([type isEqualToString:@"0"]) {
            
            tab1List = [obj mutableCopy];
            [self.tab1 reloadData];
            
        }else if ([type isEqualToString:@"1"]){
            
            tab2List = [obj mutableCopy];
            [self.tab2 reloadData];
            
        }else{
            tab3List = [obj mutableCopy];
            [self.tab3 reloadData];
        }
        
    };
    [CircleService shareInstaced].getNewsDetailFailure = ^(id obj){
        
    };
    [[CircleService shareInstaced]getNewsDetailWithId:type uid:self.userInfo.use.ftoken];
    
    
}



#pragma mark Action

- (IBAction)segAction:(UISegmentedControl *)sender {
    
    NSLog(@"%ld",(long)sender.tag);
    
    if (sender.selectedSegmentIndex == 0) {
        
        self.perView.hidden = NO;
    }else{
        self.perView.hidden = YES;
    }
}


#pragma mark Service

#pragma ScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollview)
    {
        if (scrollView.contentOffset.x == 0)
        {
            [_segmentedControl setSelectedSegmentIndex:0 animated:YES];
            if([tab1List count] == 0)
            {
                [self loadDataWithType:@"0"];
            }
        }
        else if (scrollView.contentOffset.x == ScreenWidth)
        {
            [_segmentedControl setSelectedSegmentIndex:1 animated:YES];
            if([tab2List count] == 0)
            {
                [self loadDataWithType:@"1"];
            }
        }else if (scrollView.contentOffset.x == ScreenWidth*2)
        {
            [_segmentedControl setSelectedSegmentIndex:2 animated:YES];
            if(!([tab3List count] > 0))
            {
                [self loadDataWithType:@"2"];
            }
        }
        
        else
        {
            return;
        }
    }
}

#pragma mark UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tab1) {
        
        return tab1List.count;
    }else if (tableView == self.tab2){
        
        return tab2List.count;
    }else if (tableView == self.tab3){
        return tab3List.count;
    }
    
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CoupenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoupenCel"];
   
    CourseListModel *model;
    if (tableView == self.tab1) {
        
        model = tab1List[indexPath.row];
    }else if (tableView == self.tab2){
        
         model = tab2List[indexPath.row];
    }else if (tableView == self.tab3){
         model = tab3List[indexPath.row];
    }
    else{
        model = dataSource[indexPath.row];
    }
    if (model) {
        
        NSArray *ary = [model.adImgs componentsSeparatedByString:@","];
        
        NSString *imgurl = [ary firstObject];
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,imgurl]]];
        cell.leftLab.text = model.advertName;
        CGFloat money = [model.fmoney floatValue]/100;
        cell.toplab.text = [NSString stringWithFormat:@"￥%.2f",money];
        cell.midlab.text =model.fname;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.limitedTime integerValue]/1000];
        
        cell.remainLab.text =[NSString stringWithFormat:@"剩余：%@",model.fisused];
        cell.butLab.text =[NSString stringWithFormat:@"截止日期：%@",[date formatDateString:nil]];
        
        
        cell.bgimgv.image = [UIImage imageNamed:imgs[indexPath.row]];
    }

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tab1) {
        
        CourseListModel *model = tab1List[indexPath.row];
        UseCoupenViewController *vc = [[UseCoupenViewController alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
    CourseListModel *model1;
    if (tableView == self.tab2) {
        
        model1 = tab2List[indexPath.row];
        
    }
    else{
        
        if (indexPath.row<tab3List.count) {
            
             model1 = tab3List[indexPath.row];
        }
       
    }
    
    if (model1.fadvertId.length>0) {
        DetailViewController *my = [[DetailViewController alloc]init];

        my.advId = model1.fadvertId;
        my.city = @"广东省广州市天河区";
        
        
        
        [self.navigationController pushViewController:my animated:YES];
        
    }
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}





@end

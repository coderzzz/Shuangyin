//
//  MyMoneyViewController.m
//  iwen
//
//  Created by Interest on 16/3/10.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyMoneyViewController.h"
#import "PutOnCell.h"
#import "RecordViewController.h"
#import "HMSegmentedControl.h"
@interface MyMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) HMSegmentedControl* segmentedControl;
@property (nonatomic, strong)  PersonModel      *userInfo;

@property (nonatomic, strong) UITableView *tab1;
@property (nonatomic, strong) UITableView *tab2;
@end

@implementation MyMoneyViewController
{
    
    
    
    NSMutableArray *tab1List;
    NSMutableArray *tab2List;
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
    [self setupUi];
}

- (void)setupUi
{
    
    self.title = @"收益统计";
    
    tab1List = [NSMutableArray array];
    tab2List = [NSMutableArray array];
    
    [self.view addSubview:self.topview];
    
    //    self.tableview.backgroundColor = BackgroundColor;
    
    _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"红包收益",@"优惠券收益"]];
    [_segmentedControl setFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [_segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [_segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
    [_segmentedControl setSelectionIndicatorHeight:2];
    
    _segmentedControl.segmentEdgeInset = UIEdgeInsetsZero;
    
    [_segmentedControl setFont:[UIFont systemFontOfSize:16]];
    
    [_segmentedControl setSelectedTextColor:[UIColor redColor]];
    [_segmentedControl setSelectionIndicatorColor:[UIColor redColor]];
    _segmentedControl.selectedSegmentIndex = 0;
    //    [_scrollview scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_scrollview.frame)) animated:NO];
    
    [self.view addSubview:_segmentedControl];
    
    self.topview.frame = CGRectMake(0, 50, ScreenWidth, 57);
    self.darkview.frame = CGRectMake(0, 40, ScreenWidth, 17);
    
    self.scrollview.frame = CGRectMake(0, 107, ScreenWidth, ScreenHeight-64-107);
    
    self.scrollview.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight-64-107);
    
    self.redlab.hidden = NO;
    self.ticklab.hidden = YES;
    
    _tab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-107)];
    
    _tab1.dataSource = self;
    _tab1.delegate = self;
    _tab1.showsHorizontalScrollIndicator = NO;
    
    _tab1.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:_tab1];
    
    _tab2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-64-107)];
    
    _tab2.dataSource = self;
    _tab2.delegate = self;
    _tab2.showsHorizontalScrollIndicator = NO;
    [self.scrollview addSubview:_tab2];
    
    UINib *nib  = [UINib nibWithNibName:@"PutOnCell" bundle:nil];
    [_tab1 registerNib:nib forCellReuseIdentifier:@"PutCell"];
    
    _tab1.separatorColor = SeparatorColor;
    
    [_tab1 clearSeperateLine];
    
    
    [_tab2 registerNib:nib forCellReuseIdentifier:@"PutCell"];
    
    _tab2.separatorColor = SeparatorColor;
    
    [_tab2 clearSeperateLine];
    
    
    [self configBlock];
    
    
    
    
    _tab1.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstload)];
    _tab1.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    
    _tab2.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(first2load)];
    _tab2.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(load2more)];
    
    [self loadData];
    
    [self.view addSubview:self.scrollview];
}



- (void)firstload{
    
    [[CircleService shareInstaced]getFirstForumWithId:self.userInfo.adv.fid?self.userInfo.adv.fid:@""];
}
- (void)loadmore{
    
    [[CircleService shareInstaced]getMoreForumWithId:self.userInfo.adv.fid?self.userInfo.adv.fid:@""];
}

- (void)first2load{
    
    [[CircleService shareInstaced]getFirstCommentWithId:self.userInfo.adv.fid?self.userInfo.adv.fid:@""];
}
- (void)load2more{
    
    [[CircleService shareInstaced]getMoreCommentWithId:self.userInfo.adv.fid?self.userInfo.adv.fid:@""];
}




-(void)loadData
{
    [_tab1.header beginRefreshing];
    __weak MyMoneyViewController * weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
            if([tab1List count] == 0)
            {
                [weakSelf.tab1.header beginRefreshing];
            }
        }else if (index == 1) {
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
            if([tab2List count] == 0)
            {
                [weakSelf.tab2.header beginRefreshing];
            }
            
        }else{
            return;
        }
    }];
    
}



#pragma mark Action
-(void)configBlock
{
    [CircleService shareInstaced].getForumSuccess = ^(id obj){
        
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
        tab1List = [obj mutableCopy];
        
        
        int a = 0;
        CGFloat m = 0;
        for (NSDictionary *dic in tab1List) {
            
            NSString *cli = [NSString stringWithFormat:@"%@",dic[@"fclickConut"]];
            a = a+ [cli intValue];
            NSString *c = [NSString stringWithFormat:@"%@",dic[@"fredMoney"]];
            m = m + [c floatValue];
            
            
        }
        m = m/100;
        self.redlab.text = [NSString stringWithFormat:@"累计投放%lu个红包广告，共发%.2f元点，击量%d次",(unsigned long)tab1List.count,m,a];
        
        [_tab1 reloadData];
        
        
        
    };
    
    [CircleService shareInstaced].getForumFailure = ^(id obj){
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
        
    };
    
    [CircleService shareInstaced].getCommentSuccess = ^(id obj){
        
        
        [_tab2.header endRefreshing];
        [_tab2.footer endRefreshing];
        tab2List = [obj mutableCopy];
        int a = 0;
     
        for (NSDictionary *dic in tab2List) {
            
            NSString *cli = [NSString stringWithFormat:@"%@",dic[@"fclickConut"]];
            a = a+ [cli intValue];
           
            
            
        }
        
        self.ticklab.text = [NSString stringWithFormat:@"累计投放%lu个优惠券，点击量%d次",(unsigned long)tab2List.count,a];

        [_tab2 reloadData];
        
        
    };
    
    [CircleService shareInstaced].getCommentFailure = ^(id obj){
        [_tab2.header endRefreshing];
        [_tab2.footer endRefreshing];
        
    };
    
    
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
            self.redlab.hidden =NO;
            self.ticklab.hidden =YES;
            if([tab1List count] == 0)
            {
                [_tab1.header beginRefreshing];
            }
        }
        else if (scrollView.contentOffset.x == ScreenWidth)
        {
            [_segmentedControl setSelectedSegmentIndex:1 animated:YES];
            self.redlab.hidden =YES;
            self.ticklab.hidden = NO;
            if([tab2List count] == 0)
            {
                [_tab2.header beginRefreshing];
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
    }
    
    return tab2List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PutOnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PutCell"];
    cell.rigLab.hidden = YES;
    NSDictionary *dic;
    
    if (tableView == self.tab1) {
        
        
        dic = tab1List[indexPath.row];
        
    }
    else{
        
        dic = tab2List[indexPath.row];
    }
    
    
    if (dic) {
        
        cell.titlab.text = dic[@"fname"];
        
        NSArray *ary =[dic[@"fadvertImgIds"] componentsSeparatedByString:@","];
        NSString *str = [ary firstObject];
        
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
        
        NSString *date = [NSString stringWithFormat:@"%@",dic[@"fcreatetime"]];
        
        long long time = [date longLongValue]/1000;
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time];
        
        cell.dateLab.text = [NSDate formatDateString:@"YYYY-MM-dd" withDate:date2];
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic;
    
    RecordViewController *vc = [[RecordViewController alloc]init];
    
    if (tableView == self.tab1) {
        
        vc.type = @"1";
        
        dic = tab1List[indexPath.row];
        
    }
    else{
        
        dic = tab2List[indexPath.row];
        
        vc.type = @"2";
    }
    
    vc.title = dic[@"fname"];
    
    vc.adid = dic[@"fid"];
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end

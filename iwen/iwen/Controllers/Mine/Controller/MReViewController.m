//
//  MReViewController.m
//  iwen
//
//  Created by sam on 16/10/16.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MReViewController.h"
#import "MyreCell.h"

#import "HMSegmentedControl.h"
@interface MReViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) HMSegmentedControl* segmentedControl;
@property (nonatomic, strong)  PersonModel      *userInfo;

@property (nonatomic, strong) UITableView *tab1;
@property (nonatomic, strong) UITableView *tab2;
@end

@implementation MReViewController

{
    
    
    NSDictionary *selecdic;
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
    
    self.title = @"我的发布";
    
    tab1List = [NSMutableArray array];
    tab2List = [NSMutableArray array];
    
       _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"在线宝贝",@"下架宝贝"]];
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
    
    
    self.scrollview.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-50);
    
    self.scrollview.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight-64-50);
    
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
    
    UINib *nib  = [UINib nibWithNibName:@"MyreCell" bundle:nil];
    [_tab1 registerNib:nib forCellReuseIdentifier:@"myrecell"];
    
    _tab1.separatorColor = SeparatorColor;
    
    [_tab1 clearSeperateLine];
    
    
    [_tab2 registerNib:nib forCellReuseIdentifier:@"myrecell"];
    
    _tab2.separatorColor = SeparatorColor;
    
    [_tab2 clearSeperateLine];
    
    
    [self configBlock];
    
    
    
    
    _tab1.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstload)];
    _tab1.footer = [MJRefreshAutoFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    
    _tab2.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(first2load)];
    _tab2.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(load2more)];
    
    [self loadData];
    
    [self.view addSubview:self.scrollview];
}



- (void)firstload{
    
    [[CircleService shareInstaced]getFirstOnWithId:self.userInfo.use.ftoken?self.userInfo.use.ftoken:@""];
}
- (void)loadmore{
    
    [[CircleService shareInstaced]getMoreOnWithId:self.userInfo.use.ftoken?self.userInfo.use.ftoken:@""];
}

- (void)first2load{
    
    [[CircleService shareInstaced]getFirstOffWithId:self.userInfo.use.ftoken?self.userInfo.use.ftoken:@""];
}
- (void)load2more{
    
    [[CircleService shareInstaced]getMoreOffWithId:self.userInfo.use.ftoken?self.userInfo.use.ftoken:@""];
}




-(void)loadData
{
    [_tab1.header beginRefreshing];
    __weak MReViewController * weakSelf = self;
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
    [CircleService shareInstaced].getonSuccess = ^(id obj){
        
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
        tab1List = [obj mutableCopy];
        [_tab1 reloadData];
        
        
        
    };
    
    [CircleService shareInstaced].getonFailure = ^(id obj){
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
        
    };
    
    [CircleService shareInstaced].getOffSuccess = ^(id obj){
        
        
        [_tab2.header endRefreshing];
        [_tab2.footer endRefreshing];
        tab2List = [obj mutableCopy];
        [_tab2 reloadData];
        
        
    };
    
    [CircleService shareInstaced].getOffFailure = ^(id obj){
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
            if([tab1List count] == 0)
            {
                [_tab1.header beginRefreshing];
            }
        }
        else if (scrollView.contentOffset.x == ScreenWidth)
        {
            [_segmentedControl setSelectedSegmentIndex:1 animated:YES];
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
    
    
    MyreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myrecell"];
    
    NSDictionary *dic;
    
    if (tableView == self.tab1) {
        
        
        dic = tab1List[indexPath.row];
        
    }
    else{
        
        dic = tab2List[indexPath.row];
    }
    
    
    if (dic) {
        
        cell.name.text = dic[@"fname"];
//
        
//        cell.price.text = [NSString stringWithFormat:@"￥%@",dic[@"fprice"]];
//        cell.oldpri.text = [NSString stringWithFormat:@"原价：%@",dic[@"foldPrice"]];
        cell.clicklab.text = [NSString stringWithFormat:@"浏览次数：%@",dic[@"fclickCount"]];
//        
        NSArray *ary =[dic[@"fimgs"] componentsSeparatedByString:@","];
        NSString *str = [ary firstObject];
        
        [cell.imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Release_Pic_URL,str]] placeholderImage:[UIImage imageNamed:@"123"]];
        
        NSString *date = [NSString stringWithFormat:@"%@",dic[@"fcreateTime"]];
        
        cell.blue.text =[NSString stringWithFormat:@"%@",dic[@"fcity"]];
        
        long long time = [date longLongValue]/1000;
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time];
        
        cell.datelab.text = [NSString stringWithFormat:@"发布日期：%@",[NSDate formatDateString:@"YYYY-MM-dd" withDate:date2]];
        NSString *staut =[NSString stringWithFormat:@"%@",dic[@"fstatus"]];
        if ([staut isEqualToString:@"1"]) {
            
            [cell.rebtn setTitle:@"下架宝贝" forState:UIControlStateNormal];
        }
        else{
            [cell.rebtn setTitle:@"上架宝贝" forState:UIControlStateNormal];

        }
        
        cell.rebtn.tag = indexPath.row;
        [cell.rebtn addTarget:self action:@selector(reaction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)reaction:(UIButton *)btn{
    
    
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        
        selecdic = tab1List[btn.tag];
        
    }
    else{
        
        selecdic = tab2List[btn.tag];
    }
    NSString *staut =[NSString stringWithFormat:@"%@",selecdic[@"fstatus"]];
    NSString *message;
    if ([staut isEqualToString:@"1"]) {
        message = @"是否下架该宝贝？";
    }
    else{
       
        message = @"是否重新上架该宝贝？";
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==1) {
        
        
        NSString *staut =[NSString stringWithFormat:@"%@",selecdic[@"fstatus"]];
      
        if ([staut isEqualToString:@"1"]) {
            [CircleService shareInstaced].addNewsSuccess = ^(id ojb){
                
                [self.tab1.header beginRefreshing];
            };
            [[CircleService shareInstaced]addNewsWitDic:@{@"token":self.userInfo.use.ftoken,@"status":@"downline",@"releaseId":[NSString stringWithFormat:@"%@",selecdic[@"fid"]]}];
            
            
            
            
        }
        else{
            [CircleService shareInstaced].addNewsSuccess = ^(id ojb){
                
                [self.tab2.header beginRefreshing];
            };
            [[CircleService shareInstaced]addNewsWitDic:@{@"token":self.userInfo.use.ftoken,@"status":@"added",@"releaseId":[NSString stringWithFormat:@"%@",selecdic[@"fid"]]}];
            
        }
        
        
        
        
        
        
        
        
    }
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *mode;
    if (_segmentedControl.selectedSegmentIndex == 0) {
        
        mode = tab1List[indexPath.row];
        
    }
    else{
        
        mode = tab2List[indexPath.row];
    }
    if (mode) {
        DetailViewController *vc = [[DetailViewController alloc]init];
        vc.type = @"re";
        vc.title = @"详情";
        vc.advId = [NSString stringWithFormat:@"%@",mode[@"fid"]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}




@end

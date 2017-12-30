//
//  ReViewController.m
//  iwen
//
//  Created by sam on 16/7/3.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ReViewController.h"
#import "MoneyModel.h"
#import "CircleCell.h"
#import "DetailViewController.h"
@interface ReViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIBarButtonItem *sendItem;
@end

@implementation ReViewController
{
    NSMutableArray *pullData;
    NSMutableArray *citylist;
    NSMutableArray *relist;
    NSMutableArray *sortList;
    NSMutableArray *moneyList;
    NSMutableArray *dataSourse;
    NSString *area;
    NSString *keyWord;
    NSString *startPrice;
    NSString *endPrice;
    NSString *Sequence;
    NSString *ftype;
    
}

- (UIBarButtonItem *)sendItem{
    
    if (_sendItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setBackgroundImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        _sendItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _sendItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTopView];
    [self layoutPullView];
    [self loadCityData];
    [self loadReData];
    [self loadLocalData];
    if (self.word.length>0) {
        
        self.text.text = self.word;
        keyWord = self.word;
        ftype = @"";

    }
    else{
        keyWord = @"";
        ftype = self.model.fid;

    }
    [self configData];
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadFirstNewWorkData];
    }];
    self.tableview.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadMoreNewWorkData];
    }];
    UINib *nib = [UINib nibWithNibName:@"CircleCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"cirCell"];
    [self.tableview.header beginRefreshing];
    [self.tableview clearSeperateLine];
    self.navigationItem.titleView = self.text;
    self.navigationItem.rightBarButtonItem = self.sendItem;
    self.tableview.frame = CGRectMake(0, 45, ScreenWidth, ScreenHeight-64-45);
    dataSourse = [NSMutableArray array];
    pullData = [NSMutableArray array];
}
- (void)done{
    
    if (self.text.text.length>0) {
        
        keyWord = self.text.text;
    }else{
        keyWord = @"";
        
    }
    [self.text resignFirstResponder];
    [self.tableview.header beginRefreshing];
}

- (void)configData{
    
    area = @"";
    
    startPrice = @"";
    endPrice =@"";
    Sequence = @"";
    
    [LearnService shareInstanced].getReListSuccess = ^(id obj){
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        dataSourse = [obj mutableCopy];
        [self.tableview reloadData];
        
    };
    [LearnService shareInstanced].getReListFailure = ^(id obj){
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
    };
}
-(void)layoutTopView{
    
    NSArray *ary = @[@"区域",@"分类",@"筛选",@"排序"];
    for (int i=0; i<ary.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * ScreenWidth/4, 0, ScreenWidth/4, 44)];
        btn.tag = i;
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(pull:) forControlEvents:UIControlEventTouchUpInside];
        [self.topVIew addSubview:btn];
        UILabel *lineLab= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4 * i, 2, 1, 40)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.topVIew addSubview:lineLab];
        
        
    }
    UILabel *lineLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, 1)];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [self.topVIew addSubview:lineLab];
    self.topVIew.frame = CGRectMake(0, 0, ScreenWidth, 45);
}

- (void)layoutPullView{
    self.pullView.frame = CGRectMake(0, 45, ScreenWidth, ScreenHeight-64-45);
    self.pullView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [self.view addSubview:self.pullView];
    self.pullView.hidden = YES;
    [self.pullTable clearSeperateLine];
    
}

-(void)loadCityData{
    if (!self.city.length>0) {
        self.city = @"广州市";
    }
    [[ExamService shareInstenced]cancleExamWithUid:self.city examId:nil];
    
    [ExamService shareInstenced].cancelExamSuccess = ^(id obj){
        
        
        NSMutableArray  *areas = [obj copy];
        citylist = [NSMutableArray array];
        NewsDetailModel *model1 = [[NewsDetailModel alloc]init];
        model1.areaName = @"不限";
        model1.id = @"";
        model1.areaNo = @"";
        [citylist addObject:model1];
        for (NSDictionary *dic in areas) {
            
            NewsDetailModel *model = [[NewsDetailModel alloc]initWithDictionary:dic error:nil];
            if (model) {
                [citylist addObject:model];
            }
            
        }
    };
}

- (void)loadReData{
    
    NSArray *temp = self.model.child;
    BlogData *data = [[BlogData alloc]init];
    data.fname = @"不限";
    data.fid = @"";
    relist = [NSMutableArray array];
    [relist addObject:data];
    [relist addObjectsFromArray:temp];
}

- (void)loadLocalData{
    
    MoneyModel *mod = [[MoneyModel alloc]init];
    mod.title = @"不限";
    moneyList = [NSMutableArray array];
    [moneyList addObject:mod];
    NSArray *starts = @[@"0",@"100",@"500",@"1000",@"5000",@"10000"];
    NSArray *ends = @[@"100",@"500",@"1000",@"5000",@"100000",@""];
    NSArray *tit =@[@"100元以下",@"100-500元",@"500元－1000元",@"1000元－5000元",@"5000元－1万元",@"1万元以上"];
    for (int i=0; i<starts.count; i++) {
        MoneyModel *mode = [[MoneyModel alloc]init];
        mode.startM = starts[i];
        mode.title = tit[i];
        mode.endM = ends[i];
        [moneyList addObject:mode];
    }
    sortList = [@[@"价格高到低",@"价格低到高"]mutableCopy];
}

- (void)pull:(UIButton *)btn{
    
    [pullData removeAllObjects];
    if (btn.tag == 0) {
        
        [pullData addObjectsFromArray:citylist];
    }
    if (btn.tag == 1) {
        
        [pullData addObjectsFromArray:relist];
    }
    if (btn.tag == 2) {
        
        [pullData addObjectsFromArray:moneyList];
    }
    if (btn.tag == 3) {
        
        [pullData addObjectsFromArray:sortList];
    }
    
    
    [self startAnimation];
}
- (void)startAnimation{
    [self.pullTable reloadData];
    self.pullView.hidden = NO;
    self.pullTable.frame = CGRectMake(0, -300, ScreenWidth, 300);
    [UIView animateWithDuration:.2 animations:^{
        
        self.pullTable.frame = CGRectMake(0, 0, ScreenWidth, 300);
        
    } completion:nil];
}
- (IBAction)hidepull:(UITapGestureRecognizer *)sender {

    self.pullView.hidden = YES;
}

- (NSMutableDictionary *)getParms{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:keyWord forKey:@"keyWord"];
    [dic setObject:area forKey:@"fcity"];
    [dic setObject:startPrice forKey:@"startPrice"];
    [dic setObject:endPrice forKey:@"endPrice"];
    [dic setObject:ftype forKey:@"ftype"];
    [dic setObject:Sequence forKey:@"sequence"];
    return dic;
}
- (void)loadFirstNewWorkData{
    [[LearnService shareInstanced]getFirstReListWithDic:[self getParms]];
    
}
- (void)loadMoreNewWorkData{
     [[LearnService shareInstanced]getMoreReListWithDic:[self getParms]];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view.tag == 99) {
        
        return YES;
    }
    return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    if (tableView == self.pullTable) {
        
        return pullData.count;
    }
    return dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableview) {
       ExamResultModel *model = dataSourse[indexPath.row];
       CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cirCell"];
        if (model) {
            NSArray *ary =[model.fimgs componentsSeparatedByString:@","];
            NSString *str = [ary firstObject];
         
            [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Release_Pic_URL,str]]];
            CGFloat fmoney=[model.fprice floatValue];
            CGFloat foldMoney = [model.foldPrice floatValue];
//            cell.titleLab.text = [NSString stringWithFormat:@"￥%.f",fmoney];
//            cell.oldLab.text = [NSString stringWithFormat:@"原价￥%.f",foldMoney];
            cell.subLab.text = model.fname;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.fcreateTime integerValue]/1000];
            cell.areaLab.text = model.area;
            cell.clickLab.text = [NSString stringWithFormat:@"浏览次数：%@",model.fclickCount];
            
            cell.dateLab.text =[NSString stringWithFormat:@"发布日期：%@",[date formatDateString:nil]];
         
        }
        
      return cell;

    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        
    }
    id obj = pullData[indexPath.row];
    if ([obj isKindOfClass:[NewsDetailModel  class]]) {
        
        NewsDetailModel *city= (NewsDetailModel *)obj;
        cell.textLabel.text =city.areaName;
    }
    else if ([obj isKindOfClass:[BlogData class]]) {
        
        BlogData *data = (BlogData *)obj;
        cell.textLabel.text =data.fname;
       
    }
    else if ([obj isKindOfClass:[MoneyModel class]]) {
        MoneyModel *mode =(MoneyModel *)obj;
        cell.textLabel.text= mode.title;
        
    }else{
       
        cell.textLabel.text =[NSString stringWithFormat:@"%@",obj];
    }
    
    return cell;

}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.pullTable) {
        
        id obj = pullData[indexPath.row];
        if ([obj isKindOfClass:[NewsDetailModel  class]]) {
            
            NewsDetailModel *city= (NewsDetailModel *)obj;
            area = city.areaNo;
        }
        else if ([obj isKindOfClass:[BlogData class]]) {
            
            BlogData *data = (BlogData *)obj;
            ftype = data.fid;
            
        }
        else if ([obj isKindOfClass:[MoneyModel class]]) {
            MoneyModel *mode =(MoneyModel *)obj;
            startPrice = mode.startM;
            endPrice = mode.endM;
            
        }else{
            
            if ([obj isEqualToString:@"价格高到低"]) {
                
                Sequence = @"0";
            }else{
                
                Sequence = @"1";
            }
        }
        [self hidepull:nil];
        [self.tableview.header beginRefreshing];

    }else{
        
        ExamResultModel *model = dataSourse[indexPath.row];
        DetailViewController *vc = [[DetailViewController alloc]init];
        vc.type = @"re";
        vc.title = @"详情";
        vc.advId = model.fid;
        [self.navigationController pushViewController:vc animated:YES];
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableview) {
        return 100;
    }
    return 44;
}




@end

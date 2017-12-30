//
//  RecordViewController.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordCell.h"

@interface RecordViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *leftArray;

@property (nonatomic, strong) NSMutableArray *rigArray;

@property (nonatomic, strong) PersonModel       *userInfo;

@end

@implementation RecordViewController{
    
    NSDictionary *tableDic;
    
}

#pragma mark getter
//
//- (NSMutableArray *)leftArray{
//    
//    if (!_leftArray) {
//        
//    _leftArray = [@[@[@"点击量"],@[@"红包总数",@"红包总金额",@"剩余红包数",@"剩余红包",@"投放日期"]]mutableCopy];
//        
//    }
//    return _leftArray;
//}


- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];

    }
    
    return _dataSource;
    
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
    
    [self setupUI];
    
    [self loadData];
    self.rigArray = [@[]mutableCopy];
}

- (void)setupUI{
    

    
    UINib *nib = [UINib nibWithNibName:@"RecordCell" bundle:nil];
    
    [self.collecRecordView registerNib:nib forCellWithReuseIdentifier:@"RecCell"];
    
    self.recordflow.minimumInteritemSpacing = 0.0f;
    self.recordflow.minimumLineSpacing     = 0.0f;
  
  

    
    [self.tableview setTableFooterView:self.recordView];
}


#pragma mark Action







#pragma mark Service

- (void)loadData{
    
    [self loadExamData];
    
}

- (void)loadExamData{
    
    NSDictionary *dic;
    if ([self.type isEqualToString:@"1"]) {
        
        _leftArray = [@[@[@"点击量"],@[@"红包总数",@"红包总金额",@"剩余红包数",@"剩余红包",@"投放日期"]]mutableCopy];
        dic = @{@"adId":self.adid};
    }
    else{
        
        _leftArray = [@[@[@"点击量"],@[@"优惠卷总数",@"优惠卷总金额",@"剩余",@"投放日期"]]mutableCopy];
         dic = @{@"couponId":self.adid};
    }
    [[ExamService shareInstenced]getExamRecordWithUid:dic type:self.type];
    
    
    [ExamService shareInstenced].getExamRecordSuccess = ^(id obj){
        
        self.dataSource = [obj[@"list"] mutableCopy];
        
        if ([self.type isEqualToString:@"1"]) {
            
            tableDic = obj[@"ad"];
            
            [self parseData];
        }
        else{
            tableDic = obj[@"coupon"];
            
            [self parseCoupenData];
        }
        
        
        [self.collecRecordView reloadData];
    };
    
    [ExamService shareInstenced].getExamRecordFailure = ^(id obj){
        
        [self showHudWithString:obj];
    };
    
}

- (void)parseData{
    
    id clickCount =tableDic[@"fclickConut"];
    
    if (!clickCount) {
        
        clickCount = @"";
    }
    
    
    id fredNum =[NSString stringWithFormat:@"%@个",tableDic[@"fredNum"]];
    
    if (!fredNum) {
        
        fredNum = @"";
    }
    
    NSString *fee2 = [NSString stringWithFormat:@"%@",tableDic[@"fredMoney"]];
    
    NSString *price2 = [NSString stringWithFormat:@"%.2f元",[fee2 floatValue]/100];
    
    id fredremainNum =[NSString stringWithFormat:@"%@个",tableDic[@"fredRemainNum"]];
    
    if (!fredremainNum) {
        
        fredremainNum = @"0个";
    }
    
    
    NSString *fee = [NSString stringWithFormat:@"%@",tableDic[@"fredRemainMoney"]];
    
    NSString *price = [NSString stringWithFormat:@"%.2f元",[fee floatValue]/100];
    
    
    
    NSString *date = [NSString stringWithFormat:@"%@",tableDic[@"fcreatetime"]];
    
    long long time = [date longLongValue]/1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *datestr   = [NSDate formatDateString:@"YYYY-MM-dd HH:mm:ss" withDate:date2];
    

    self.rigArray = [@[@[clickCount],@[fredNum,price2,fredremainNum,price,datestr]]mutableCopy];
    
    [self.tableview reloadData];
    
}

- (void)parseCoupenData{
    
    id clickCount =tableDic[@"fclickConut"];
    
    if (!clickCount) {
        
        clickCount = @"";
    }
    
    
    id fredNum =[NSString stringWithFormat:@"%@个",tableDic[@"fredNum"]];
    
    if (!fredNum) {
        
        fredNum = @"";
    }
    
    NSString *fee2 = [NSString stringWithFormat:@"%@",tableDic[@"fredMoney"]];
    
    NSString *price2 = [NSString stringWithFormat:@"%.2f元",[fee2 floatValue]/100];
    
    id fredremainNum =[NSString stringWithFormat:@"%@个",tableDic[@"fredRemainNum"]];
    
    if (!fredremainNum) {
        
        fredremainNum = @"0个";
    }
    
    
    NSString *fee = [NSString stringWithFormat:@"%@",tableDic[@"fredRemainMoney"]];
    
    NSString *price = [NSString stringWithFormat:@"%.2f元",[fee floatValue]/100];
    
    
    
    NSString *date = [NSString stringWithFormat:@"%@",tableDic[@"fcreatetime"]];
    
    long long time = [date longLongValue]/1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *datestr   = [NSDate formatDateString:@"YYYY-MM-dd HH:mm:ss" withDate:date2];
    
    
    self.rigArray = [@[@[clickCount],@[fredNum,price2,fredremainNum,datestr]]mutableCopy];
    
    [self.tableview reloadData];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.leftArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.leftArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.textLabel.text = self.leftArray[indexPath.section][indexPath.row];
    
    if (tableDic) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.rigArray[indexPath.section][indexPath.row]];

    }
    return cell;
    
}

#pragma mark UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}




#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
        
        return self.dataSource.count;
   
    
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    RecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecCell" forIndexPath:indexPath];
   
        
//    ExamRecordModel *model = self.dataSource[indexPath.row];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    if (dic) {
        
        cell.dateLab.text = dic[@"time"];
        
        cell.model = dic;
        
    }
//    
   
    


    
    return cell;
    
}



#pragma mark UICollectionViewDelegate



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
  
        

        
//        ExamRecordModel *model = self.dataSource[indexPath.row];
  

}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake(60, 250);
    
}



@end

//
//  LearnMainViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LearnMainViewController.h"
#import "LearnListViewController.h"
#import "LearnDetailViewController.h"
#import "TitleCell.h"
#import "LearningCell.h"
@interface LearnMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *tableData;
//
//@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIPageViewController *pageVc;


@end

@implementation LearnMainViewController
{
    
    NSString *selectId;
    
}


#pragma mark getter

- (UIPageViewController *)pageVc{
    
    if (_pageVc == nil) {
        
        _pageVc = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        _pageVc.delegate = self;
        
        _pageVc.view.backgroundColor = [UIColor whiteColor];
        
        _pageVc.dataSource = self;
        
    }
    
    return _pageVc;
}

- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
    }
    
    return _dataSource;
    
}
- (NSMutableArray *)tableData{
    
    if (_tableData == nil) {
        
        _tableData = [NSMutableArray array];
        
    }
    
    return _tableData;
    
}



#pragma mark ViewLife cyle
- (id)init{
    
    self = [super init];
    
    if (self) {
        
       
        
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self loadCourType];
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (self.dataSource.count>0) {
        
//        self.tableview.userInteractionEnabled = YES;
    }
    else{
        
//        self.tableview.userInteractionEnabled = NO;
        
        [self loadCourType];
        
        
    }
}


- (void)setupUI{
    
    
    self.title  = @"抢优惠";
    
    UINib *nib = [UINib nibWithNibName:@"TitleCell" bundle:nil];
    
    
    [self addChildViewController:self.pageVc];
    
    self.pageVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-64-46);
    
    [self.pageVc didMoveToParentViewController:self];
    
    
    [self.contenView addSubview:self.pageVc.view];
    
    [self.collecview registerNib:nib forCellWithReuseIdentifier:@"myTitleCell"];

    self.collecview.backgroundColor = BackgroundColor;
    
//    UINib *nib1 = [UINib nibWithNibName:@"LearningCell" bundle:nil];
//    
//    [self.tableview registerNib:nib1 forCellReuseIdentifier:@"learCell"];
//    
//    [self configTableView];
//    
//    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableData)];
//
//    
//    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableData)];
    
    
    for (UIView *view in self.pageVc.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            
            UIScrollView *scrollview = (UIScrollView *)view;
            
            scrollview.delegate = self;
            
            
        }
        
    }
    
}





#pragma mark Action





#pragma mark Service

- (void)loadCourType{
    
    
    [[ExamService shareInstenced]getCourseType];
    
    [ExamService shareInstenced].getCourseTypeSuccess = ^(id obj){
        
//        self.tableview.userInteractionEnabled = YES;
        
        [self.dataSource removeAllObjects];
      
        NSDictionary *dic = @{@"fid":@"",
                              @"fname":@"全部",
                              @"fpid":@"0"
                              
                              };
        
        [self.dataSource addObjectsFromArray:@[dic]];
        [self.dataSource addObjectsFromArray:obj];
        
        [self.collecview reloadData];
        
        [self.tableData removeAllObjects];
        
        for (int a=0; a<self.dataSource.count;a++) {
            
            LearnListModel *model = [[LearnListModel alloc]init];
            
            model.data = [NSMutableArray array];
            
            model.index = [NSString stringWithFormat:@"%d",a];
            
            [self.tableData addObject:model];
            
        }
        
        
        
        [self reloadPageWithIndex:0];
        
//       [self.tableview.header beginRefreshing];
    };
    
}

- (void)loadTableData{
    
    [[LearnService shareInstanced]getFirstCourseListWithType:selectId];
    
}

- (void)loadMoreTableData{
    
    [[LearnService shareInstanced]getMoreCourseListWithType:selectId];
    
}

- (void)configTableView{
//    
//    [LearnService shareInstanced].getCourseListSuccess = ^(id obj){
//        
//        self.tableData = (NSMutableArray *)obj;
//        
//        [self.tableview reloadData];
//        
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//        
//    };
//    
//    [LearnService shareInstanced].getCourseListFailure = ^(id obj){
//        
//        [self showHudWithString:obj];
//        
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//        
//    };
    
}
- (void)reloadPageWithIndex:(NSUInteger)index{
    
    NSDictionary *dic      = self.dataSource[index];
    
    selectId = [NSString stringWithFormat:@"%@",dic[@"fid"]];

    
    LearnListViewController *vc = [self viewControllerAtIndex:index];
    
    
    [self.pageVc setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)reloadCollectView{
    
//    [self.collecview reloadData];
//    
//    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:index inSection:0];
//    
//    [self.collecview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    LearnListViewController *vc = [self.pageVc.viewControllers firstObject];
    vc.city = self.city;
    LearnListModel *model = vc.data;

    if (vc) {

        [self.collecview reloadData];

        int a = [model.index intValue];


        NSDictionary *dic      = self.dataSource[a];

        selectId = [NSString stringWithFormat:@"%@",dic[@"fid"]];


        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:a inSection:0];

        [self.collecview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        
        
    }
    
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
////    NSLog(@"********** %@",selectId);
//    
//   
//    
//    LearnListViewController *vc = [self.pageVc.viewControllers firstObject];
//    
//    LearnListModel *model = vc.data;
//    
//    if (vc) {
//        
//        [self.collecview reloadData];
//          
//        int a = [model.index intValue];
//        
//        
//        CourseTypeModel *model      = self.dataSource[a];
//        
//        selectId = model.id;
//        
//        
//        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:a inSection:0];
//        
//        [self.collecview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//        
//        
//    }
//    
//    
//    
//    
//}
#pragma mark UIPageViewControllerDataSource

- (LearnListViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.tableData count] == 0) ||
        (index >= [self.tableData count])) {
        return nil;
    }
    
    LearnListViewController *dataViewController = [[LearnListViewController alloc]init];
    
    dataViewController.data = [self.tableData objectAtIndex:index];
    
    NSDictionary *dic      = self.dataSource[index];
    
    selectId = [NSString stringWithFormat:@"%@",dic[@"fid"]];
    
    
    
    dataViewController.selectedId = selectId;
    
    return dataViewController;
}
- (NSUInteger)indexOfViewController:(LearnListViewController *)viewController {


    return [self.tableData indexOfObject:viewController.data];
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (LearnListViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (LearnListViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.tableData count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return  self.dataSource.count;

}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
       
    TitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myTitleCell" forIndexPath:indexPath];
    
    cell.layer.masksToBounds    = YES;
    cell.layer.cornerRadius     = 4;
    
    
    NSDictionary *dic      = self.dataSource[indexPath.row];
    cell.titLab.text            = dic[@"fname"];
    
    if ([selectId isEqualToString:[NSString stringWithFormat:@"%@",dic[@"fid"]]]) {
        
        cell.titLab.backgroundColor = BaseColor;
        cell.titLab.textColor       = [UIColor whiteColor];
        
    }else{
        
        cell.titLab.backgroundColor = BackgroundColor;
        cell.titLab.textColor       = [UIColor blackColor];
        
    }
    
    
    return cell;
    
}



#pragma mark UICollectionViewDelegate



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     NSDictionary *dic      = self.dataSource[indexPath.row];
    
     selectId = [NSString stringWithFormat:@"%@",dic[@"fid"]];
    
     [self.collecview reloadData];
    
    
    [self reloadPageWithIndex:indexPath.row];
    
//     [self.tableview.header beginRefreshing];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake(100, 35);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}




@end

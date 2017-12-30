//
//  UserWeiCoViewController.m
//  iwen
//
//  Created by sam on 16/8/18.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "UserWeiCoViewController.h"
#import "WeiCoCell.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
@interface UserWeiCoViewController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate,WeiCoCellDelegate>
@property (nonatomic, strong)MWPhotoBrowser *browser;
@property (nonatomic, strong)  UIBarButtonItem *settingItem;
@end

@implementation UserWeiCoViewController
{
    NSMutableArray *list;
    NSMutableArray *userList;
    NSMutableArray *photos;
    AVAudioPlayer *palyer;
    PersonModel *userInfo;
}

- (MWPhotoBrowser *)browser{
    
    if (_browser == nil) {
        
        BOOL displayActionButton = NO;
        BOOL displaySelectionButtons = NO;
        BOOL displayNavArrows = NO;
        BOOL enableGrid = YES;
        BOOL startOnGrid = NO;
        
        enableGrid = NO;
        
        
        // Create browser
        _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _browser.displayActionButton = displayActionButton;//分享按钮,默认是
        _browser.displayNavArrows = displayNavArrows;//左右分页切换,默认否
        _browser.displaySelectionButtons = displaySelectionButtons;//是否显示选择按钮在图片上,默认否
        _browser.alwaysShowControls = displaySelectionButtons;//控制条件控件 是否显示,默认否
        _browser.zoomPhotosToFill = NO;//是否全屏,默认是
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        browser.wantsFullScreenLayout = YES;//是否全屏
#endif
        _browser.enableGrid = enableGrid;//是否允许用网格查看所有图片,默认是
        _browser.startOnGrid = startOnGrid;//是否第一张,默认否
        _browser.enableSwipeToDismiss = YES;
        [_browser showNextPhotoAnimated:YES];
        [_browser showPreviousPhotoAnimated:YES];
        [_browser setCurrentPhotoIndex:0];
    }
    
    return _browser;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    userInfo = [[LoginService shareInstanced]getUserModel];
    
    
    list = [NSMutableArray array];
    userList = [NSMutableArray array];
    [self.tableview registerNibWithName:@"WeiCoCell" reuseIdentifier:@"WeiCo"];
    
  
    [self config];
    
    NSString *ftokn = [NSString stringWithFormat:@"user%@",self.userId];

    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getFirstCourseListWithType:ftokn];
    }];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getMoreCourseListWithType:ftokn];
    }];
    
    [self.tableview.header beginRefreshing];
    
  

}

- (void)config{
    

    [LearnService shareInstanced].getCourseListSuccess = ^(id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
        list = [obj mutableCopy];
        [self.tableview reloadData];
    };
    
    [LearnService shareInstanced].getCourseListFailure = ^(id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
    };
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CourseListModel *model = list[indexPath.row];
    
    return [WeiCoCell heihtForModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    WeiCoCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"WeiCo"];
    
    CourseListModel *model = list[indexPath.row];
    
    cell.model = model;
    cell.delegate = self;
    if (self.userId.length>0) {
        cell.delbtn.hidden = YES;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark WeiCoCellDelegate
- (void)didShowPhotoWithModel:(CourseListModel *)model{
    
    
    NSArray *ary = [model.fimgs componentsSeparatedByString:@","];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSString *str in ary) {
        
        if (str.length>0) {
            
            [temp addObject:[NSString stringWithFormat:@"%@%@",China_Pic_URL,str]];
            
        }
        
    }
    
    photos = [temp copy];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.browser reloadData];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didDelPhotoWithModel:(CourseListModel *)model{
    
    
    [[ExamService shareInstenced]delErrorTitleWithUid:userInfo.use.ftoken tid:model.fid];
    
    [self showHud];
    [ExamService shareInstenced].delErrorSuccess = ^(id obj){
        
        [self hideHud];
        
        NSUInteger index = [list indexOfObject:model];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
        [list removeObject:model];
        [self.tableview beginUpdates];
        [self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableview endUpdates];
        
    };
    
    [ExamService shareInstenced].delErrorFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
}

- (void)didLikePhotoWithModel:(CourseListModel *)model{
    
    [[ExamService shareInstenced]addExamLikeWithUid:userInfo.use.ftoken tid:model.fid type:@"chineseDressId"];
    
    [self showHud];
    [ExamService shareInstenced].addExamLikeSuccess = ^(id obj){
        
        [self hideHud];
        palyer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"say_3q" ofType:@"mp3"]] error:nil];
        [palyer play];
        NSUInteger index = [list indexOfObject:model];
        
        model.fclickCount = [NSString stringWithFormat:@"%d",[model.fclickCount intValue] +1];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableview beginUpdates];
        [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableview endUpdates];
        
    };
    
    [ExamService shareInstenced].addExamLikeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:photos[index]]];
    
    return photo;
    
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    //if (index < _thumbs.count)
    //return [_thumbs objectAtIndex:index];
    return nil;
}




- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

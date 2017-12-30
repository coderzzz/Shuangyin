//
//  WeicoViewController.m
//  iwen
//
//  Created by Interest on 16/3/11.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "WeicoViewController.h"
#import "WeiCoCell.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "SendWeicoViewController.h"
#import "UserListCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SDWebImageManager.h"
#import "UserWeiCoViewController.h"
@interface WeicoViewController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate,WeiCoCellDelegate>
@property (nonatomic, strong)MWPhotoBrowser *browser;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UITableView *vtableview;
@property (nonatomic, strong)  UIBarButtonItem *settingItem;
@property (strong, nonatomic) IBOutlet UIView *playview;
@property (weak, nonatomic) IBOutlet UIButton *cbtn;


@end

@implementation WeicoViewController
{
    NSMutableArray *list;
    NSMutableArray *userList;
    NSMutableArray *vlist;
    NSMutableArray *photos;
    AVAudioPlayer *player;
    
    AVPlayer *play;
    AVPlayerLayer *layer;
    
    
    MPMoviePlayerController *mplayer;
    PersonModel *userInfo;
    UIGestureRecognizer *ges;
    MBProgressHUD *hud;
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
- (UIBarButtonItem *)settingItem{
    
    if (_settingItem  == nil) {
        
        UIButton *blogItem         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [blogItem setImage:[UIImage imageNamed:@"发表"] forState:UIControlStateNormal];
        [blogItem addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        _settingItem = [[UIBarButtonItem alloc]initWithCustomView:blogItem];
        
        
    }
    
    return _settingItem;
}
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
//        NSURL *url=[NSURL URLWithString:model.video_info];
//        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
//        _moviePlayer.view.frame=CGRectMake(15, 85, ScreenWidth-30, 225);
//        
//        _moviePlayer.shouldAutoplay= NO;
//        
//        _moviePlayer.scalingMode = MPMovieScalingModeFill;
//        
//        _moviePlayer.controlStyle = MPMovieControlStyleNone;
//        
//        self.controls.frame = _moviePlayer.view.bounds;
//        
//        [_moviePlayer.view addSubview:self.controls];
//        
//        [self.headview addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}
- (void)setting{

    SendWeicoViewController *vc = [[SendWeicoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)actionges:(id)sender {
    
    [play pause];
    [layer removeFromSuperlayer];
    [self.playview removeFromSuperview];
   
}


- (NSURL *)saveURLwithfileName:(NSString *)fileName {
    
    NSURL *saveURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    saveURL = [saveURL URLByAppendingPathComponent:fileName];
    return saveURL;
}

- (void)updateProgress:(int64_t)receiveDataLength totalDataLength:(int64_t)totalDataLength; {
    dispatch_async(dispatch_get_main_queue(), ^{ //使用主队列异步方式（主线程）执行更新 UI 操作
        hud.progress = (float)receiveDataLength / totalDataLength;
        
        if (receiveDataLength == totalDataLength) {
//            _lblMessage.text =  receiveDataLength < 0 ? @"下载失败" : @"下载完成";
            //kApplication.networkActivityIndicatorVisible = NO;
            [hud hide:YES];
        } else {
//            _lblMessage.text = @"下载中...";
            //kApplication.networkActivityIndicatorVisible = YES;
            [hud show:YES];
        }
    });
}


- (void)downloadWithURL:(NSString *)url cell:(WeiCoCell *)cell{
    
    NSString *savePath = [[self saveURLwithfileName:url] path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在旧的目标文件，如果存在就先移除；避免无法复制问题
    
    
    if ([fileManager fileExistsAtPath:savePath]){
        
        play = [[AVPlayer alloc]initWithURL:[self saveURLwithfileName:url]];
        layer = [AVPlayerLayer playerLayerWithPlayer:play];
        layer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.playview.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self.playview.layer addSublayer:layer];
        [self.navigationController.view addSubview:self.playview];
        
        [play play];
        [self.playview bringSubviewToFront:self.cbtn];
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.76.112.202/uploadImg/video/%@",url]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
              
        [self updateProgress:totalBytesRead totalDataLength:totalBytesExpectedToRead];
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"已经接收完所有响应数据");
        
        NSData *data = (NSData *)responseObject;
        [data writeToFile:savePath atomically:YES];//responseObject 的对象类型是 NSData
        [self updateProgress:100 totalDataLength:100];
        
        
        play = [[AVPlayer alloc]initWithURL:[self saveURLwithfileName:url]];
        layer = [AVPlayerLayer playerLayerWithPlayer:play];
        
        layer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.playview.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self.playview.layer addSublayer:layer];
        [self.navigationController.view addSubview:self.playview];
        
        [play play];
        UIImage *image =[self thumbnailImageForVideo:[self saveURLwithfileName:url] atTime:0];
        [[SDWebImageManager sharedManager]saveImageToCache:image forURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.baidu.com/%@",url]]];
        [self.tableview reloadData];
        [self.playview bringSubviewToFront:self.cbtn];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败，错误信息：%@", error.localizedDescription);
        
        [self updateProgress:-1 totalDataLength:-1];
    }];
    
    //启动请求操作
    [operation start];
}

- (void)tap:(id)sender {
    
    
    
}


- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

- (IBAction)segAction:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    if (seg.selectedSegmentIndex == 0) {
        
        self.tableview.hidden = YES;
        self.userTableView.hidden = NO;
        self.vtableview.hidden = YES;
    }
    else if(seg.selectedSegmentIndex == 1) {
        
        self.tableview.hidden = NO;
        self.userTableView.hidden = YES;
        self.vtableview.hidden = YES;
    }
    else{
        [self.vtableview.header beginRefreshing];
        self.tableview.hidden = YES;
        self.userTableView.hidden = YES;
        self.vtableview.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userInfo = [[LoginService shareInstanced]getUserModel];
    
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"下载中...";
    [hud hide:YES];
    [self.view addSubview:hud];
    
    
    self.navigationItem.titleView = self.segment;
    self.userTableView.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    self.tableview.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    self.vtableview.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    list = [NSMutableArray array];
    userList = [NSMutableArray array];
    vlist = [NSMutableArray array];
    [self.tableview registerNibWithName:@"WeiCoCell" reuseIdentifier:@"WeiCo"];
    
   [self.userTableView registerNibWithName:@"UserListCell" reuseIdentifier:@"UserCell"];
    [self.vtableview registerNibWithName:@"WeiCoCell" reuseIdentifier:@"WeiCo"];
    [self config];
    
    NSString *ftokn = @"";
    
    if ([self.type isEqualToString:@"2"]) {
        
        ftokn = userInfo.use.ftoken;
        self.userTableView.hidden = YES;
        self.vtableview.hidden = YES;
    }
    else{
         self.tableview.hidden = YES;
        self.vtableview.hidden = YES;
//        self.navigationItem.titleView = self.segment;
        self.navigationItem.rightBarButtonItem = self.settingItem;
    }
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getFirstCourseListWithType:ftokn];
    }];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getMoreCourseListWithType:ftokn];
    }];
    
    [self.tableview.header beginRefreshing];
    
    ///
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getFirstUserList];
    }];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getMoreUserList];
    }];
    [self.userTableView.header beginRefreshing];
    
    self.vtableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getFirstvList];
    }];
    
    self.vtableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[LearnService shareInstanced]getMorevList];
    }];
//    [self.vtableview.header beginRefreshing];
    
    
}

- (void)config{
    
    [LearnService shareInstanced].getUserListSuccess = ^(id obj){
        
        [self.userTableView.header endRefreshing];
        [self.userTableView.footer endRefreshing];
        
        userList = [obj mutableCopy];
        [self.userTableView reloadData];
    };
    
    [LearnService shareInstanced].getUserListFailure = ^(id obj){
        
        [self.userTableView.header endRefreshing];
        [self.userTableView.footer endRefreshing];
        
    };
    
    
    [LearnService shareInstanced].getVideoListSuccess = ^(id obj){
        
        [self.vtableview.header endRefreshing];
        [self.vtableview.footer endRefreshing];
        
        vlist = [obj mutableCopy];
        [self.vtableview reloadData];
    };
    
    [LearnService shareInstanced].getVideoListFailure = ^(id obj){
        
        [self.vtableview.header endRefreshing];
        [self.vtableview.footer endRefreshing];
        
    };
    
    
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
    
    if (tableView == self.userTableView) {
        
        return 80;
    }
    if (tableView == self.vtableview) {
        
        ViedeoModel *model = vlist[indexPath.row];
        
        return [WeiCoCell heihtForvModel:model];

    }
    CourseListModel *model = list[indexPath.row];
    
    return [WeiCoCell heihtForModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.userTableView) {
        return userList.count;
    }
    if (tableView == self.vtableview) {
        
        return vlist.count;
    }
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.userTableView) {
        
        UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        UserListModel *model = userList[indexPath.row];
        cell.nameLab.text = model.frealName;
        cell.ageLab.text = [NSString stringWithFormat:@"%ld岁",(long)[model.fage integerValue]];
        if ([model.fsex isEqualToString:@"man"]) {
            
            cell.sexLab.text = @"男";
        }
        else{
            cell.sexLab.text = @"女";
        }
        cell.counLab.text = [NSString stringWithFormat:@"人气：%@",model.fscore];
        if (model.fsignature.length>0) {
    
            cell.sigLab.text = model.fsignature;
        }
        [cell.headImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",User_Pic_URL,model.fheadImg]] placeholderImage:DefaultAvatar];
        return cell;
    }
    else{
     
        WeiCoCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"WeiCo"];
        
        
        if (tableView == self.vtableview) {
            
            ViedeoModel *model = vlist[indexPath.row];
            cell.vmodel = model;
        }
        else{
            CourseListModel *model = list[indexPath.row];
            cell.model = model;
        }
        
        
        cell.delegate = self;
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.userTableView) {
        UserListModel *model = userList[indexPath.row];
        UserWeiCoViewController *vc = [[UserWeiCoViewController alloc]init];
        vc.userId =model.fid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark WeiCoCellDelegate
- (void)didPlayWithModel:(ViedeoModel *)model cell:(WeiCoCell *)cell{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.76.112.202/uploadImg/video/%@",model.fvideoUrl]];
    [self downloadWithURL:model.fvideoUrl cell:cell];
//    mplayer = [[MPMoviePlayerController alloc]initWithContentURL:url] ;
//    mplayer.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    mplayer.shouldAutoplay= NO;
//    mplayer.view.userInteractionEnabled = YES;
//    mplayer.scalingMode =MPMovieScalingModeAspectFill;
//    mplayer.controlStyle = MPMovieControlStyleNone;
//    self.playview.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    [self.navigationController.view addSubview:mplayer.view];
//    [self.navigationController.view addSubview:self.playview];
//  
//    [mplayer play];

    
}
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

- (void)didLikePhotoWithModel:(id)model{
    
    if ([model isKindOfClass:[ViedeoModel class]]) {
        
        ViedeoModel *m =(ViedeoModel *)model;
        [[ExamService shareInstenced]addExamLikeWithUid:userInfo.use.ftoken tid:m.fid type:@"userId"];
    }
    else{
        CourseListModel *m =(CourseListModel *)model;
        [[ExamService shareInstenced]addExamLikeWithUid:userInfo.use.ftoken tid:m.fid type:@"chineseDressId"];
    }
    
    
    [self showHud];
    [ExamService shareInstenced].addExamLikeSuccess = ^(id obj){
        
        [self hideHud];
        
        if (!self.tableview.isHidden) {
            NSUInteger index = [list indexOfObject:model];
            
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"say_3q" ofType:@"mp3"]] error:nil];//使用本地URL创建
            
            [player play];
            CourseListModel *m =(CourseListModel *)model;
            m.fclickCount = [NSString stringWithFormat:@"%d",[m.fclickCount intValue] +1];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableview beginUpdates];
            [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableview endUpdates];
        }
        else{
            NSUInteger index = [vlist indexOfObject:model];
            
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"say_3q" ofType:@"mp3"]] error:nil];//使用本地URL创建
            
            [player play];
            ViedeoModel *m =(ViedeoModel *)model;
            m.fvideoLikeCount = [NSString stringWithFormat:@"%d",[m.fvideoLikeCount intValue] +1];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.vtableview beginUpdates];
            [self.vtableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            [self.vtableview endUpdates];
        }
        
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

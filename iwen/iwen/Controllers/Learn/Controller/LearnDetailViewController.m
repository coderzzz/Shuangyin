//
//  LearnDetailViewController.m
//  iwen
//
//  Created by Interest on 15/11/6.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LearnDetailViewController.h"
#import "DetailCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ALMoviePlayerControls.h"


@interface LearnDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UserModel      *userInfo;

@property (nonatomic, strong) ALMoviePlayerControls *controls;

@property (nonatomic, strong) UIBarButtonItem * readItem;

@property (nonatomic, strong) UIBarButtonItem * likeItem;

@property (nonatomic, strong) UIBarButtonItem * spaceItem;

@end

@implementation LearnDetailViewController
{
    
    CourseListModel * model;
    
    UIButton        * readbtn;
    
    UIButton        * likebtn;

}
#pragma mark getter

- (UIBarButtonItem *)readItem{
    
    if (_readItem  == nil) {
        
        readbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        
        [readbtn setImage:[UIImage imageNamed:@"圈子-详情-阅览1"] forState:UIControlStateNormal];
        
        readbtn.imageEdgeInsets = UIEdgeInsetsMake(-9, 10, 0, 10);
        
        [readbtn setTitle:@"12" forState:UIControlStateNormal];
        
        readbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -30, 0);
        
        [readbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        readbtn.titleLabel.font   = [UIFont systemFontOfSize:12.0];
        
        readbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [readbtn addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
        
        _readItem = [[UIBarButtonItem alloc]initWithCustomView:readbtn];
        
        
    }
    
    return _readItem;
}


- (UIBarButtonItem *)likeItem{
    
    if (_likeItem  == nil) {
        
        likebtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        
        [likebtn setImage:[UIImage imageNamed:@"圈子-详情-点赞1"] forState:UIControlStateNormal];
        
        likebtn.imageEdgeInsets = UIEdgeInsetsMake(-9, 10, 0, 10);
        
        [likebtn setTitle:@"12" forState:UIControlStateNormal];
        
        likebtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -30, 0);
        
        [likebtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        likebtn.titleLabel.font   = [UIFont systemFontOfSize:12.0];
        
        likebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [likebtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
        
        _likeItem = [[UIBarButtonItem alloc]initWithCustomView:likebtn];
        
        
    }
    
    return _likeItem;
}



- (UIBarButtonItem *)spaceItem{
    
    if (_spaceItem == nil) {
        
        _spaceItem  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                   target:self
                                                                   action:nil];
        
    }
    
    return _spaceItem;
    
}

- (ALMoviePlayerControls *)controls{
    
    if (_controls == nil) {
        
        
        _controls = [[ALMoviePlayerControls alloc]initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleEmbedded];
        
    }
    
    return _controls;
}

- (UserModel *)userInfo{
    
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
#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    [self setUpUi];
   
    [self loadData];
}

- (void)setUpUi{
    
    self.title = @"详情";
    
     self.toobar.items                      = @[self.readItem,self.spaceItem,self.likeItem];
    
    UINib *nib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"LearnDetailCell"];
    
    [self.tableview setTableHeaderView:self.headview];
    

}
#pragma mark Notification

-(void)addNotification{
    
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    //    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];

    [notificationCenter addObserver:self selector:@selector(mediaPlayerWillEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerWillExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    
}


-(void)mediaPlayerWillEnterFullscreen:(NSNotification *)notification{

    
    _moviePlayer.scalingMode = nil;
    
    _controls.hidden = YES;
    
    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.player = @"play";
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];

        int val;

        val = UIDeviceOrientationLandscapeRight;
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

-(void)mediaPlayerWillExitFullscreen:(NSNotification *)notification{

    
    _moviePlayer.controlStyle = MPMovieControlStyleNone;
    
    _controls.hidden = NO;

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.player = nil;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        
        
        int val;
        
        
        val = UIDeviceOrientationPortrait;
        
       
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    
    [self performSelector:@selector(updateScal) withObject:nil afterDelay:1];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
  
}

- (void)updateScal{
    
    _moviePlayer.scalingMode = MPMovieScalingModeFill;
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden
{
    
    return NO;
}

-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",(long)self.moviePlayer.playbackState);
            break;
    }
}

#pragma mark Action

- (void)back{

    [self.moviePlayer stop];
    
    self.moviePlayer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)updateToolbarItem{
    
//    [likebtn setTitle:model.sign forState:UIControlStateNormal];
//    
//    [readbtn setTitle:model.read_times forState:UIControlStateNormal];
//    
//    UIImage *likeImage;
//    
//    if ([model.signflag boolValue]) {
//        
//        likeImage = [UIImage imageNamed:@"圈子-详情-点赞1"];
//    }
//    else{
//        
//        likeImage = [UIImage imageNamed:@"圈子-详情-点赞2"];
//    }
//    
//    [likebtn setImage:likeImage forState:UIControlStateNormal];
    
}
- (void)read{
    
    
}


- (void)like{
    
    [self showHud];
    
    [LearnService shareInstanced].signCourseSuccess = ^(id obj){
        
        [self hideHud];
        
       
//        model.sign = obj[@"sign"];
//        
//        model.signflag =obj[@"flag"];

        [self updateToolbarItem];
   
        
    };
    
    [LearnService shareInstanced].signCourseFailure = ^(id obj){
        
        [self hideHud];
        
        
    };
    
    [[LearnService shareInstanced]signCourseWithUid:self.userInfo.uid cid:self.cid];
    
}


#pragma mark Service

- (void)loadData{
    
    
    [[LearnService shareInstanced]getCourseWithUid:self.userInfo.uid cid:self.cid];
    
    [LearnService shareInstanced].getCourseSuccess = ^(id obj){
        
        model = obj;
        
//        self.titlelab.text = model.name;
//        
//        self.subLab.text  =model.sub_name;
//        
//        self.timeLab.text = model.add_time;
//        
        [self.moviePlayer prepareToPlay];
        
        [self updateToolbarItem];
        
        [self.tableview reloadData];
        
    };
    
    [LearnService shareInstanced].getCourseFailure = ^(id obj){
        
        [self showHudWithString:obj];
    };
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LearnDetailCell"];
    
       
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str;
    
//    if (indexPath.row == 0) str = model.schedule;
//    
//    if (indexPath.row == 1) str = model.suitable_people;
//    
//    if (indexPath.row == 2) str = model.instructional_obj;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(ScreenWidth-35, 0) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{
                                                         NSFontAttributeName:[UIFont systemFontOfSize:13.0],
                                                         NSParagraphStyleAttributeName:paragraphStyle
                                                         }
                                               context:nil].size;
    
    CGFloat h = retSize.height;
    
//    CGFloat h = [RTLabel getHightWithString:str andSizeValue:14.0 andWidth:ScreenWidth-35];
    
    if (h+43<60) {
        return 60;
    }
    return h+43;

}


-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.moviePlayer = nil;
    
}




@end

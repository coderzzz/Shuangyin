//
//  DetailViewController.m
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "DetailViewController.h"
#import "DetCell.h"
#import "DetailCell.h"
#import "AdvertisementView.h"
#import "MyAdvViewController.h"
#import "SignInViewController.h"
#import "WebViewController.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,AdvertisementViewDelegate,UIAlertViewDelegate,MWPhotoBrowserDelegate>

@property (nonatomic, strong) AdvertisementView *adView;
@property (nonatomic, strong)MWPhotoBrowser *browser;
@property (nonatomic, strong) PersonModel *userModel;
@end

@implementation DetailViewController
{
    NSDictionary *dataDic;
    
    NSMutableArray *leftList;
    
    NSMutableArray *rightList;
    ExamResultModel *model;
    AVAudioPlayer *player;
    NSMutableArray *photos;
}
#pragma mark getter
- (AdvertisementView *)adView{
    
    if (_adView == nil) {
        
        _adView = [[AdvertisementView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
        _adView.dele = self;
    }
    
    return _adView;
    
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

- (PersonModel *)userModel{
    
    if (!_userModel) {
        
        _userModel = [[LoginService shareInstanced]getUserModel];
    }
    
    return _userModel;
    
}

#pragma mark ViewLife cyle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.adView startTime];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.adView stopTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataDic = [NSDictionary dictionary];
    
    self.redView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    
    
    UINib *detNib = [UINib nibWithNibName:@"DetCell" bundle:nil];
    
    UINib *detailNib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    
    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"detail"];
    
    [self.tableview registerNib:detNib forCellReuseIdentifier:@"DetCell"];
    
    
    photos = [NSMutableArray array];
    [self.tableview setTableFooterView:self.footview];
    
    self.redView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.navigationController.view addSubview:self.redView];
    
    self.redView.hidden = YES;
    if (self.type.length>0) {
        self.flogo.layer.masksToBounds = YES;
        self.flogo.layer.cornerRadius = 20;
        [self loadReData];
    }
    else{
        [self loadData];
    }
    
    
}

#pragma mark Action

- (IBAction)getred:(id)sender {
    
   
    if (!self.atext.text.length>0) {
        
        [self showHudWithString:@"请输入答案"];
        return;
    }
    
     NSDictionary *qdic = [dataDic[@"ad"][@"question"] firstObject];
    
     NSString *str = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fAdvtype"]];
    if (!self.city.length>0) {
        self.city = @"广州市";
    }
    [[ExamService shareInstenced]getPayInfoWithUid:self.userModel.use.ftoken grade_id:qdic[@"fid"] fee:qdic[@"fadvertId"] coupon_id:self.atext.text type:str city:self.city];
    [self showHud];
    [ExamService shareInstenced].getPayInfoSuccess = ^(id obj){
        
        [self hideHud];
        
        
        
       
        
        if ([str isEqualToString:@"1"]) {
            
            NSString *mo = [NSString stringWithFormat:@"%@",obj[@"redMoney"]];
            
            NSString *path = [[NSBundle mainBundle]pathForResource:@"adv_red" ofType:@"mp3"];
            // 2 将路径字符串转换成url，从本地读取文件，需要使用fileURL
            NSURL *url = [NSURL fileURLWithPath:path];
            // 3 初始化音频播放器
            player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [player play];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"恭喜您，获得%.2f元红包",[mo floatValue]/100] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
             [[NSNotificationCenter defaultCenter]postNotificationName:@"GetRed" object:nil];
        }
        else{
            
            [self showHudWithString:@"获取成功"];
            NSString *path = [[NSBundle mainBundle]pathForResource:@"adv_yh" ofType:@"mp3"];
            // 2 将路径字符串转换成url，从本地读取文件，需要使用fileURL
            NSURL *url = [NSURL fileURLWithPath:path];
            // 3 初始化音频播放器
            player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [player play];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
       
        
        self.redView.hidden = YES;
        
    };
    
    [ExamService shareInstenced].getPayInfoFailure = ^(id obj){
        
        [self hideHud];
        
        [self showHudWithString:obj];
        
    };
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)redaction:(id)sender {
    
     self.redView.hidden = NO;
}

- (IBAction)enterAdv:(id)sender {
    
    MyAdvViewController *vc = [[MyAdvViewController alloc]init];
    
    vc.adid =dataDic[@"ad"][@"fadvertisersId"];
    
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (IBAction)hideAciton:(id)sender {
    
    self.redView.hidden = YES;
}

#pragma mark Service
- (void)loadReData{
    
    [[ExamService shareInstenced]getMnExamWithUid:self.advId type:nil];
    [ExamService shareInstenced].getMnExamSuccess  = ^(id obj){
      
        model = (ExamResultModel *)obj;
        NSMutableArray *temp = [NSMutableArray array];
        NSArray *ary = [model.fimgs componentsSeparatedByString:@","];
        for (NSString *str in ary) {
            
            if (str.length>0) {
                
                [temp addObject:[NSString stringWithFormat:@"%@%@",Release_Pic_URL,str]];
                
            }
            
        }
        self.adView.urlArray = temp;
        
        [self.reAdView addSubview:self.adView];
//        CGFloat fmoney=[model.fprice floatValue];
//        CGFloat foldMoney = [model.foldPrice floatValue];
//        self.reMoneyLAB.text = [NSString stringWithFormat:@"￥%.f",fmoney];
//        self.reOldLab.text = [NSString stringWithFormat:@"原价￥%.f",foldMoney];
        self.reNameLab.text = model.fname;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.fcreateTime integerValue]/1000];
       
        self.reCountLab.text = [NSString stringWithFormat:@"浏览次数：%@",model.fclickCount];
        self.rePhoneLab.text = model.txt;
        self.reDateLab.text =[NSString stringWithFormat:@"发布日期：%@",[date formatDateString:nil]];
        [self.flogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",User_Pic_URL,model.logo]]];
        
        [self.tableview setTableHeaderView:self.reHeadView];
        [self.tableview setTableFooterView:self.reFootView];
        [self.tableview reloadData];
        
    };
    [ExamService shareInstenced].getMnExamFailure = ^(id obj){
        
    };
}

- (void)loadData{
    
    [[ExamService shareInstenced]getAllowExamWithUid:self.advId];
    
    [self showHud];
    
    [ExamService shareInstenced].getAllowExamSuccess = ^(id obj){
        
        [self hideHud];
        
        dataDic = obj;
        
        NSString *str = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fAdvtype"]];
        self.title =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fname"]];
        if ([str isEqualToString:@"1"]) {
            leftList = [@[@"商家名称",@"商家官网",@"商家地址"]mutableCopy];
            
            [self.redBtn setTitle:@"抢红包" forState:UIControlStateNormal];
            
            self.getRedLab.text = @"抢红包";
            
            [self.getRedBtn setTitle:@"抢红包" forState:UIControlStateNormal];
            
            NSArray *ary = [dataDic[@"ad"][@"fadvertImgIds"] componentsSeparatedByString:@","];
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSString *str in ary) {
                
                if (str.length>0) {
                    
                    [temp addObject:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]];
                    
                }
                
            }
            
            self.adView.urlArray = temp;
            
            [self.picView addSubview:self.adView];
            
            
            self.adname.text = dataDic[@"ad"][@"fname"];
            self.adword.text = dataDic[@"ad"][@"fterm"];
            self.redputarea.text =dataDic[@"ad"][@"area"];
            NSDictionary *qdic = [dataDic[@"ad"][@"question"] firstObject];
            
            if (qdic) {
                
                self.qlab.text = qdic[@"fquestion"];
            }
            
            NSString  *address =[NSString stringWithFormat:@"%@",dataDic[@"adersAddress"]];
            
            if (!address.length>0) {
                
                address = @"";
            }
            NSString  *addressname =[NSString stringWithFormat:@"%@",dataDic[@"adersName"]];
            
            if (!addressname.length>0) {
                
                addressname = @"";
            }
            NSString  *adersWebsite =[NSString stringWithFormat:@"%@",dataDic[@"adersWebsite"]];
            
            if (!adersWebsite.length>0) {
                
                adersWebsite = @"";
            }
            self.reduser.text = [NSString stringWithFormat:@"%@",dataDic[@"adersContacts"]];
            
            rightList = [@[addressname,adersWebsite,address]mutableCopy];
            [self.tableview setTableHeaderView:self.headview];
            [self.tableview reloadData];
            
        }else{
            
            leftList = [@[@"店铺名称",@"店铺介绍",@"商家电话"]mutableCopy];

            
             [self.redBtn setTitle:@"抢优惠" forState:UIControlStateNormal];
            
             self.getRedLab.text = @"抢优惠";
            
            [self.getRedBtn setTitle:@"抢优惠" forState:UIControlStateNormal];
            
            NSArray *ary = [dataDic[@"ad"][@"fadvertImgIds"] componentsSeparatedByString:@","];
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSString *str in ary) {
                
                if (str.length>0) {
                    
                    [temp addObject:[NSString stringWithFormat:@"%@%@",Ad_Pic_URL,str]];
                    
                }
                
            }
            
            self.adView.urlArray = temp;
            
            [self.couPicView addSubview:self.adView];
            
            self.imgvlo.layer.masksToBounds = YES;
            self.imgvlo.layer.cornerRadius = 30;
            [self.imgvlo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Ads_Pic_URL,dataDic[@"adersLogo"]]]];
            self.couNamelab.text = dataDic[@"ad"][@"fname"];
            self.couClickLab.text = [NSString stringWithFormat:@"浏览 %@",dataDic[@"ad"][@"fclickConut"]];
            NSString *num =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fredNum"]];
            NSString *remain =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fredRemainNum"]];
            self.citylab.text =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"area"]];
            self.couAddLab.text =[NSString stringWithFormat:@"已抢购 %d",[num intValue]-[remain intValue]];
            NSString *strm = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fredMoney"]];
            CGFloat money = [strm floatValue]/100;
            self.couMoneyLab.text = [NSString stringWithFormat:@"￥ %.2f",money];
            self.couNumLab.text =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fredNum"]];
            NSDictionary *qdic = [dataDic[@"ad"][@"question"] firstObject];
            NSDate *bdate = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"ad"][@"fcreatetime"] integerValue]/1000];
            NSDate *edate = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"ad"][@"flimitedTime"] integerValue]/1000];
            
            self.couDateLab.text =[NSString stringWithFormat:@"%@ 至 %@",[bdate formatDateString:nil],[edate formatDateString:nil]];
            if (qdic) {
                
                self.qlab.text = qdic[@"fquestion"];
            }
            
            NSString  *address =[NSString stringWithFormat:@"%@",dataDic[@"adersPhone"]];
            
            if (!address.length>0) {
                
                address = @"";
            }
            NSString  *addressname =[NSString stringWithFormat:@"%@",dataDic[@"adersName"]];
            self.coupenuser.text = [NSString stringWithFormat:@"%@",dataDic[@"adersContacts"]];
            if (!addressname.length>0) {
                
                addressname = @"";
            }
            NSString  *adersWebsite =[NSString stringWithFormat:@"%@",dataDic[@"adersDetial"]];
            
            if (!adersWebsite.length>0) {
                
                adersWebsite = @"";
            }
            
            
            rightList = [@[addressname,adersWebsite,address]mutableCopy];
            [self.tableview setTableHeaderView:self.couHeadview];
            [self.tableview reloadData];
        }
        
        
        

    };
    
    [ExamService shareInstenced].getAllowExamFailure = ^(id obj){
      
        [self hideHud];
    };
    
    
}

#pragma mark AdvertisementViewDelegate
- (void)didTapImageViewAtIndex:(NSInteger )index{
    
    NSMutableArray *art = self.adView.urlArray;
    NSLog(@"%@",art);
    if (art.count>0) {
     
        photos = [art copy];
        
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.browser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.browser reloadData];
        
        [self presentViewController:nc animated:YES completion:nil];
        
    }

    
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

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type.length>0){
        return 5;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"detail"];
//    
//    [self.tableview registerNib:detNib forCellReuseIdentifier:@"DetCell"];
     NSString *str = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fAdvtype"]];
    if (indexPath.row ==0) {
        
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
       
        
        if ([str isEqualToString:@"2"]) {
            cell.toplab.text = @"优惠说明";
            cell.toplab.textColor =[UIColor redColor];
            cell.lab.text =  [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"finfo"]];
        }
        else if (self.type.length>0){
            
            cell.toplab.text = @"宝贝详情";
            cell.toplab.textColor =[UIColor darkGrayColor];
            cell.lab.text = model.fdetail;
        }
        
        else{
            cell.toplab.text = @"广告详情";
            cell.toplab.textColor =[UIColor darkGrayColor];
            cell.lab.text =  [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"finfo"]];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else{
        
        if (self.type.length>0){
        
            if (indexPath.row != 4) {
                DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
                
                if (indexPath.row == 1) {
                    
                    cell.toplab.text = @"联系人";
                    cell.toplab.textColor =[UIColor darkGrayColor];
                    cell.lab.text = model.txt;
                }
                else if (indexPath.row == 2){
                    
                    cell.toplab.text = @"联系地址";
                    cell.toplab.textColor =[UIColor darkGrayColor];
                    cell.lab.text = model.address;
                }
                else{
                    cell.toplab.text = @"联系电话";
                    cell.toplab.textColor =[UIColor darkGrayColor];
                    cell.lab.text = model.fphone;
                }
                return cell;
            }
            else{
               
                UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text = @"查看地图";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            
            
        }
        
        DetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetCell"];
        
        if (dataDic) {
            if (([str isEqualToString:@"2"] && indexPath.row == 3) || ([str isEqualToString:@"1"] && indexPath.row == 2)) {
                
                cell.cenlab.textColor= [UIColor blueColor];
            }
            else{
                cell.cenlab.textColor= [UIColor darkGrayColor];
            }
            cell.cenlab.text = rightList[indexPath.row-1];
        }
        cell.leflab.text = leftList[indexPath.row-1];
        
        
        return cell;
        
    }

}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        NSString *content;
        if (self.type.length>0) {
            
            content = model.fdetail;
        }
        else{
            content =[NSString stringWithFormat:@"%@",dataDic[@"ad"][@"finfo"]];
        }
        CGFloat labh = [RTLabel getHightWithString:content andSizeValue:14 andWidth:ScreenWidth-16];
        if (labh<22) {
            
            labh = 22;
        }
        
        return 50+labh;
    }
    else{
        
        if (self.type.length>0) {
            
            return 70;
        }
        
        
        return 44;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *str = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fAdvtype"]];
    
    if ([str isEqualToString:@"2"] && section == 0) {
        return 0;
    }
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (model && indexPath.row == 4) {
        SignInViewController *vc = [[SignInViewController alloc]init];
        vc.coord = model.fcoordinate;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (model.fphone.length>0 && indexPath.row == 3) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.fphone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        return;
    }
    
    
    
    if (dataDic) {
      NSString *str = [NSString stringWithFormat:@"%@",dataDic[@"ad"][@"fAdvtype"]];
        if ([str isEqualToString:@"2"] && indexPath.row == 3) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",rightList[indexPath.row-1]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
            
        }
        if ( [str isEqualToString:@"1"] && indexPath.row == 2) {
            
            NSString *url = rightList[indexPath.row-1];
            if (url.length>0) {
                
                WebViewController *vc = [[WebViewController alloc]init];
                vc.url = url;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
    
}


- (IBAction)phoneAction:(id)sender {
    if (model.fphone.length>0) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.fphone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}
@end

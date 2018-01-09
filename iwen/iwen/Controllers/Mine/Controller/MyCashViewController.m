//
//  MyCashViewController.m
//  iwen
//
//  Created by Interest on 16/3/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyCashViewController.h"
#import "GuideViewController.h"

#import "ShareView.h"
@interface MyCashViewController ()<ZZShareViewDelegate>
@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong)  PersonModel      *userInfo;
@end

@implementation MyCashViewController
{
    
    NSMutableArray *btnList;
    
    NSMutableArray *dataList;
    
    NSInteger seletIndex;
}

- (ShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _shareView.delegate = self;
        
    }
    return _shareView;
}

- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现申请";
    
    dataList = [NSMutableArray array];
    
    btnList = [@[self.btn1,self.btn2,self.btn3,self.btn4,self.btn5,self.btn6]mutableCopy];
    
    for (UIButton *btn in btnList) {
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        btn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
    }
    
    self.toplab.text = [NSString stringWithFormat:@"最多可提现%.2f元",[self.userInfo.use.ftotal floatValue]/100];
    
    [self loadData];
}


- (void)shareView:(ShareView *)shareView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex%ld",(long)buttonIndex);
//    NSArray *imageArray = @[@"朋友圈",@"微信好友",@"新浪微博",@"QQ好友",@"QQ空间"];
    
    if (buttonIndex == 1) {
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    }else if (buttonIndex == 2){
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    }else if (buttonIndex == 3){
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];

    }else if (buttonIndex == 4){
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
    }else{
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
    }
    
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    
    
    CGPoint point = CGPointMake(250, 810);
    NSString *money = [NSString stringWithFormat:@"¥%.2f元",[dataList[seletIndex][@"famount"] floatValue]/100];
    UIImage *shareImage = [self jx_WaterImageWithImage:[UIImage imageNamed:@"广告图2"] text:money textPoint:point attributedString:nil];
    
    
    
    
    shareObject.thumbImage = shareImage;
    
    [shareObject setShareImage:shareImage];
    messageObject.shareObject = shareObject;

    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [self showHudWithString:@"分享失败"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                
                
                [[MineService shareInstanced]delAddressWithIds:@{@"token":self.userInfo.use.ftoken,
                                                                 @"payCount":self.userInfo.use.falipay,
                                                                 @"menoy":dataList[seletIndex][@"famount"]
                                                                 
                                                                 
                                                                 }];
                [self showHud];
                [MineService shareInstanced].delAddressSuccess = ^(id obj){
                    
                    [self hideHud];
                    
                    [self showHudWithString:@"提现申请已提交"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                };
                [MineService shareInstanced].delAddressFailure = ^(id obj){
                    
                    [self hideHud];
                    [self showHudWithString:obj];
                };

                
                
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}


- (UIImage *)jx_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:58]}];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}



- (IBAction)doneAction:(id)sender {
    
    if (seletIndex+1 && dataList.count == 6) {
        
        if (!self.userInfo.use.falipay.length>0) {
            [self showHudWithString:@"请填写支付宝账号！"];
            GuideViewController *vc = [[GuideViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        
        [self.shareView showInView:self.navigationController.view];
        
        
    }
}

- (IBAction)cashAction:(UIButton *)sender {
    
    seletIndex = sender.tag;
    
    for (UIButton *btn in btnList) {
    
        btn.selected = NO;
    }
    
    sender.selected = YES;
}


- (void)loadData{
    
    
    [[MineService shareInstanced]getAgreement];
    
    [self showHud];
    [MineService shareInstanced].getAgreementSuccess = ^(id obj){
        
        [self hideHud];
        
        dataList = [obj mutableCopy];
        
        if (dataList.count == 6) {
            
            for (int a= 0; a<btnList.count; a++) {
                
                UIButton *btn = btnList[a];
                
                NSString *fee = [NSString stringWithFormat:@"%@",dataList[a][@"famount"]];
                
                NSString *price = [NSString stringWithFormat:@"%.2f元",[fee floatValue]/100];
                
                [btn setTitle:price forState:UIControlStateNormal];
                
                 [btn setTitle:price forState:UIControlStateSelected];
            }
            
            self.btn1.selected = YES;
        }
        
        
    };
    
    [MineService shareInstanced].getAgreementFailure = ^(id obj){
      
        [self hideHud];
        self.view.userInteractionEnabled = NO;
        [self showHudWithString:obj];
    };
}

@end

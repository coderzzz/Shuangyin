//
//  PersonCenterViewController.m
//  iwen
//
//  Created by Interest on 15/10/12.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonCell.h"
#import "RangPickerView.h"
#import "CenterCell.h"
@interface PersonCenterViewController ()<UIActionSheetDelegate>



@end

@implementation PersonCenterViewController
{
    PersonModel *user;
    NSString *headurl;
    NSString *name;
    NSString *age;
    NSString *sign;
    NSString *sex;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    headurl = @"";
    name = @"";
    age = @"";
    sign= @"";
    sex = @"";
    
    self.title = @"个人资料";
    UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [sendbtn setTitle:@"保存" forState:UIControlStateNormal];
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
    [sendbtn addTarget:self action:@selector(savedata) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    self.head.layer.masksToBounds = YES;
    self.head.layer.cornerRadius = 20;
    user = [[LoginService shareInstanced]getUserModel];
    
    if (user.use.fphone.length>0) {
        
//        self.topLab.text = user.use.fid;
//        
//        self.phonelab.text = user.use.fphone;
//        
//       self.sexlab.text = [user.use.fsex integerValue] == 0?@"男":@"女";
        
        
        [self.head sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",User_Pic_URL,user.use.fheadImg]] forState:UIControlStateNormal];
        if (user.use.fheadImg.length>0) {
            
            headurl = user.use.fheadImg;
        }
        if (user.use.fnickName.length>0) {
            
            name = user.use.fnickName;
        }
        if (user.use.fage.length>0) {
            
            age = user.use.fage;
        }
        if (user.use.fsignature.length>0) {
            
            sign = user.use.fsignature;
        }
        if (user.use.fsex.length>0) {
            
            sex = user.use.fsex;
        }

        
        self.nametf.text = user.use.fnickName;
        self.agetf.text = user.use.fage;
        self.sigtf.text = user.use.fsignature;
        self.clab.text = [NSString stringWithFormat:@"ID%@",user.use.fid];
        self.phoneLab.text = user.use.fphone;
        
        if ([user.use.fsex isEqualToString:@"man"]) {
            
            [self.menBtn setImage:[UIImage imageNamed:@"我的-优惠券-勾选"] forState:UIControlStateNormal];
        }
        else if ([user.use.fsex isEqualToString:@"woman"]){
            
            [self.wbtn setImage:[UIImage imageNamed:@"我的-优惠券-勾选"] forState:UIControlStateNormal];
        }
        else{
            
            [self.unBtn setImage:[UIImage imageNamed:@"我的-优惠券-勾选"] forState:UIControlStateNormal];
        }
    }
    
    
}

- (void)savedata{
   
    if (self.nametf.text.length>0) {
        
        name = self.nametf.text;
    }
    
    if (self.agetf.text.length>0) {
        
        age = self.agetf.text;
    }
    

    if (self.sigtf.text.length>0) {
        
        sign = self.sigtf.text;
    }

    NSDictionary *data1 = @{@"fsex":sex,
                          @"fheadImg":headurl,
                          @"fnickName":name,
                          @"fage":age,
                          @"fsignature":sign
                          };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data1 options:kNilOptions error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSMutableDictionary *dic =[@{@"token":user.use.ftoken,@"user":jsonStr}mutableCopy];

    [[MineService shareInstanced]getAllAddressWithUid:dic];
    
    [self showHud];
    [MineService shareInstanced].getAllAddressSuccess = ^(id obj){
        
        [self hideHud];
        
        [self showHudWithString:@"修改成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [MineService shareInstanced].getAllAddressFailure = ^(id obj){
        
        [self hideHud];
        
        [self showHudWithString:obj];
    };
}

- (IBAction)pick:(UIButton *)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}

#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
    if(buttonIndex == 0)
    {
        [self presentViewController:[PhotoManager shareManager].camera animated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        [self presentViewController:[PhotoManager shareManager].pickingImageView animated:YES completion:nil];
    }
    
    [PhotoManager shareManager].configureBlock = ^(id image){
        if(image == nil)
        {
            return ;
        }
//        image = [image imageWithSize:CGSizeMake(ScreenWidth-20, 200)];
        
        NSData *data  = UIImageJPEGRepresentation(image, 0.2);
        
        NSString  *base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        [self upLoadAvtarWithbase64String:base64Sting iamge:image];
        
    };
}

- (void)upLoadAvtarWithbase64String:(NSString *)string iamge:(UIImage *)image{
    
    
    [[LoginService shareInstanced]saveAvatarWithUserId:@"user" avatarString:string];
    
    [self showHud];
    
    [LoginService shareInstanced].upDateAvatarSuccess = ^(id obj){
        
        [self hideHud];
        
        //        [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"avatar":obj}];
        
        
        [self.head  setBackgroundImage:image forState:UIControlStateNormal];
        headurl =obj[@"fmediaUrl"];
        
    };
    
    [LoginService shareInstanced].upDateAvatarFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
    
}




- (IBAction)selectSex:(UIButton *)sender {
    
    [self.menBtn setImage:[UIImage imageNamed:@"我的-优惠券-未勾选"] forState:UIControlStateNormal];
    [self.wbtn setImage:[UIImage imageNamed:@"我的-优惠券-未勾选"] forState:UIControlStateNormal];
    [self.unBtn setImage:[UIImage imageNamed:@"我的-优惠券-未勾选"] forState:UIControlStateNormal];
    
    if (sender.tag == 0) {
        sex = @"man";
    }
    else if (sender.tag ==1){
        sex = @"woman";
    }else{
        sex = @"nosex";
    }

    [sender setImage:[UIImage imageNamed:@"我的-优惠券-勾选"] forState:UIControlStateNormal];
    
}
@end

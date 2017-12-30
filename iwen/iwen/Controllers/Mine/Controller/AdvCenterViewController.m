//
//  AdvCenterViewController.m
//  iwen
//
//  Created by Interest on 16/3/9.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "AdvCenterViewController.h"
#import "PCell.h"
#import "RangPickerView.h"
#import "CenterCell.h"
#import "TypeViewController.h"
#import "SignInViewController.h"
@interface AdvCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,TypeViewControllerDelegate,SignInViewControllerDelegate>

@property (strong, nonatomic) NSArray *lefeArray;

@property (nonatomic, strong) PersonModel *userInfo;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong)  UIBarButtonItem *doneItem;


@end

@implementation AdvCenterViewController
{
    NSIndexPath  *didSelectIndex;
    
    NSString  *fstatueName;
    
}
#pragma mark getter


- (UIBarButtonItem *)doneItem{
    
    if (_doneItem  == nil) {
        
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"确定" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        _doneItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        
        
    }
    
    return _doneItem;
}

- (NSArray *)lefeArray
{
    if (_lefeArray == nil) {
        _lefeArray = @[@[@"商家LOGO",@"商家名称"],@[@"商家电话",@"商家联系人",@"商家官网"],@[@"行业选择",@"位置选择"]];
    }
    return _lefeArray;
}
- (PersonModel *)userInfo{
    
    if (_userInfo == nil) {
        _userInfo = [[LoginService shareInstanced]getUserModel];
    }
    return _userInfo;
    
}

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        
        
        NSString *avatar = self.userInfo.adv.flogo;
        
        if (!avatar.length>0) {
            
            avatar = @"";
        }
        
        NSString *nickName = self.userInfo.adv.fcompanyName;
        
        if (!nickName.length>0) {
            
            nickName = @"";
            
        }
        
        
        NSString *realname = self.userInfo.adv.ftelPhone;
        
        if (!realname.length>0) {
            
            realname = @"";
        }
        
        NSString *myphone = self.userInfo.adv.fcontacts;
        
        if (!myphone.length>0) {
            
            myphone = @"";
            
        }
        
        NSString *phone = self.userInfo.adv.fwebsite;
        
        if (!phone.length>0) {
            
            phone = @"";
            
        }
        
        NSString *id_number = self.userInfo.adv.ftypeId;
        
        if (!id_number.length>0) {
            
            id_number = @"";
        }
        
        NSString *readschool = self.userInfo.adv.fcoordinate;
        
        if (!readschool.length>0) {
            
            readschool = @"";
            
        }
        
        
        _dataSource = [@[@[avatar,nickName],@[realname,myphone,phone],@[id_number,readschool]] mutableCopy];
        
    }
    return _dataSource;
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUi];
    [self loadData];
}

- (void)setupUi
{
    
    self.title = @"商家信息";
    
    self.tableview.backgroundColor = BackgroundColor;
    UINib *nib  = [UINib nibWithNibName:@"PCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"qqCell"];
    
    UINib *nib2  = [UINib nibWithNibName:@"CenterCell" bundle:nil];
    [self.tableview registerNib:nib2 forCellReuseIdentifier:@"cenCell"];
    self.tableview.separatorColor = SeparatorColor;
    
    [self.tableview setTableFooterView:self.headview];
    
    self.navigationItem.rightBarButtonItem = self.doneItem;
}


#pragma mark Action
- (void)done{
    
    if (self.userInfo.adv.fid.length>0) {

        NSDictionary *dic = @{@"flogo":self.dataSource[0][0],
                              @"fcompanyName":self.dataSource[0][1],
                              @"ftelPhone":self.dataSource[1][0],
                              @"fcontacts":self.dataSource[1][1],
                              @"fwebsite":self.dataSource[1][2],
                              @"ftypeId":self.dataSource[2][0],
                              @"fcoordinate":self.dataSource[2][1],
                              @"faddress":self.tex1.text?self.tex1.text:@"",
                              @"detial":self.tex2.text?self.tex2.text:@""
                              };
        
        
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
        NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        

        
        [[LoginService shareInstanced]upDateUserWithDictionary:@{@"token":self.userInfo.use.ftoken,
                                                                 
                                                                 @"data":jsonStr
                                                                 
                                                                 }];
        
        [self showHud];
        [LoginService shareInstanced].upDateUserDetailSuccess  = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        
        [LoginService shareInstanced].upDateUserDetailFailure = ^(id obj){
            
            [self hideHud];
            
            [self showHudWithString:obj];
            
        };
        
    }
    
}

#pragma mark Service
- (void)loadData{
    
    [self showHud];
    [[LoginService shareInstanced]getUserDetailWithID:self.userInfo.use.ftoken];
    [LoginService shareInstanced].getUserDetailSuccess = ^(id obj){
        
        [self hideHud];
        if (obj) {
            
            self.dataSource = nil;
            self.userInfo = [obj copy];
            
            self.tex1.text = self.userInfo.adv.faddress;
            self.tex2.text = self.userInfo.adv.detial;
            
            [self.tableview reloadData];
        }
    };
    [LoginService shareInstanced].getUserDetailFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
}

#pragma  mark SignInViewControllerDelegate
- (void)didSelectWithCoordinate:(NSString *)str{
    
    NSMutableArray *temp = [self.dataSource[didSelectIndex.section] mutableCopy];
    
    [temp replaceObjectAtIndex:1 withObject:str];
    
    [self.dataSource replaceObjectAtIndex:didSelectIndex.section withObject:temp];
    
    [self.tableview reloadData];
    
}

#pragma mark TypeViewControllerDelegate
- (void)didSelectDic:(NSDictionary *)dic{
    
    
    fstatueName = dic[@"fname"];
    
    NSString  *fstatue = [NSString stringWithFormat:@"%@",dic[@"fid"]];
    
    NSMutableArray *temp = [self.dataSource[didSelectIndex.section] mutableCopy];
    
    [temp replaceObjectAtIndex:0 withObject:fstatue];
    
    [self.dataSource replaceObjectAtIndex:didSelectIndex.section withObject:temp];
    
    [self.tableview reloadData];
    
    
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.lefeArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.lefeArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        PCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qqCell"];
        
        NSString *img = [NSString stringWithFormat:@"%@%@",Ads_Pic_URL,[[self.dataSource firstObject]firstObject]];
        
        if (img.length>0) {
            
            [cell.headimage sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:DefaultAvatar];
        }
        
        return cell;
    }
    
    CenterCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cenCell"];
    
    
    cell.leftLab.text = self.lefeArray[indexPath.section][indexPath.row];
    
    
    cell.contenLab.text = self.dataSource[indexPath.section][indexPath.row];
    
    if (indexPath.section == 2 && indexPath.row == 0 && fstatueName.length>0) {
        cell.contenLab.text =fstatueName;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [actionSheet showInView:self.view];
        actionSheet = nil;
        
        return;
    }
    
    didSelectIndex = indexPath;
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            
            TypeViewController *vc = [[TypeViewController alloc]init];
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else{
            
            SignInViewController *vc = [[SignInViewController alloc]init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    else{
        
        
        
        
        NSString *str = self.lefeArray[indexPath.section][indexPath.row];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        [alert show];
        
    }
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
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
        
        [self upLoadAvtarWithbase64String:base64Sting];
        
    };
}

- (void)upLoadAvtarWithbase64String:(NSString *)string{
    
    
    [[LoginService shareInstanced]saveAvatarWithUserId:@"aders" avatarString:string];
    
    [self showHud];
    
    [LoginService shareInstanced].upDateAvatarSuccess = ^(id obj){
        
        [self hideHud];
        
        //        [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"avatar":obj}];
        
        
        
        NSMutableArray *temp = [self.dataSource[0]mutableCopy];
        
        [temp replaceObjectAtIndex:0 withObject:obj[@"fmediaUrl"]];
        
        
        //        Adv *myUser = [[Adv MR_findAll]lastObject];
        //
        //
        //        myUser.flogo =obj[@"fmediaUrl"];
        //
        //        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.dataSource replaceObjectAtIndex:0 withObject:temp];
        
        [self.tableview reloadData];
        
        
    };
    
    [LoginService shareInstanced].upDateAvatarFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}



#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        UITextField *texfield = [alertView textFieldAtIndex:0];
        
        
        if (texfield.text.length>0) {
            
            
            [self updateUserInfoWithString:texfield.text];
            
        }
        else{
            
            [self showHudWithString:@"请输入内容"];
        }
        
    }
    
}

- (void)updateUserInfoWithString:(NSString *)string{
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.userInfo.use.ftoken forKey:@"uid"];
    //
    //    NSArray *ary = @[@"nickname",@"realname",@"phone",@"province",@"id_number",@"readschool"];
    
    //    [dic setValue:string forKey:ary[didSelectIndex]];
    //
    //    [[LoginService shareInstanced]upDateUserWithDictionary:dic];
    //
    //    [self showHud];
    //    [LoginService shareInstanced].upDateUserDetailSuccess = ^(id obj){
    
    //        NSDictionary *dic = @{ary[didSelectIndex]:string};
    
    //        [[LoginService shareInstanced]saveUserModelWithDictionary:dic];
    
    NSMutableArray *temp = [self.dataSource[didSelectIndex.section] mutableCopy];
    
    [temp replaceObjectAtIndex:didSelectIndex.row withObject:string];
    
    [self.dataSource replaceObjectAtIndex:didSelectIndex.section withObject:temp];
    
    [self.tableview reloadData];
    
    //        [self hideHud];
    
    //    };
    //
    //    [LoginService shareInstanced].upDateUserDetailFailure = ^(id obj){
    //        
    //        [self hideHud];
    //        [self showHudWithString:obj];
    //    };
}



@end

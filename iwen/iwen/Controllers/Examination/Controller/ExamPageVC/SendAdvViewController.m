//
//  SendAdvViewController.m
//  iwen
//
//  Created by sam on 16/3/4.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SendAdvViewController.h"
#import "TypeViewController.h"
#import "QCell.h"
#import "CityViewController.h"
#import "WebListViewController.h"
#import "SignInViewController.h"
#import "ASBirthSelectSheet.h"
@interface SendAdvViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,TypeViewControllerDelegate,CityViewControllerDelegate,SignInViewControllerDelegate,WebDele>

@property (nonatomic, strong) PersonModel *userModel;

@property (strong, nonatomic) IBOutlet UILabel *tilab;
@property (nonatomic, strong) NSMutableArray *imgList;

@property (nonatomic, strong) NSMutableArray *imgData;

@property (nonatomic, strong) NSMutableArray *leftArray;


@property (nonatomic, strong) NSMutableArray *rigArray;

@property (nonatomic, strong) NSMutableArray *rightList;

@end

@implementation SendAdvViewController
{
    NSString *fstatue;
    
    NSString *fstatueName;
    
    NSString *mycityId;
    
    NSString *myCoorId;
    NSString *mytypeId;
    
    NSString *imgStr;
    
    NSMutableArray *qArray;
    
    NSIndexPath *indexpath;
}









- (NSMutableArray *)imgList{
    
    if (!_imgList) {
        
        _imgList = [@[self.img1,self.img2,self.img3,self.img4,self.img5,self.img6,self.img7,self.img8,self.img9]mutableCopy];
    }
    
    return _imgList;
}

- (NSMutableArray *)imgData{
    
    if (!_imgData) {
        
        _imgData = [NSMutableArray array];
    }
    return _imgData;
}
- (PersonModel *)userModel{
    
    if (!_userModel) {
        
        _userModel = [[LoginService shareInstanced]getUserModel];
    }
    
    return _userModel;
    
}

#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self.type isEqualToString:@"1"]) {
        
        [self.textview setPlaceholder:@"请填写优惠券说明..."];
        _rigArray = [@[[@[@"请输入面值",@"请输入名称",@"请选择日期",@"请输入数量"] mutableCopy],[@[@"请选择行业",@"请选择投放地区"]mutableCopy],[@[] mutableCopy]]mutableCopy];
        _rightList =  [@[[@[@"请输入面值",@"请输入名称",@"请选择日期",@"请输入数量"] mutableCopy],[@[@"请选择行业",@"请选择投放地区"]mutableCopy],[@[] mutableCopy]]mutableCopy];
        _leftArray = [@[[@[@"优惠券面值",@"优惠券名称",@"截止日期",@"优惠券数量"]mutableCopy],[@[@"行业选择",@"投放地区"]mutableCopy],[@[]mutableCopy]]mutableCopy];
        
    }else if ([self.type isEqualToString:@"re"]){
        
        self.probtn.hidden = YES;
        [self.textview setPlaceholder:@"请填写宝贝说明..."];
        _rigArray = [@[[@[@"宝贝名称"] mutableCopy],[@[@"请选择类型",@"省－市－区",@"请选择地图坐标"]mutableCopy],[@[@"联系电话",@"联系人",@"联系地址"] mutableCopy]]mutableCopy];
        _rightList =  [@[[@[@"宝贝名称"] mutableCopy],[@[@"请选择类型",@"省－市－区",@"请选择地图坐标"]mutableCopy],[@[@"联系电话",@"联系人",@"联系地址"] mutableCopy]]mutableCopy];
        _leftArray = [@[[@[@"宝贝名称"] mutableCopy],[@[@"类型选择",@"地区选择",@"坐标选择"]mutableCopy],[@[@"联系电话",@"联系人",@"联系地址"] mutableCopy]]mutableCopy];
        
    }
    
    else{
        [self.textview setPlaceholder:@"请填写广告说明..."];

        _rigArray = [@[[@[@"请输入广告名",@"请输入广告词"] mutableCopy],[@[@"请选择行业",@"请选择投放地区"]mutableCopy],[@[] mutableCopy]]mutableCopy];
        _rightList = [@[[@[@"请输入广告名",@"请输入广告词"] mutableCopy],[@[@"请选择行业",@"请选择投放地区"]mutableCopy],[@[] mutableCopy]]mutableCopy];
        _leftArray = [@[[@[@"广告名",@"广告词"]mutableCopy],[@[@"行业选择",@"投放地区"]mutableCopy],[@[]mutableCopy]]mutableCopy];

    }
    
  
    
    UINib *detailNib = [UINib nibWithNibName:@"ApplyTableViewCell" bundle:nil];
    
    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"AppCell"];
    
    
    UINib *deNib = [UINib nibWithNibName:@"QCell" bundle:nil];
    
    [self.tableview registerNib:deNib forCellReuseIdentifier:@"MyQcell"];
    
    
    [self.tableview setTableHeaderView:self.headView];
    
    [self.tableview setTableFooterView:self.footView];
    
    self.qView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    self.qView.hidden = YES;
    
    [self.navigationController.view addSubview:self.qView];
    
    self.redView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    self.redView.hidden = YES;
    
    PersonModel *user = [[LoginService shareInstanced]getUserModel];
    
    self.myMoneyLab.text = [NSString stringWithFormat:@"余额:%@",user.adv.ftotal];
    
    [self.navigationController.view addSubview:self.redView];
    
    
}

#pragma mark Action


- (IBAction)addQ:(id)sender {
    
    self.qView.hidden = NO;
    
}

- (IBAction)cancleQ:(id)sender {
    
    self.qView.hidden = YES;
    
    self.qtext.text = nil;
    [self.qtext resignFirstResponder];
    
    self.atext.text = nil;
    [self.atext resignFirstResponder];
}

- (IBAction)up:(id)sender {
    
    if (!self.textview.text.length>0) {

        [self showHudWithString:@"请输入介绍"];
        return;
    }

    if (!self.imgData.count>0) {

        [self showHudWithString:@"请上传图片..."];

        return;
    }
    
    if ([self.type isEqualToString:@"re"]) {
        
   
        if (!mycityId) {
            
            [self showHudWithString:@"请选择地区"];
            return;
        }
        
        
        if (!mytypeId.length>0) {
            
            [self showHudWithString:@"请选择类型"];
            return;
        }

//        if (!myCoorId.length>0) {
//            
//            [self showHudWithString:@"请选择地点"];
//            return;
//        }
        
    }else{
        
        if (![self.leftArray[2] count]>0) {
            
            [self showHudWithString:@"请添加问题..."];
            
            return;
        }
        if (!mycityId) {
            
            [self showHudWithString:@"请选择投放地区"];
            return;
        }
        
        if (!fstatueName.length>0) {
            
            [self showHudWithString:@"请选择行业"];
            return;
        }

        
    }
    
    
    BOOL isWrite = YES;

    NSMutableArray *ary = self.rigArray[0];

    for (int x = 0; x<ary.count; x++) {

        NSString *str = ary[x];
        NSString *destr = self.rightList[0][x];

        if ([str isEqualToString:destr] && x !=1) {

            [self showHudWithString:destr];

            isWrite = NO;

            break;
        }

    }
  
        
        
        
    if (isWrite) {

        NSMutableString *imgs = [NSMutableString string];
        
        for (NSDictionary *dic in self.imgData) {
            
      
            
         [imgs appendString:[NSString stringWithFormat:@"%@,",dic[@"fmediaUrl"]]];
            
        }
        
        
        NSLog(@"%@",imgs);
        
        if ([self.type isEqualToString:@"re"]) {
            
//            int money = [self.rigArray[0][2] floatValue] * 100;
//            int money2 = [self.rigArray[0][1] floatValue] * 100;
            
            NSDictionary *dic = @{
                                   @"fname":self.rigArray[0][0],
                                   @"ftype":mytypeId,
                                   @"fcoordinate":myCoorId,
                                   @"fcity":mycityId,
                                   @"fphone":self.rigArray[2][0],
                                   @"fcontacts":self.rigArray[2][1],
                                   @"fimgs":imgs,
                                   @"token":self.userModel.use.ftoken,
                                   @"address":self.rigArray[2][2],
                                   @"fdetail":self.textview.text
                                   };
            
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//            NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
            
          
            
            [[ExamService shareInstenced]getExamLikeWithUid:self.userModel.use.ftoken cid:dic];
            [ExamService shareInstenced].getExamLikeSuccess = ^(id obj){
            
                [self hideHud];
                [self showHudWithString:@"发送成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
            };
            [ExamService shareInstenced].getExamLikeFailure =^ (id obj){
                
                [self hideHud];
                [self showHudWithString:obj];
                
                
            };
            
            
            return;
            
        }
        
        
        
        NSMutableArray *temp = [NSMutableArray array];
        
        for (NSDictionary *dic in self.rigArray[2]) {
            
            NSDictionary *my = @{@"fquestion":[[dic allKeys]firstObject],
                                 @"fanswer":[[dic allValues]firstObject]
                                 
                                 };
            [temp addObject:my];
            
        }
        
        imgStr = imgs;
        
        qArray = temp;
        
        if ([self.type isEqualToString:@"2"]) {
            
            self.redView.hidden= NO;
            
            
        }
        else{
            
            int money = [self.rigArray[0][0] floatValue] * 100;
            
            NSDictionary *dic = @{ @"fareaId":mycityId,
                                   @"fredMoney":@(money),
                                   @"flimitedTime":self.rigArray[0][2],
                                   @"fredNum":self.rigArray[0][3],
                                   @"fname":self.rigArray[0][1],
                                   @"ftypeId":fstatue,
                                   @"fterm":self.rigArray[0][1],
                                   @"question":qArray,
                                   @"fadvertImgIds":imgStr,
                                   @"finfo":self.textview.text
                                   };
            
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
            NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            
            [self showHud];
            [ExamService shareInstenced].getPracticeSuccess = ^(id obj){
                
                [self hideHud];
                [self showHudWithString:@"发送成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
            };
            [ExamService shareInstenced].getPracticeFailure = ^(id obj){
                
//                self.tilab.frame = CGRectMake(100, 100, ScreenWidth, 500);
//                self.tilab.text = [NSString stringWithFormat:@"jsonstr == %@\n failueobj = %@",jsonStr,obj];
//                [self.view addSubview:self.tilab];
                
                [self hideHud];
                [self showHudWithString:obj];
                
            };
            
            [[ExamService shareInstenced]getPracticeWithTypeId:jsonStr uid:self.userModel.use.ftoken];
            
            
        }
 
    }
}

- (IBAction)sendRedAction:(UIButton *)sender {
    
    if (!self.redMony.text.length>0) {
        
        return;
    }
    
    if (!self.redCount.text.length>0) {
        
        return;
    }
    
    int red = [self.redMony.text floatValue] * 100;
    
    
    
    
    NSDictionary *dic = @{ @"fareaId":mycityId,
                           @"fname":self.rigArray[0][0],
                           @"ftypeId":fstatue,
                           @"fterm":self.rigArray[0][1],
                           @"question":qArray,
                           @"fadvertImgIds":imgStr,
                           @"finfo":self.textview.text,
                           @"fredNum":self.redCount.text,
                           @"fredMoney":@(red)
                           };
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    [self showHud];
    [ExamService shareInstenced].getExamGradeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.redView.hidden = YES;
        
        [self showHudWithString:@"发送成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [ExamService shareInstenced].getExamGradeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
        
    };
    
    [[ExamService shareInstenced]getGetExamGradeWithType:jsonStr uid:self.userModel.use.ftoken];
}

- (IBAction)qaction:(id)sender {
    
    if (!self.qtext.text.length>0) {
        
        [self showHudWithString:@"请输入问题"];
        return;
        
    }
    
    if (!self.atext.text.length>0) {
        
        [self showHudWithString:@"请输入答案"];
        return;
    }
    
    if (self.atext.text.length>0 && self.qtext.text.length>0) {
        
        
        NSMutableArray *ary = self.rigArray[2];
        
        NSDictionary *dic = @{self.qtext.text:self.atext.text};
        
        NSMutableArray *left = self.leftArray[2];
        
        if (dic) {
        
            [ary addObject:dic];
            
            [left addObject:self.qtext.text];
            
            [self.leftArray replaceObjectAtIndex:2 withObject:left];
            
            [self.rigArray replaceObjectAtIndex:2 withObject:ary];
            
            [self.tableview reloadData];
            
            [self cancleQ:nil];
            
        }
        
        
        
    }
    
    
    
}

- (void)deleq:(UIButton *)btn
{
    NSMutableArray *ary = self.rigArray[2];
    
    NSMutableArray *left = self.leftArray[2];
  
    [ary removeObjectAtIndex:btn.tag];
    
    [left removeObjectAtIndex:btn.tag];
    
    [self.leftArray replaceObjectAtIndex:2 withObject:left];
    
    [self.rigArray replaceObjectAtIndex:2 withObject:ary];
    
    [self.tableview reloadData];

        
 
    
    
}

- (IBAction)addImage:(UIButton *)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}
- (IBAction)hieRedAction:(UITapGestureRecognizer *)sender{
    
    self.redView.hidden = YES;
}
#pragma mark Service




#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        UITextField *texfield = [alertView textFieldAtIndex:0];
        
        
        if (texfield.text.length>0) {
            
       
            NSMutableArray *temp = self.rigArray[indexpath.section];
            
            [temp replaceObjectAtIndex:indexpath.row withObject:texfield.text];
            
            [self.rigArray replaceObjectAtIndex:indexpath.section withObject:temp];
 
            [self.tableview reloadData];
            
        }
        else{
            
            [self showHudWithString:@"请输入内容"];
        }
        
    }
    
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
        
        UIImageView *imgv = self.imgList[self.imgData.count];
        
        imgv.image = image;

//        image = [image imageWithSize:CGSizeMake(ScreenWidth-20, 200)];
        
        NSData *data  = UIImageJPEGRepresentation(image, 0.2);
        
        NSString  *base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        [self upLoadAvtarWithbase64String:base64Sting];
        
    };
}

- (void)upLoadAvtarWithbase64String:(NSString *)string{
    
    
    NSString *str;
    if ([self.type isEqualToString:@"re"]) {
        str = @"release";
    }else{
        str = @"ad";
    }
    
    [[LoginService shareInstanced]saveAvatarWithUserId:str avatarString:string];
    
    [self showHud];
    
    [LoginService shareInstanced].upDateAvatarSuccess = ^(id obj){
        
        [self hideHud];
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        if (dic) {
            
            [self.imgData addObject:dic];
        }

    };
    
    [LoginService shareInstanced].upDateAvatarFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}
#pragma mark CityViewControllerDelegate
- (void)didSelectCityWithdic:(NSDictionary *)dic{
    
    mycityId = dic[@"areaNo"];
    
    NSMutableArray *temp = self.rigArray[1];
    
    [temp replaceObjectAtIndex:1 withObject:dic[@"areaName"]];
    
    [self.rigArray replaceObjectAtIndex:1 withObject:temp];
    
    [self.tableview reloadData];
}

#pragma mark TypeViewControllerDelegate

- (void)didSelectDic:(NSDictionary *)dic{
    
    fstatueName = dic[@"fname"];
    
    fstatue    = dic[@"fid"];
    
    NSMutableArray *temp = self.rigArray[1];
    
    [temp replaceObjectAtIndex:0 withObject:fstatueName];
    
    [self.rigArray replaceObjectAtIndex:1 withObject:temp];
    
    [self.tableview reloadData];
    
}


#pragma mark SignInViewControllerDelegate
- (void)didSelectWithCoordinate:(NSString *)str{
    
    myCoorId = str;
    
    NSMutableArray *temp = self.rigArray[1];
    
    [temp replaceObjectAtIndex:2 withObject:str];
    
    [self.rigArray replaceObjectAtIndex:1 withObject:temp];
    
    [self.tableview reloadData];
}

#pragma mark WebDele
-(void)did:(CircleListModel *)mod{
    
    mytypeId = mod.fid;
    
    NSMutableArray *temp = self.rigArray[1];
    
    [temp replaceObjectAtIndex:0 withObject:mod.fname];
    
    [self.rigArray replaceObjectAtIndex:1 withObject:temp];
    
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
    //    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"detail"];
    //
    //    [self.tableview registerNib:detNib forCellReuseIdentifier:@"DetCell"];
    
    //    if (indexPath.row ==0) {
    //
    //        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
    //
    //        return cell;
    //    }
    //
    //    else{
    //
    //        DetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetCell"];
    //
    //        return cell;
    //
    //    }
    
    if (indexPath.section == 2) {
        
        if ([self.type isEqualToString:@"re"]) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
            if (!cell) {
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            
            
            cell.textLabel.text = self.leftArray[indexPath.section][indexPath.row];
            
            cell.detailTextLabel.text = self.rigArray[indexPath.section][indexPath.row];
            
            
            
            
            return cell;

        }
        else{
            
            QCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyQcell"];
            
            cell.leflab.text = self.leftArray[indexPath.section][indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delebtn.tag = indexPath.row;
            
            [cell.delebtn addTarget:self action:@selector(deleq:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        

    }
    
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        
        cell.textLabel.text = self.leftArray[indexPath.section][indexPath.row];
        
        cell.detailTextLabel.text = self.rigArray[indexPath.section][indexPath.row];
        
        
        
        
        return cell;
    }
    
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    indexpath = indexPath;
    
    
    if ([self.type isEqualToString:@"re"]) {
        
        
        if (indexPath.section ==1) {
            
            if (indexPath.row == 0) {
                
                WebListViewController *vc = [[WebListViewController alloc]init];
                
                vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row ==2){
                
                SignInViewController *vc = [[SignInViewController alloc]init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            else{
                
                CityViewController *vc = [[CityViewController alloc]init];
                vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }

        }
        else{
            
            NSString *str = self.rigArray[indexPath.section][indexPath.row];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
            
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            
            [alert show];
            
        }
    }
    
    else{
        
        if (indexPath.section == 0 && indexPath.row ==2 && [self.type isEqualToString:@"1"]) {
            
            ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            //        datesheet.selectDate = @"2016-07-05";
            datesheet.GetSelectDate = ^(NSString *dateStr) {
                
                
                NSMutableArray *temp = self.rigArray[indexpath.section];
                
                [temp replaceObjectAtIndex:indexpath.row withObject:dateStr];
                
                [self.rigArray replaceObjectAtIndex:indexpath.section withObject:temp];
                
                [self.tableview reloadData];
                
                NSLog(@"%@",dateStr);
            };
            [self.navigationController.view addSubview:datesheet];
        }
        else if(indexPath.section == 1){
            
            
            
            if (indexPath.row == 0) {
                
                TypeViewController *vc = [[TypeViewController alloc]init];
                
                vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                
                CityViewController *vc = [[CityViewController alloc]init];
                vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        else{
            
            NSString *str = self.rigArray[indexPath.section][indexPath.row];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
            
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            
            [alert show];
        }
    }
    
    
//    if (indexPath.section == 0) {
//        
//        if ([self.type isEqualToString:@"1"] && indexPath.row == 2) {
//            
//                ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//                //        datesheet.selectDate = @"2016-07-05";
//                datesheet.GetSelectDate = ^(NSString *dateStr) {
//            
//            
//                    NSMutableArray *temp = self.rigArray[indexpath.section];
//                    
//                    [temp replaceObjectAtIndex:indexpath.row withObject:dateStr];
//                    
//                    [self.rigArray replaceObjectAtIndex:indexpath.section withObject:temp];
//                    
//                    [self.tableview reloadData];
//                    
//                    NSLog(@"%@",dateStr);
//                };
//                [self.navigationController.view addSubview:datesheet];
//
//            
//        }
//        else{
//        
//            NSString *str = self.rigArray[indexPath.section][indexPath.row];
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"修改%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
//            
//            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//            
//            [alert show];
//        }
//        
//
//    }
//    
//    if (indexPath.section == 1) {
//        
//        
//        if ([self.type isEqualToString:@"re"]) {
//            
//            if (indexPath.row == 0) {
//                
//                WebListViewController *vc = [[WebListViewController alloc]init];
//                
//                vc.delegate = self;
//                
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            else if (indexPath.row ==2){
//                
//                SignInViewController *vc = [[SignInViewController alloc]init];
//                vc.delegate = self;
//                [self.navigationController pushViewController:vc animated:YES];
//                
//            }
//            else{
//                
//                CityViewController *vc = [[CityViewController alloc]init];
//                vc.delegate = self;
//                
//                [self.navigationController pushViewController:vc animated:YES];
//                
//            }
//            return;
//            
//        }
//        else{
//            
////            if (indexPath.row == 0) {
////                
////                TypeViewController *vc = [[TypeViewController alloc]init];
////                
////                vc.delegate = self;
////                
////                [self.navigationController pushViewController:vc animated:YES];
////            }
////            else{
////                
////                CityViewController *vc = [[CityViewController alloc]init];
////                vc.delegate = self;
////                
////                [self.navigationController pushViewController:vc animated:YES];
////                
////            }
//            return;
//            
//        }
//        
//        
//    }
//    
    
//    if ([self.type isEqualToString:@"re"]) {
//        
//        NSString *str = self.rigArray[indexPath.section][indexPath.row];
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"修改%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
//        
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        
//        [alert show];
//        return;
//    }
//    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        return 54;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 2) {
        
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-15, 30)];
        
        lab.textColor = [UIColor darkGrayColor];
        lab.text = @"添加问题";
        
        if (![self.type isEqualToString:@"re"]) {
         
            [view addSubview:lab];
        }
        
        return view;
    }
    
    else{
     
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
        
        return view;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self.type isEqualToString:@"re"]) {
        
        return 10;
    }
    
    if (section ==2) {
        
        return 30;
    }
    
    return 10;
}


@end

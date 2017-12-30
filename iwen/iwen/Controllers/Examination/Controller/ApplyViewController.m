//
//  ApplyViewController.m
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyTableViewCell.h"
#import "TypeViewController.h"
@interface ApplyViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextViewDelegate,TypeViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *leftArray;

@property (nonatomic, strong) NSMutableArray *rigArray;

@property (nonatomic, strong) NSMutableArray *rightList;

@property (nonatomic, strong) PersonModel *userModel;
@end

@implementation ApplyViewController
{
    
    NSString *logoUrl;
    
    NSString *fstatue;
    
    NSString *fstatueName;
    
    NSIndexPath *indexpath;
}
#pragma mark getter

- (NSMutableArray *)leftArray{
    
    if (!_leftArray) {
        
        _leftArray = [@[@[@"商家名称",@"行业选择",@"商家官网"],@[@"联系电话"],@[@"联系人"]]mutableCopy];
        
    }
    return _leftArray;
}

- (NSMutableArray*)rigArray{
    
    if (!_rigArray) {
        
        _rigArray = [@[[@[@"请输入商家名称",@"请选择行业",@"请输入商家官网"] mutableCopy],[@[@"请输入联系电话"]mutableCopy],[@[@"请输入联系人"]mutableCopy]] mutableCopy];
    }
    
    return _rigArray;
}

- (NSMutableArray*)rightList{
    
    if (!_rightList) {
        
        _rightList = [@[[@[@"请输入商家名称",@"请选择行业",@"请输入商家官网"] mutableCopy],[@[@"请输入联系电话"]mutableCopy],[@[@"请输入联系人"]mutableCopy]] mutableCopy];
    }
    
    return _rightList;
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
    
    self.title = @"商家申请";
    
    UINib *detailNib = [UINib nibWithNibName:@"ApplyTableViewCell" bundle:nil];
    
    [self.tableview registerNib:detailNib forCellReuseIdentifier:@"AppCell"];

    [self.tableview setTableHeaderView:self.headview];
    
    [self.tableview setTableFooterView:self.footview];
    
}

#pragma mark Action

- (IBAction)logoAciton:(UIButton *)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}

- (IBAction)upAction:(id)sender {
    
    if (!logoUrl.length>0) {
        
        [self showHudWithString:@"请上传LOGO"];
        return;
    }
    
    if (!self.textview.text.length>0) {
        
        [self showHudWithString:@"请输入商家介绍..."];
        
        return;
    }
    
    if (!fstatueName.length>0) {
        
        [self showHudWithString:@"请选择行业"];
        return;
    }
    
    BOOL isWrite = YES;
    
    for (int a = 0; a<self.rigArray.count; a++) {
        
        NSMutableArray *ary = self.rigArray[a];
        
        for (int x = 0; x<ary.count; x++) {
            
            NSString *str = ary[x];
            NSString *destr = self.rightList[a][x];
            
            if ([str isEqualToString:destr] && x !=1) {
                
                [self showHudWithString:destr];
                
                isWrite = NO;
                
                break;
            }
            
        }
    }
    

    
    if (isWrite) {
        
        NSDictionary *dic = @{ @"flogo":logoUrl,
                              @"fcompanyName":self.rigArray[0][0],
                              @"ftypeId":fstatue,
                              @"fwebsite":self.rigArray[0][2],
                              @"ftelPhone":self.rigArray[1][0],
                              @"fcontacts":self.rigArray[2][0],
                              @"detial":self.textview.text

                              };
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
        NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        [[ExamService shareInstenced]getChapterPracticeWithTypeId:jsonStr uid:self.userModel.use.ftoken];
        
        [self showHud];
        [ExamService shareInstenced].getChapterPracticeSuccess = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:@"申请成功,待审核"];
            
            [self.navigationController popViewControllerAnimated:YES];
        };
        [ExamService shareInstenced].getChapterPracticeFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:@"申请失败"];
            
        };
    }
}

#pragma mark Service


#pragma mark TypeViewControllerDelegate

- (void)didSelectDic:(NSDictionary *)dic{
    
    fstatueName = dic[@"fname"];
    
    fstatue    = dic[@"fid"];
    
    NSMutableArray *temp = self.rigArray[0];
    
    [temp replaceObjectAtIndex:1 withObject:fstatueName];
    
    [self.rigArray replaceObjectAtIndex:0 withObject:temp];
    
    [self.tableview reloadData];
 
}

#pragma mark UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    
   
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        UITextField *texfield = [alertView textFieldAtIndex:0];
        
        
        if (texfield.text.length>0) {
            
            
//            [self updateUserInfoWithString:texfield.text];
        
            
            NSMutableArray *temp = self.rigArray[indexpath.section];
            
            [temp replaceObjectAtIndex:indexpath.row withObject:texfield.text];
            
            [self.rigArray replaceObjectAtIndex:indexpath.section withObject:temp];
            
//            str = texfield.text;
            
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
        
        [self.logobtn setBackgroundImage:image forState:UIControlStateNormal];
        
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
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        logoUrl = dic[@"fmediaUrl"];
        
        
    };
    
    [LoginService shareInstanced].upDateAvatarFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    cell.textLabel.text = self.leftArray[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = self.rigArray[indexPath.section][indexPath.row];
    return cell;
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
//    didSelectIndex = indexPath.row;
    
    indexpath = indexPath;
    
    if (indexPath.row == 1) {
        
        TypeViewController *vc = [[TypeViewController alloc]init];
        
        vc.delegate = self;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        NSString *str = self.rigArray[indexPath.section][indexPath.row];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@：",str] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        [alert show];
        
    }
    
}


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




@end

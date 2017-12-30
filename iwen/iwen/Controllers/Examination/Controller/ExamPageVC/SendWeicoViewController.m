//
//  SendWeicoViewController.m
//  iwen
//
//  Created by Interest on 16/3/15.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SendWeicoViewController.h"
#import "VideoModel.h"
@interface SendWeicoViewController ()<UIActionSheetDelegate,UITextViewDelegate>
@property (nonatomic, strong) PersonModel *userModel;

@property (nonatomic, strong) NSMutableArray *imgList;
@property (nonatomic, strong) UIBarButtonItem *settingItem;
@property (nonatomic, strong) NSMutableArray *imgData;
@end

@implementation SendWeicoViewController
{
      NSString *imgStr;
      NSString *videoUrl;
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
- (UIBarButtonItem *)settingItem{
    
    if (_settingItem  == nil) {
        
        UIButton *blogItem         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [blogItem setTitle:@"发表" forState:UIControlStateNormal];
        [blogItem addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        _settingItem = [[UIBarButtonItem alloc]initWithCustomView:blogItem];
        
        
    }
    
    return _settingItem;
}
#pragma mark UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
#define MY_MAX 20
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)setting{
    
    if (!(self.textview.text.length>0)) {
        
        [self showHudWithString:@"请输入介绍"];
        return;
    }
    
    if ((!(self.imgData.count>0)) && !(videoUrl.length>0)) {
        
        [self showHudWithString:@"请上传图片,或者视频..."];
        
        return;
    }
    NSMutableString *imgs = [NSMutableString string];
    for (NSDictionary *dic in self.imgData) {
        
        [imgs appendString:[NSString stringWithFormat:@"%@,",dic[@"fmediaUrl"]]];
        
    }
    
    
    NSLog(@"%@",imgs);

    imgStr = imgs;
    
    [self showHud];
    [ExamService shareInstenced].upLoadExamSuccess = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:@"发送成功"];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [ExamService shareInstenced].upLoadExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
        
    };
    
    NSString *str = self.textview.text;
    if (!(str.length>0)) {
        return;
    }
    if (str.length>20) {
        
        str = [str substringToIndex:19];
    }
    
    
    [[ExamService shareInstenced]upLoadExamWithExamId:self.userModel.use.ftoken topic_answer:str time:imgStr video:videoUrl];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表旗袍说";
    videoUrl = @"";
    [self.textview setPlaceholder:@"请输入内容(20字以内)..."];
    self.navigationItem.rightBarButtonItem = self.settingItem;
}
- (IBAction)addImage:(UIButton *)sender{
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"拍视频",@"选择图片或视频", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}
#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
    
    [PhotoManager shareManager].configureBlock = ^(id obj){
        if(obj == nil)
        {
            return ;
        }
        if ([obj isKindOfClass:[VideoModel class]]) {
            VideoModel *model = (VideoModel *)obj;
            NSURL *videoURL = model.videoURL;
            NSURL *mp4 = [self convert2Mp4:videoURL];
            NSFileManager *fileman = [NSFileManager defaultManager];
            if ([fileman fileExistsAtPath:videoURL.path]) {
                NSError *error = nil;
                [fileman removeItemAtURL:videoURL error:&error];
                if (error) {
                    NSLog(@"failed to remove file, error:%@.", error);
                }
            }
            [self showHud];
            [[HttpService sharedInstance]uploadFile:@"http://120.76.112.202/api/videoUpload" withParams:@{@"savePath":@"video"} fileURL:mp4 fileKey:@"videoData" completionBlock:^(id obj) {
                NSLog(@"%@",obj);
                [self hideHud];
                videoUrl = obj[@"obj"][@"fmediaUrl"];
                if (videoUrl.length>0) {
                    
                    UIImageView *imgv = self.imgList[0];
                    imgv.image = model.image;
                    self.addbtn.userInteractionEnabled = NO;
                }
                
                
            } failureBlock:^(NSError *error, NSString *responseString) {
                NSLog(@"%@",responseString);
                [self hideHud];
            }];
            
            
        }
        else{
            
            UIImageView *imgv = self.imgList[self.imgData.count];
            
            imgv.image = (UIImage *)obj;
            
            NSData *data  = UIImageJPEGRepresentation((UIImage *)obj, 0.2);
            
            NSString  *base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [self upLoadAvtarWithbase64String:base64Sting];
            
        }
        
        
    };
    
    
    if(buttonIndex == 0)
    {
        [self presentViewController:[PhotoManager shareManager].camera animated:YES completion:nil];
    }
    else if (buttonIndex == 1){

        [self presentViewController:[PhotoManager shareManager].video animated:YES completion:nil];
//        [PhotoManager shareManager].configureBlock = ^(id obj){
//    
//            if (obj !=nil) {
//                //[self sendImageMessage:(UIImage *)obj];
//                if ([obj isKindOfClass:[VideoModel class]]) {
//                    VideoModel *model = (VideoModel *)obj;
//                    NSURL *videoURL = model.videoURL;
//                    NSURL *mp4 = [self convert2Mp4:videoURL];
//                    NSFileManager *fileman = [NSFileManager defaultManager];
//                    if ([fileman fileExistsAtPath:videoURL.path]) {
//                        NSError *error = nil;
//                        [fileman removeItemAtURL:videoURL error:&error];
//                        if (error) {
//                            NSLog(@"failed to remove file, error:%@.", error);
//                        }
//                    }
//                    [self showHud];
//                    [[HttpService sharedInstance]uploadFile:@"http://120.76.112.202/api/videoUpload" withParams:@{@"savePath":@"video"} fileURL:mp4 fileKey:@"videoData" completionBlock:^(id obj) {
//                        NSLog(@"%@",obj);
//                        [self hideHud];
//                        videoUrl = obj[@"obj"][@"fmediaUrl"];
//                        if (videoUrl.length>0) {
//                            
//                            UIImageView *imgv = self.imgList[0];
//                            imgv.image = model.image;
//                            self.addbtn.userInteractionEnabled = NO;
//                        }
//                        
//                        
//                    } failureBlock:^(NSError *error, NSString *responseString) {
//                        NSLog(@"%@",responseString);
//                        [self hideHud];
//                    }];
//                    
//                    
//        };
//            }
//    
//        };
    }
    else{
    

        [self presentViewController:[PhotoManager shareManager].pickingImageView animated:YES completion:nil];
//        [PhotoManager shareManager].configureBlock = ^(id image){
//            if(image == nil)
//            {
//                return ;
//            }
//            
//            UIImageView *imgv = self.imgList[self.imgData.count];
//            
//            imgv.image = image;
//            
//            NSData *data  = UIImageJPEGRepresentation(image, 0.2);
//            
//            NSString  *base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//            
//            [self upLoadAvtarWithbase64String:base64Sting];
//        
//        };
    }
}

- (void)upLoadAvtarWithbase64String:(NSString *)string{
    
    
    [[LoginService shareInstanced]saveAvatarWithUserId:@"chineseDress" avatarString:string];
    
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

#pragma mark - helper
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

@end

//
//  SendBlogViewController.m
//  iwen
//
//  Created by Interest on 15/10/13.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "SendBlogViewController.h"
#import "BlogTypeViewController.h"

#import "BlogData.h"
#define BorderWidth 1
@interface SendBlogViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIBarButtonItem *sendItem;
@end

@implementation SendBlogViewController

{
 
    
    NSString *base64Sting;
}


#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUi];
    
}

- (void)setUpUi{
    
    self.title = @"发帖";
    
    self.view.backgroundColor              = BackgroundColor;
    
    self.textfield.layer.masksToBounds     = YES;
    
    self.textfield.layer.borderWidth       = BorderWidth;
    
    self.textfield.layer.borderColor       = [SeparatorColor CGColor];
    
    self.textView.layer.masksToBounds      = YES;
    
    self.textView.layer.borderWidth        = BorderWidth;
    
    self.textView.layer.borderColor        = [SeparatorColor CGColor];
    
    self.navigationItem.rightBarButtonItem = self.sendItem;
}


#pragma mark Action

- (void)send{
    
    if (!self.textfield.text.length>0) {
        
        [self showHudWithString:@"请输入标题"];
        return;
    }
    
    if (!self.textView.text.length>0) {
        
        [self showHudWithString:@"请输入内容"];
        return;
    }
    
    if (!base64Sting.length>0) {
        
        [self showHudWithString:@"请选择图片"];
        return;
    }
    
    BlogData *model = [[BlogData alloc]init];
    
    model.title  = self.textfield.text;
    
    model.content = self.textView.text;
    
    model.base64Str = base64Sting;
    
    BlogTypeViewController *vc = [[BlogTypeViewController alloc]init];
    
//    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectimg:(id)sender {
    
    
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
        
        base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        [self.imgvBtn setImage:image forState:UIControlStateNormal];
       
    };
}



#pragma mark getter
- (UIBarButtonItem *)sendItem{
    
    if (_sendItem  == nil) {
        
        UIButton *sendbtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [sendbtn setTitle:@"发表" forState:UIControlStateNormal];
        [sendbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendbtn.titleLabel.font   = [UIFont systemFontOfSize:14.0];
        [sendbtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        _sendItem = [[UIBarButtonItem alloc]initWithCustomView:sendbtn];
        

    }
    
    return _sendItem;
}


@end

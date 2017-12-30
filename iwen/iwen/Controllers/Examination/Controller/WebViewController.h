//
//  WebViewController.h
//  ZhuZhu
//
//  Created by Carl on 15/3/20.
//  Copyright (c) 2015年 Vison. All rights reserved.
//



@interface WebViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSString * url;


@end

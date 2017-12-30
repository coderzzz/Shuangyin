//
//  SignInViewController.m
//  ZhuZhu
//
//  Created by GZInterest on 15/2/5.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "SignInViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


@interface SignInViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) MAMapView* signInMapView;
@property (nonatomic, strong)  UIBarButtonItem *doneItem;
@property (nonatomic,strong) NSString * keyword;
@property (nonatomic,strong) NSMutableArray * searchArr;
@end

@implementation SignInViewController
{
    NSMutableArray *dataSource;
    CLLocation *lcation;
    
    NSString *str;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchArr = [@[] mutableCopy];
    dataSource = [NSMutableArray array];

    self.title = @"地图";
    [self initSignInMapView];
}
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
- (void)done{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectWithCoordinate:)] && str.length>0) {
        
        [self.delegate didSelectWithCoordinate:str];
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}


-(void)initSignInMapView
{
    //配置高德AppKey
    [MAMapServices sharedServices].apiKey = @"a6d882491c36a12e80fa4f63677902be";
   
    CGRect rect = self.view.bounds;
    
    _signInMapView = [[MAMapView alloc]initWithFrame:rect];
    _signInMapView.delegate = self;
    _signInMapView.showTraffic = NO;
    _signInMapView.showsCompass = NO;
    _signInMapView.showsScale = NO;
    
    
    
    
    [_signInMapView setZoomLevel:_signInMapView.maxZoomLevel-4 animated:YES];
    _signInMapView.userTrackingMode =MAUserTrackingModeFollow;
    [self.view addSubview:_signInMapView];
    
    
    if (self.coord.length>0) {
        
        _signInMapView.showsUserLocation = NO;
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        
        NSArray *ary = [self.coord componentsSeparatedByString:@","];
        
        if (ary.count>0) {
            
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([ary[0]floatValue], [ary[1] floatValue]);
            
            [_signInMapView setCenterCoordinate:coordinate];
            
            pointAnnotation.coordinate = coordinate;
            pointAnnotation.title = @"";
            pointAnnotation.subtitle = @"";
            
            [_signInMapView addAnnotation:pointAnnotation];
        }
        
//        pointAnnotation.coordinate =userLocation.coordinate;
       
        
        
    }
    else{
        
        _signInMapView.showsUserLocation = YES;
         self.navigationItem.rightBarButtonItem = self.doneItem;
    }
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
}


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        str = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude];
        
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//updatingLocation:(BOOL)updatingLocation
//{
//    if(updatingLocation) {
//   
//        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//        pointAnnotation.coordinate =userLocation.coordinate;
//        pointAnnotation.title = @"方恒国际";
//        pointAnnotation.subtitle = @"阜通东大街6号";
//        
//        [_signInMapView addAnnotation:pointAnnotation];
//        
//    }
//}




@end

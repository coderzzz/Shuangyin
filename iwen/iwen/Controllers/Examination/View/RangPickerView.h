//
//  RangPickerView.h
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RangPickerViewType){
    
    RangPickerViewProvince ,
    
    RangPickerViewDate ,
    
};

@class RangPickerView;
@protocol RangPickerViewDelegate <NSObject>

@optional

- (void)pickerView:(RangPickerView *)pickerView didSelectedString:(NSString  *)string rangPickerViewType:(RangPickerViewType)rangPickerViewType;

@end

@interface RangPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,weak)   id<RangPickerViewDelegate>delegate;

@property (nonatomic,assign) BOOL           isShowing;

@property (nonatomic,strong) UIToolbar      *toolbar;

@property (nonatomic,strong) UIPickerView   *pickerView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic)   RangPickerViewType  rangPickerViewType;

- (void)dismiss;


- (void)showInView:(UIView *)view;

@end

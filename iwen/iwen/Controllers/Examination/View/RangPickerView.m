//
//  RangPickerView.m
//  iwen
//
//  Created by Interest on 15/10/20.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "RangPickerView.h"

#define AnimateWithDuration  0.2

#define ToolBarHeight        48

#define PickerViewHeight        216


#define DoneBtnFont          [UIFont systemFontOfSize:14]

@implementation RangPickerView

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        [self addSubview:self.toolbar];
        
        [self addSubview:self.pickerView];
        
        self.frame = CGRectMake(0, ScreenHeight-64, ScreenWidth, ToolBarHeight + PickerViewHeight);
        
    }
    return self;
}

#pragma Action

- (void)done{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectedString:rangPickerViewType:)]) {
        
        NSString *str = self.dataSource[[self.pickerView selectedRowInComponent:0]];
        
        [self.delegate pickerView:self didSelectedString:str rangPickerViewType:self.rangPickerViewType];
        
    }
    
    
    
    [self dismiss];
    
}


- (void)showInView:(UIView *)view{
    
    [self removeFromSuperview];
    
    [view addSubview:self];
    
    [UIView animateWithDuration:AnimateWithDuration animations:^{
        
        self.frame = CGRectMake(0, ScreenHeight-64-ToolBarHeight-PickerViewHeight, ScreenWidth,  ToolBarHeight + PickerViewHeight);
        
        
    }];
    
    self.isShowing = YES;
}


- (void)dismiss{
    
    
    [UIView animateWithDuration:AnimateWithDuration animations:^{
        
        self.frame = CGRectMake(0, ScreenHeight-64, ScreenWidth, ToolBarHeight + PickerViewHeight);
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.isShowing = NO;
            
            [self removeFromSuperview];
        }
    }];
    
    
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return  self.dataSource.count;
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
    
}



#pragma  mark getter

- (void)setDataSource:(NSMutableArray *)dataSource{
    
    if (dataSource) {
        
        _dataSource = dataSource;
        
        [self.pickerView reloadAllComponents];
        
        
    }
    
    
    
}

- (UIToolbar *)toolbar{
    
    if (_toolbar == nil) {
        
        _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ToolBarHeight)];
        
        
         _toolbar.backgroundColor = BackgroundColor;
        
        UIBarButtonItem *spaceItem  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
        
        UIButton *doneBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        doneBtn.titleLabel.font   = DoneBtnFont;
        
        [doneBtn addTarget:self action:@selector(done)
            forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
        
        _toolbar.items              = @[spaceItem,doneItem];
        
        
        
       
        
    }
    
    return _toolbar;
}

- (UIPickerView *)pickerView{
    
    if (_pickerView == nil) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ToolBarHeight, ScreenWidth, PickerViewHeight)];
        
        _pickerView.dataSource = self;
        
        _pickerView.delegate   = self;
        
        _pickerView.backgroundColor = BackgroundColor;
        
    }
    
    return _pickerView;
    
}



@end

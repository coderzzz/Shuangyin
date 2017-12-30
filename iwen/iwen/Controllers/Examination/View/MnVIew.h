//
//  MnVIew.h
//  iwen
//
//  Created by Interest on 15/12/1.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MnViewDelegate <NSObject>

@optional

- (void)didTapBtnWithTag:(NSInteger)tag;


@end
@interface MnVIew : UIView


@property (weak, nonatomic) id<MnViewDelegate>delegate;

- (IBAction)BtnAction:(id)sender;

@end

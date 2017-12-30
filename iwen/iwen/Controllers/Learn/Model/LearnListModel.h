//
//  LearnListModel.h
//  iwen
//
//  Created by Interest on 15/12/24.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LearnListModel : JSONModel

@property (nonatomic, strong) NSMutableArray <Optional> * data;

@property (nonatomic, strong) NSString <Optional> * index;


@end

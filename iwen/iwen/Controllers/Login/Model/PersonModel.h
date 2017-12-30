//
//  PersonModel.h
//  iwen
//
//  Created by Interest on 16/3/4.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AdvModel.h"
#import "UserModel.h"
@interface PersonModel : JSONModel



@property (nonatomic, strong) AdvModel <Optional> * adv;

@property (nonatomic, strong) UserModel <Optional> * use;

@end

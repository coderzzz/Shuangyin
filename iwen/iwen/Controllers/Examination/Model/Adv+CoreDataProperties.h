//
//  Adv+CoreDataProperties.h
//  iwen
//
//  Created by sam on 16/10/4.
//  Copyright © 2016年 Interest. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Adv.h"

NS_ASSUME_NONNULL_BEGIN

@interface Adv (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *detial;
@property (nullable, nonatomic, retain) NSString *faddress;
@property (nullable, nonatomic, retain) NSString *fcompanyName;
@property (nullable, nonatomic, retain) NSString *fcontacts;
@property (nullable, nonatomic, retain) NSString *fcreatetime;
@property (nullable, nonatomic, retain) NSString *fid;
@property (nullable, nonatomic, retain) NSString *flogo;
@property (nullable, nonatomic, retain) NSString *fstatus;
@property (nullable, nonatomic, retain) NSString *ftelPhone;
@property (nullable, nonatomic, retain) NSString *ftotal;
@property (nullable, nonatomic, retain) NSString *ftypeId;
@property (nullable, nonatomic, retain) NSString *fupdatetime;
@property (nullable, nonatomic, retain) NSString *fuserId;
@property (nullable, nonatomic, retain) NSString *fwebsite;
@property (nullable, nonatomic, retain) NSString *fisCoupon;
@property (nullable, nonatomic, retain) NSString *fisRed;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END

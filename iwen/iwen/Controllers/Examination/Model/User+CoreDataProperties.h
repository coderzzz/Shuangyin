//
//  User+CoreDataProperties.h
//  
//
//  Created by Interest on 16/3/4.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)
@property (nullable, nonatomic, retain) NSString *fage;
@property (nullable, nonatomic, retain) NSString *fnickName;
@property (nullable, nonatomic, retain) NSString *fsignature;
@property (nullable, nonatomic, retain) NSString *falipay;
@property (nullable, nonatomic, retain) NSString *fcreateTime;
@property (nullable, nonatomic, retain) NSString *ffreezeMoney;
@property (nullable, nonatomic, retain) NSString *fheadImg;
@property (nullable, nonatomic, retain) NSString *fid;
@property (nullable, nonatomic, retain) NSString *fpassword;
@property (nullable, nonatomic, retain) NSString *fphone;
@property (nullable, nonatomic, retain) NSString *frealName;
@property (nullable, nonatomic, retain) NSString *frecommendCode;
@property (nullable, nonatomic, retain) NSString *fscore;
@property (nullable, nonatomic, retain) NSString *fsex;
@property (nullable, nonatomic, retain) NSString *fstatus;
@property (nullable, nonatomic, retain) NSString *ftoken;
@property (nullable, nonatomic, retain) NSString *ftotal;
@property (nullable, nonatomic, retain) NSString *ftpassword;
@property (nullable, nonatomic, retain) NSString *ftype;
@property (nullable, nonatomic, retain) Adv *adv;

@end

NS_ASSUME_NONNULL_END

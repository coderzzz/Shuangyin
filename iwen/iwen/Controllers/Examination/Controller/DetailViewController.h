//
//  DetailViewController.h
//  ibulb
//
//  Created by Interest on 16/1/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BaseViewController.h"
#import "CircleListModel.h"
@interface DetailViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (strong, nonatomic) IBOutlet UIView *headview;


@property (strong, nonatomic) IBOutlet UIView *footview;


@property (nonatomic) id advId;
@property (nonatomic,copy) NSString *type;
@property (nonatomic, copy) NSString *city;

@property (weak, nonatomic) IBOutlet UILabel *adname;

@property (weak, nonatomic) IBOutlet UILabel *adword;
@property (weak, nonatomic) IBOutlet UILabel *qlab;
@property (weak, nonatomic) IBOutlet UIView *picView;

@property (weak, nonatomic) IBOutlet UITextField *atext;

- (IBAction)getred:(id)sender;

- (IBAction)redaction:(id)sender;

- (IBAction)enterAdv:(id)sender;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *hideRed;

- (IBAction)hideAciton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *citylab;

@property (weak, nonatomic) IBOutlet UIImageView *flogo;


@property (weak, nonatomic) IBOutlet UIImageView *imgvlo;

@property (weak, nonatomic) IBOutlet UILabel *redputarea;

@property (weak, nonatomic) IBOutlet UIButton *redBtn;



@property (strong, nonatomic) IBOutlet UIView *redView;


@property (weak, nonatomic) IBOutlet UILabel *getRedLab;


@property (weak, nonatomic) IBOutlet UIButton *getRedBtn;


@property (strong, nonatomic) IBOutlet UIView *couHeadview;


@property (weak, nonatomic) IBOutlet UILabel *couNamelab;

@property (weak, nonatomic) IBOutlet UILabel *couClickLab;

@property (weak, nonatomic) IBOutlet UILabel *couAddLab;

@property (weak, nonatomic) IBOutlet UILabel *couMoneyLab;

@property (weak, nonatomic) IBOutlet UILabel *couNumLab;

@property (weak, nonatomic) IBOutlet UILabel *couDateLab;

@property (weak, nonatomic) IBOutlet UIView *couPicView;

//////////

@property (strong, nonatomic) IBOutlet UIView *reHeadView;
@property (strong, nonatomic) IBOutlet UIView *reFootView;

@property (weak, nonatomic) IBOutlet UIView *reAdView;

@property (weak, nonatomic) IBOutlet UILabel *reMoneyLAB;

@property (weak, nonatomic) IBOutlet UILabel *reOldLab;

@property (weak, nonatomic) IBOutlet UILabel *reNameLab;

@property (weak, nonatomic) IBOutlet UILabel *reDateLab;

@property (weak, nonatomic) IBOutlet UILabel *reCountLab;


@property (weak, nonatomic) IBOutlet UILabel *rePhoneLab;

- (IBAction)phoneAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *coupenuser;

@property (weak, nonatomic) IBOutlet UILabel *reduser;











@end

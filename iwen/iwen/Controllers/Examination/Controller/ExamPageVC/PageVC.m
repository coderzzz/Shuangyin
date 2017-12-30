//
//  PageVC.m
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "PageVC.h"
#import "containViewController.h"
#import "ExamCardViewController.h"
#import "ExamResultViewController.h"
#import "TimerView.h"
#import "CoupenViewController.h"
#import "MnVIew.h"
#import "PayView.h"
#import "CustomUserGuideScrollView.h"
@interface PageVC()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,ExamCardViewControllerDelegate,ExamResultViewController,UIAlertViewDelegate,PayViewDelegate,CoupenViewControllerDelegate,MnViewDelegate>

@property (nonatomic, strong) UserModel       * userInfo;

@property (nonatomic, strong) UIBarButtonItem * cardItem;

@property (nonatomic, strong) UIBarButtonItem * likeItem;

@property (nonatomic, strong) UIButton        * likeBtn;

@property (nonatomic, strong) UIBarButtonItem * timeItem;

@property (nonatomic, strong) TimerView       * timeView;

@property (nonatomic, strong) PayView         * payView;

@property (nonatomic, strong) MnVIew          * mnView;

@property (nonatomic, strong) NSMutableArray  * gradeList;

@end

@implementation PageVC
{
    
    UIPageViewController *testPage;

    NSUInteger           currentIndex;
    
    NSUInteger           currentGrade;
    
    NSString             *coupen;
    
    NSString             *likeStatue;
    
    NSString             *mnType;
    
    
    UIImageView          *imgv;
    
    
    int                  endOffsetX;
    
    
    int                  beginOffsetX;
}



#pragma mark ViewLife

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];

}

- (void)setUpUI{
    
    
    testPage = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    testPage.dataSource = self;
    testPage.delegate   = self;
    
    testPage.view.frame = self.view.bounds;
    
    
    
    [self addChildViewController:testPage];
    
    [self setUpNavBarItem];
    
    
    self.view.backgroundColor = BackgroundColor;
    [self.view addSubview:testPage.view];
    [testPage didMoveToParentViewController:self];
    
    for (UIView *view in testPage.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            
            UIScrollView *scrollview = (UIScrollView *)view;
            
            scrollview.delegate = self;
            
            
        }
        
    }
    
}

- (void)setUpNavBarItem{
    
    
   if (self.examType ==ChapterExam || self.examType == OrderExam ||self.examType == RandomExam ) {
        
        self.navigationItem.rightBarButtonItems = @[self.timeItem,self.cardItem,self.likeItem];
   }
   else if(self.examType == LikeExam){
       
        self.navigationItem.rightBarButtonItems = @[self.likeItem];
   }
   else if (self.examType == ErrorExam){
       
       self.navigationItem.rightBarButtonItems = @[self.cardItem,self.likeItem];

   }
   else{
       
       self.navigationItem.rightBarButtonItems = @[self.timeItem,self.cardItem];
   }
    
}

- (void)reloadNavBar{
    
    ChapterPracticeModel *model = self.dataSource[currentIndex];
    
    if (self.examType ==ChapterExam || self.examType == OrderExam ||self.examType == RandomExam || self.examType ==LikeExam || self.examType == ErrorExam){
        
        likeStatue   = model.like_status;
        
        NSString *imageName = [likeStatue boolValue]?@"首页-考试-我的错题2":@"首页-考试-我的错题1";
        
        [self.likeBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addNotifi];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Action

- (void)back{
    
    NSLog(@"aa");
    
    
    if (self.examType ==ChapterExam || self.examType == OrderExam ||self.examType == RandomExam ) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存练习数据？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 999;
        
        [alert show];
        
        return;
    }
    
    
    if (self.examType == SimulationExam|| self.examType == FormalExam) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出考试？退出考试会导致考试不及格！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 110;
        
        [alert show];
        
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)showMnView{
    
    [self.navigationController.view addSubview:self.mnView];
    
}

- (void)delData{
    
    NSArray *subs = [Subject MR_findByAttribute:@"name" withValue:[self getName] andOrderBy:@"disPlayOrder" ascending:YES];
    
    if (subs.count >0) {
        
        for (Subject *sub in subs) {
            
            [sub MR_deleteEntity];
            
            [[sub managedObjectContext] MR_saveToPersistentStoreAndWait];

        }
        
       
    }
}

- (NSString *)parseAnswer{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (ChapterPracticeModel *chapterModel in self.dataSource) {
        
        NSMutableArray *temp = [NSMutableArray array];
        
        NSMutableArray *myIdArray = [NSMutableArray array];
        
        NSMutableArray *correctIdArray = [NSMutableArray array];
        
        for (int a = 0; a<chapterModel.option.count; a++) {
            
            OptionModel *model = chapterModel.option[a];
            
            
            if ([model.is_answer boolValue]) {
                
                [correctIdArray addObject:model.id];
                
            }
            
            if ([model.isSelect boolValue]) {
                
                [myIdArray addObject:model.id];
                
            }
        }
        
        
        BOOL isCorrect = [myIdArray isEqualToArray:correctIdArray];
        
        NSString *str;
        
        if (isCorrect) {
            
            str = @"1";
        }
        else{
            
            str= @"0";
        }
        
        temp = [@[self.userInfo.uid,chapterModel.id,myIdArray,str] mutableCopy];
        
        [dataArray addObject:temp];
        
    }

    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataArray options:kNilOptions error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSString *jsonStr = [dataArray JSONString];
    
    return jsonStr;
}

- (void)saveData{
    
   
    [self showHud];
    [[ExamService shareInstenced]savePracticeWithJsonString:[self parseAnswer] time:self.timeView.lable.text];
    
    [ExamService shareInstenced].savePracticeSuccess = ^(id obj){
        
        [self hideHud];
        
        [self saveDataToLoacal];
        
    };
    
    [ExamService shareInstenced].savePracticeFailure = ^(id obj){
      
        [self hideHud];
        [self showHudWithString:obj];
    };
    
    
}

- (void)saveDataToLoacal{
    
    [self delData];
    
    for (int a = 0; a<self.dataSource.count; a++) {
        
        ChapterPracticeModel *model = self.dataSource[a];
        
        Subject *sub = [Subject MR_createEntity];
        
        sub.name = [self getName];
        
        sub.disPlayOrder = @(a);
        
        sub.id = model.id;
        
        sub.likeStatue = model.like_status;
        
        sub.courseId = model.course_class_id;
        
        sub.title = model.title;
        
        sub.status = model.status;
        
        sub.ismulti = model.ismulti;
        
        sub.analysis = model.analysis;
        
        sub.isFinsh = model.isFinsh;
        
        sub.examId = model.examId;
        
        sub.answerString = model.answerString;
        
        
        for (int x = 0; x<model.option.count; x++) {
            
            OptionModel *op =  model.option[x];
            
            Choose *ch = [Choose MR_createEntity];
            
            ch.disPlayOrder = @(x);
            
            ch.id = op.id;
            
            ch.tid = op.tid;
            
            ch.content = op.content;
            
            ch.is_answer = op.is_answer;
            
            ch.isSelect = op.isSelect;
            
            [sub addChoosesObject:ch];
            
        }
        
        
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (NSString *)getName{
    
     NSString *value;
    
    if (self.examType == ChapterExam) {
        
        value = [NSString stringWithFormat:@"%@%@",self.userInfo.uid,self.chapterId];
    }
    
    if (self.examType == OrderExam) {
        
        value = [NSString stringWithFormat:@"%@Order",self.userInfo.uid];
    }
    
    if (self.examType == RandomExam) {
        
        value = [NSString stringWithFormat:@"%@Ran",self.userInfo.uid];
    }
    
    return value;
    
}

- (BOOL)isExistData{
    
    NSString *value = [self getName];

    NSArray *subs = [Subject MR_findByAttribute:@"name" withValue:value andOrderBy:@"disPlayOrder" ascending:YES];
    
    if (subs.count >0) {
        
        return YES;
    }
    else{
        
        return NO;
    }
}

- (void)findata{
    
    NSArray *subs = [Subject MR_findByAttribute:@"name" withValue:[self getName] andOrderBy:@"disPlayOrder" ascending:YES];
    
    NSMutableArray *data = [NSMutableArray array];

    
    for (Subject *sub in subs) {
        
        ChapterPracticeModel *model = [[ChapterPracticeModel alloc]init];
        
        
        model.id = sub.id;
        
        model.like_status = sub.likeStatue;
        
        model.course_class_id = sub.courseId;
        
        model.title = sub.title;
        
        model.status = sub.status;
        
        model.ismulti = sub.ismulti;
        
        model.analysis = sub.analysis;
        
        model.isFinsh = sub.isFinsh;
        
        model.examId = sub.examId;
        
        model.answerString = sub.answerString;
        
        NSArray *temp = [sub.chooses allObjects];
        
        NSSortDescriptor *sort= [[NSSortDescriptor alloc]initWithKey:@"disPlayOrder" ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sort count:1];
        NSArray *test= [temp sortedArrayUsingDescriptors:sortDescriptors];
        
        model.option = [NSMutableArray array];
        
        for (Choose *ch in test) {
            
            OptionModel *op = [[OptionModel alloc]init];
            
            op.id = ch.id;
            
            op.tid = ch.tid;
            
            op.content = ch.content;
            
            op.is_answer = ch.is_answer;
            
            op.isSelect = ch.isSelect;
            
            [model.option addObject:op];
            
        }
        
        [data addObject:model];
    }
    
    self.dataSource = data;
    
    [self reloadPage];
    
}


- (void)hidePayView{
    
    [self.payView removeFromSuperview];
    self.payView = nil;

}

- (void)like{
    
    ChapterPracticeModel *model = self.dataSource[currentIndex];
    
    [[ExamService shareInstenced]addExamLikeWithUid:self.userInfo.uid tid:model.id type:nil];
    
    [self showHud];
    [ExamService shareInstenced].addExamLikeSuccess = ^(id obj){
        
        [self hideHud];
        
        model.like_status = [NSString stringWithFormat:@"%@",obj];
        
        [self reloadNavBar];
    };
    
    [ExamService shareInstenced].addExamLikeFailure = ^(id obj){
        
        [self hideHud];
        
        [self showHudWithString:obj];
        
    };
}

- (void)card{
    
    ExamCardViewController *card = [[ExamCardViewController alloc]init];

    card.dataSource = self.dataSource;
    
    card.delegate = self;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:card];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];

}

- (void)reloadPageWithIndex:(NSUInteger)index{
    
    currentIndex = index;
    containViewController *vc;
    
    [self.timeView startTime];
    
    [self reloadNavBar];
    
    [testPage setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTest"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstTest"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showUserGuide];
    }

}


- (void)showUserGuide{
    
//    CustomUserGuideScrollView * guideView = [[CustomUserGuideScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageNames:@[@"手势提示1"] isShowPage:NO];
    
    imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    imgv.image = [UIImage imageNamed:@"手势提示1"];
    
    imgv.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideGuideView)];
    
    [imgv addGestureRecognizer:ges];
    
    
    [self.navigationController.view addSubview:imgv];
    
}


- (void)hideGuideView{
    
    [imgv removeFromSuperview];
    
}
- (void)reloadPage{
    
    
    [self reloadPageWithIndex:0];
//    currentIndex = 0;
//    containViewController *vc = [self viewControllerAtIndex:0];
//    
//    [self reloadNavBar];
//    
//    [testPage setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)saveRandomData{
    
    
    [self saveData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Notification

- (void)addNotifi{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(up) name:@"test" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToChapter) name:@"back" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxNotifi:) name:@"WxPay" object:nil];
    
    
    
}

- (void)backToChapter{
    
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [dele.ddmenu showRootController:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)up{
    
    
    NSLog(@"notfi");
    
    NSString *examId;

    NSMutableArray *data = [NSMutableArray array];
    
    for (ChapterPracticeModel *model in self.dataSource) {
        
        NSMutableArray *tarray = [NSMutableArray array];
        
        [tarray addObject:model.id];
        
        examId = model.examId;
        
        if (examId.length>0) {
            
            [tarray addObject:model.examId];
        }

        NSMutableArray *answerArray = [NSMutableArray array];
        
        for (OptionModel *op in model.option) {

            if ([op.isSelect boolValue]) {
                
                [answerArray addObject:op.id];
                
            }
            
        }
        
        NSString *str = [answerArray componentsJoinedByString:@","];
        
        [tarray addObject:str];
        
        [data addObject:tarray];
        
    }
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSString *jsonStr = [data JSONString];
    
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [dele.ddmenu showRootController:YES];
    
    if (self.examType == FormalExam)     [self upAnswerWithExamId:examId topic_answer:jsonStr time:@"1"];
    
    if (self.examType == SimulationExam) [self upMnAnswerWithExamId:examId topic_answer:jsonStr time:@"1" grade:@"1"];
    
    if (self.examType == ChapterExam)    [self loadNextChapterExamData];
    
    if (self.examType == LikeExam)       [self reloadPage];
    
    if (self.examType == ErrorExam)      [self loadErrorData];
    
    if (self.examType == OrderExam || self.examType == RandomExam)  [self loadRandomPracticeData];
    
}



#pragma mark Service

- (void)loadData{

    if (self.examType == FormalExam)     [self loadGradeData];
    
    if (self.examType == SimulationExam) [self showMnView];
    
    if (self.examType == ChapterExam || self.examType == RandomExam ||self.examType == OrderExam) [self showAlert];
    
    if (self.examType == LikeExam)        [self loadLikeData];
    
    if (self.examType == ErrorExam)       [self loadErrorData];
    
}

- (void)loadNetWorkData{
    
    if (self.examType == ChapterExam)     [self loadChapterExamData];
    
    if (self.examType == OrderExam)       [self loadOrderPracticeData];
    
    if (self.examType == RandomExam)      [self loadRandomPracticeData];

}

- (void)showAlert{
    
    if ([self isExistData]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否从继续上次练习？" delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles:@"继续做题", nil];
        alert.tag = 555;
        
        [alert show];
        
    }
    else{
        
        [self loadNetWorkData];
    }
}

- (void)loadGradeData{
    
    
    [[ExamService shareInstenced]getGradeTypeWithUid:self.userInfo.uid];
    [self showHud];
    [ExamService shareInstenced].getGradeTypeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.gradeList = obj;
        
        [self.navigationController.view addSubview:self.payView];
        
        
        if ([self.gradeList[0][@"is_charge"] boolValue]) {
            
              [self reloadPayViewWithPrice:[NSString stringWithFormat:@"%@",self.gradeList[0][@"exam_price"]]];
        }
        else{
            
            self.payView.weiChatBtn.hidden = YES;
            
            self.payView.coupenBtn.hidden = YES;
            
            self.payView.feeLab.text = @"免费";
            
            [self.payView.aliBtn setTitle:@"确定" forState:UIControlStateNormal];
        }
        
        
        
    };
    
    [ExamService shareInstenced].getGradeTypeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}


- (void)loadExamData{
    
    NSString *gradeId =self.gradeList[currentGrade][@"exam_id"];
    
    [[ExamService shareInstenced]getExamWithUid:self.userInfo.uid type:gradeId];
    
    [self showHud];
    [ExamService shareInstenced].getExamSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPage];
    };
    
    [ExamService shareInstenced].getExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };

}


- (void)loadMnExamDataWithType:(NSString *)type{
    
    [[ExamService shareInstenced]getMnExamWithUid:self.userInfo.uid type:type];
    
    [self showHud];
    [ExamService shareInstenced].getMnExamSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPage];
    };
    
    [ExamService shareInstenced].getMnExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)loadNextChapterExamData{
    
    NSUInteger index = [self.chapterArray indexOfObject:self.chapterId];
    
    index++;
    
    if (index >= self.chapterArray.count) {
        
        index = 0;
    }
    
    self.chapterId = self.chapterArray[index];
    
    [self loadChapterExamData];
}

- (void)loadChapterExamData{
    
    [[ExamService shareInstenced]getChapterPracticeWithTypeId:self.chapterId uid:self.userInfo.uid];
    
    [self showHud];
    [ExamService shareInstenced].getChapterPracticeSuccess = ^(id obj){
        
        
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPage];
    };
    
    [ExamService shareInstenced].getChapterPracticeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}


- (void)loadOrderPracticeData{
    
    
    [[ExamService shareInstenced]getPracticeWithTypeId:@"sequence" uid:self.userInfo.uid];
    
    [self showHud];
    [ExamService shareInstenced].getPracticeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPage];
    };
    
    [ExamService shareInstenced].getPracticeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)loadRandomPracticeData{
    
    
    [[ExamService shareInstenced]getPracticeWithTypeId:@"rand" uid:self.userInfo.uid];
    
    [self showHud];
    [ExamService shareInstenced].getPracticeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPage];
    };
    
    [ExamService shareInstenced].getPracticeFailure = ^(id obj){
      
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)loadLikeData{
    
    [[ExamService shareInstenced]getExamLikeWithUid:self.userInfo.uid cid:self.likeCid];
    
    [self showHud];
    [ExamService shareInstenced].getExamLikeSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPageWithIndex:self.likeIndex];
    };
    
    [ExamService shareInstenced].getExamLikeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)loadErrorData{
    
    [[ExamService shareInstenced]getErrorTitleWithUid:self.userInfo.uid tid:self.errorTid];
    
    [self showHud];
    [ExamService shareInstenced].getErrorTitleSuccess = ^(id obj){
        
        [self hideHud];
        
        self.dataSource = obj;
        
        [self reloadPageWithIndex:self.likeIndex];
    };
    
    [ExamService shareInstenced].getErrorTitleFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)upAnswerWithExamId:(NSString *)examId topic_answer:(NSString *)jsonStr time:(NSString *)time{
    
    [self showHud];
    
//    [[ExamService shareInstenced]upLoadExamWithExamId:examId topic_answer:jsonStr time:self.timeView.lable.text];
//    
    [ExamService shareInstenced].upLoadExamSuccess = ^(id obj){
        
        [self hideHud];
        
        ExamResultViewController *exam = [[ExamResultViewController alloc]init];
        
        exam.resultModel = obj;
        
        exam.delegate    =self;
        
        
        ChapterPracticeModel *model = [self.dataSource firstObject];
        
        
        
        exam.examId      = model.examId;
        
        [self.navigationController pushViewController:exam animated:YES];
        
    };
    
    [ExamService shareInstenced].upLoadExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

- (void)upMnAnswerWithExamId:(NSString *)examId topic_answer:(NSString *)jsonStr time:(NSString *)time grade:(NSString *)grade{
    
    [self showHud];
    [[ExamService shareInstenced]upLoadMnExamWithExamId:examId topic_answer:jsonStr time:self.timeView.lable.text grade:mnType];
    
    [ExamService shareInstenced].upLoadMnExamSuccess = ^(id obj){
        
        [self hideHud];
        
        ExamResultViewController *exam = [[ExamResultViewController alloc]init];
        
        exam.resultModel = obj;
        
        exam.delegate    =self;
        
        [self.navigationController pushViewController:exam animated:YES];
        
    };
    
    [ExamService shareInstenced].upLoadMnExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    
}

#pragma mark CoupenViewControllerDelegate

- (void)didSelectCoupenId:(NSString *)coupenId{
    
    coupen = coupenId;
    
    self.payView.hidden = NO;
    
    if (coupenId.length>0) {
        
        [self.payView.coupenBtn setImage:[UIImage imageNamed:@"首页-考试-培训费-圆点4"] forState:UIControlStateNormal];
    }
    else{
        
        [self.payView.coupenBtn setImage:[UIImage imageNamed:@"考试-使用优惠券"] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark MnViewDelegate

- (void)didTapBtnWithTag:(NSInteger)tag{
    
    
    
    if (tag == 0) mnType = @"1";
    
    if (tag == 1) mnType = @"2";
    
    if (tag == 2) mnType = @"3";
    
    [self loadMnExamDataWithType:mnType];
    
    [self.mnView removeFromSuperview];
    
     self.mnView = nil;
}

#pragma mark PayViewDelegate

- (void)reloadPayViewWithPrice:(NSString *)price{
    
    if ([price isEqualToString:@"0.00"]) {
        
         self.payView.aliBtn.hidden = NO;
        
        self.payView.weiChatBtn.hidden = YES;
        
        self.payView.coupenBtn.hidden = YES;
        
        self.payView.feeLab.text = @"免费";
        
        [self.payView.aliBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        
    }
    else if ([price isEqualToString:@"-1.00"]){
        
        [self showHudWithString:@"请选择其他等级"];
        
        self.payView.weiChatBtn.hidden = YES;
        
        self.payView.coupenBtn.hidden = YES;
        
        self.payView.feeLab.text = @"已通过";
        
        self.payView.aliBtn.hidden = YES;
        
    }
    else{
        
        self.payView.feeLab.text = [NSString stringWithFormat:@"%@元",price];
        
        self.payView.weiChatBtn.hidden = NO;
        
        self.payView.coupenBtn.hidden = NO;
        
        [self.payView.aliBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
        
        self.payView.aliBtn.hidden = NO;
    }
    
    
    
}

- (void)didPressBtnWithTag:(NSInteger)tag{

    
    if (tag == 0) {
        
   
            
        [self hidePayView];
        
        [self.navigationController popViewControllerAnimated:YES];
   

    }
    
    if (tag == 1 || tag == 2 || tag == 3 || tag == 4 || tag == 5 || tag == 6 || tag == 7 || tag == 8 ||tag == 9) {
        
        currentGrade = tag-1;
        
        if ([self.gradeList[0][@"is_charge"] boolValue]) {
            
//            self.payView.feeLab.text = [NSString stringWithFormat:@"%@元",self.gradeList[currentGrade][@"exam_price"]];
            
            [self reloadPayViewWithPrice:[NSString stringWithFormat:@"%@",self.gradeList[currentGrade][@"exam_price"]]];
        }
        else{
            
            self.payView.weiChatBtn.hidden = YES;
            
            self.payView.coupenBtn.hidden  = YES;
            
            self.payView.feeLab.text       = @"免费";
            
            [self.payView.aliBtn setTitle:@"确定" forState:UIControlStateNormal];
        }
        
        
        return;
        
    }
    
    if (tag == 10) {
        
        CoupenViewController *vc = [[CoupenViewController alloc]init];
        
        vc.delegate = self;
        
        self.payView.hidden = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (tag == 11) {
        
        [self wxPay];
    }
    
    if (tag == 12) {
        
        if (![self.gradeList[0][@"is_charge"] boolValue]) {
            
            [self loadExamData];
            [self hidePayView];
        }
        else{
            
            NSString *str =self.gradeList[currentGrade][@"exam_price"];
            
            if ([str isEqualToString:@"0.00"]) {
                
                [self loadExamData];
                [self hidePayView];
            }
            else{
                
//                [self doAlipay];
                
            }
            
        }

    }
}

#pragma mark ExamResultViewController

- (void)tryAgin{
    
    
    if (self.examType == FormalExam)    [self loadExamData];
    
    if (self.examType == SimulationExam) [self loadMnExamDataWithType:mnType];

}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 999) {
        
        if (buttonIndex == 1) {
            
            [self saveData];
        }
        else{
            
            [self delData];
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    if (alertView.tag == 110) {
        
        if (buttonIndex == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        return;
    }
    
    if (alertView.tag == 555) {
        
        if (buttonIndex == 1) {
            
           [self findata];
            
    
            
            
        }
        else{
            
           [self loadNetWorkData];
        }
     
    }
    
}


#pragma mark Pay

- (void)wxNotifi:(NSNotification *)notif{
    
    NSString *result = notif.object;
    
    if ([result boolValue]) {
        
        
        [self loadExamData];
    }
    else{
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)wxPay{
    
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        NSString *gradeId =self.gradeList[currentGrade][@"exam_id"];
        
        NSString *fee     =self.gradeList[currentGrade][@"exam_price"];
        
        [[ExamService shareInstenced]getWxPayInfoWithUid:self.userInfo.uid grade_id:gradeId fee:fee coupon_id:coupen];
        
        [self showHud];
        [ExamService shareInstenced].getWxPayInfoSuccess = ^(id obj){
            
            [self hideHud];
            [self hidePayView];
            
            
            NSDictionary *dic = obj;
            
            NSString * key = [dic allKeys][0];
            
            NSString *price = [NSString stringWithFormat:@"%@",dic[key]];
            
            if ([price isEqualToString:@"0"]) {
                
                [self loadExamData];
                
                return;
            }
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [obj objectForKey:@"appid"];
            req.partnerId           = [obj objectForKey:@"partnerid"];
            req.prepayId            = [obj objectForKey:@"prepayid"];
            req.nonceStr            = [obj objectForKey:@"noncestr"];
            req.timeStamp           = [[obj objectForKey:@"timestamp"] intValue];
            req.package             = @"Sign=WXPay";
            req.sign                = [obj objectForKey:@"sign"];
        
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            
            
        };
        
        [ExamService shareInstenced].getWxPayInfoFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
        };
        
    }
    else{
        
        
        [self showHudWithString:@"请安装最新版微信！"];
    }
 
}

//- (void)doAlipay{
//    
//    
//    NSString *gradeId =self.gradeList[currentGrade][@"exam_id"];
//    
//    NSString *fee     =self.gradeList[currentGrade][@"exam_price"];
//    
////    [[ExamService shareInstenced]getPayInfoWithUid:self.userInfo.uid grade_id:gradeId fee:fee coupon_id:coupen type:@""];
////    
//    [self showHud];
//    [ExamService shareInstenced].getPayInfoSuccess = ^(id obj){
//
////        [self hideHud];
////        [self hidePayView];
////
////        ExamGradeModel *model = obj;
////        
////        if ([model.price isEqualToString:@"0"]) {
////            
////            [self loadExamData];
////            
////            return;
////        }
////        
////
////        //将商品信息赋予AlixPayOrder的成员变量
////        Order *order = [[Order alloc] init];
////        order.partner = model.partner;
////        order.seller = model.seller_email;
////        order.tradeNO = model.out_trade_no; //订单ID（由商家自行制定）
////        order.productName = model.subject; //商品标题
////        order.amount = model.total_fee; //商品价格
////        //order.amount = @"0.01"; //商品价格
////        order.notifyURL =  model.notify_url; //回调URL
////
////        order.service = @"mobile.securitypay.pay";
////        order.paymentType = @"1";
////        order.inputCharset = @"utf-8";
////        order.itBPay = @"30m";
////        order.showUrl = @"m.alipay.com";
////
////        //应用注册scheme
////        NSString *appScheme = @"iwen";
////
////        //将商品信息拼接成字符串
////        NSString *orderSpec = [order description];
////        NSLog(@"orderSpec = %@",orderSpec);
////
////        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
////        NSString *privateKey =model.alipay_private_key;
////        privateKey = [privateKey stringByReplacingOccurrencesOfString:@" " withString:@""];
////
////        id<DataSigner> signer = CreateRSADataSigner(privateKey);
////
////        NSString *signedString = [signer signString:orderSpec];
////
////        //将签名成功字符串格式化为订单字符串,请严格按照该格式
////        NSString *orderString = nil;
////        if (signedString != nil) {
////            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
////                           orderSpec, signedString, @"RSA"];
////
////            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////
////                NSLog(@"reslut = %@",resultDic);
////
////                NSString *result = resultDic[@"resultStatus"];
////
////                if ([result isEqualToString:@"9000"]) {
////
////                    [self loadExamData];
////                }
////                else{
////
////                    [self.navigationController popViewControllerAnimated:YES];
////                    
////                }
////
////            }];
////            
////            
////        }
////
////        
////    };
//    
////    [ExamService shareInstenced].getPayInfoFailure = ^(id obj){
////        
////        [self hideHud];
////        [self showHudWithString:obj];
////    };
////    
//}
//
//#pragma mark UIScrollViewDelegate
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//
//    if (scrollView.contentOffset.x>ScreenWidth+1 && (currentIndex == self.dataSource.count-1)) {
//        
//        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        
//        [dele.ddmenu showRightController:YES];
//
//        
//        if (self.examType == FormalExam || self.examType == SimulationExam){
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"exam" object:nil];
//        }
//        
//        if (self.examType == ChapterExam ) {
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"chapter" object:nil];
//        }
//        
//        if (self.examType == LikeExam ){
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"like" object:nil];
//            
//        }
//        
//        if (self.examType == ErrorExam ){
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"errorexam" object:nil];
//            
//        }
//        
//        if (self.examType == OrderExam || self.examType == RandomExam){
//            
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"random" object:nil];
//        }
//      
//    }
//    
//}
//
//#pragma mark ExamCardViewControllerDelegate
//
//- (void)didSelectItemWithIndex:(NSUInteger)index{
//    
//    containViewController *vc = [self viewControllerAtIndex:index];
//    
//    currentIndex = index;
//    
//    [self reloadNavBar];
//    
//    [testPage setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//
//}
//
//#pragma mark UIPageViewControllerDataSource
//
//- (containViewController *)viewControllerAtIndex:(NSUInteger)index {
//  
//    if (([_dataSource count] == 0) ||
//        (index >= [_dataSource count])) {
//        return nil;
//    }
//   
//    containViewController *dataViewController = [[containViewController alloc]initWithNibName:@"containViewController" bundle:nil];
//    
//    dataViewController.data = [_dataSource objectAtIndex:index];
//    
//    dataViewController.examType =[NSString stringWithFormat:@"%ld",(long)self.examType];
//    
//    return dataViewController;
//}
//- (NSUInteger)indexOfViewController:(containViewController *)viewController {
//    
//    
//    currentIndex = [_dataSource indexOfObject:viewController.data];
//    
//    [self reloadNavBar];
//    
//    return currentIndex;
//}
//
//
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    NSUInteger index = [self indexOfViewController:
//                        (containViewController *)viewController];
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    index--;
//  
//    return [self viewControllerAtIndex:index];
//    
//}
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    NSUInteger index = [self indexOfViewController:
//                        (containViewController *)viewController];
//    if (index == NSNotFound) {
//        return nil;
//    }
//    index++;
//    if (index == [_dataSource count]) {
//        return nil;
//    }
//
//    return [self viewControllerAtIndex:index];
//    
//}
//
//#pragma mark getter
//
//- (MnVIew *)mnView{
//    
//    
//    if (_mnView == nil) {
//        
//        _mnView = [[MnVIew alloc]init];
//        
//        _mnView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//        
//        _mnView.delegate = self;
//    }
//    
//    return _mnView;
//}
//
//- (PayView *)payView{
//    
//    if (_payView == nil) {
//        
//        _payView = [[PayView alloc]init];
//        
//        _payView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//        
//        _payView.delegate = self;
//        
//        currentGrade = 0;
//        
//        coupen     = @"";
//        
//    }
//    
//    return _payView;
//}
//
//- (UIBarButtonItem *)cardItem{
//    
//    if (_cardItem  == nil) {
//        
//        UIButton *cardItem         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [cardItem setImage:[UIImage imageNamed:@"首页-考试-考试报告-答题卡2"] forState:UIControlStateNormal];
//        [cardItem addTarget:self action:@selector(card) forControlEvents:UIControlEventTouchUpInside];
//        _cardItem  = [[UIBarButtonItem alloc]initWithCustomView:cardItem];
//        
//        
//    }
//    
//    return _cardItem ;
//}
//
//
//- (UIBarButtonItem *)likeItem{
//    
//    if (_likeItem  == nil) {
//        
//        self.likeBtn         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [self.likeBtn setImage:[UIImage imageNamed:@"首页-考试-我的错题1"] forState:UIControlStateNormal];
//        [self.likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
//        _likeItem  = [[UIBarButtonItem alloc]initWithCustomView:self.likeBtn];
//        
//        
//    }
//    
//    return _likeItem;
//}
//
//- (UIBarButtonItem *)timeItem{
//    
//    if (_timeItem  == nil) {
//        
//        self.timeView = [[TimerView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
//        
//        _timeItem = [[UIBarButtonItem alloc]initWithCustomView:self.timeView];
//        
//    }
//    
//    return _timeItem;
//}
//
//- (UserModel *)userInfo{
//    
//    if (_userInfo == nil) {
//        
//        _userInfo = [[LoginService shareInstanced]getUserModel];
//    }
//    return _userInfo;
//    
//}
//- (NSMutableArray *)dataSource{
//    
//    if (_dataSource == nil) {
//        
//        _dataSource = [NSMutableArray array];
//        
//    }
//    
//    return _dataSource;
//    
//}
//
//- (NSMutableArray *)gradeList{
//    
//    if (_gradeList == nil) {
//        
//        _gradeList = [NSMutableArray array];
//        
//    }
//    
//    return _gradeList;
//    
//}
//
//#pragma mark delloc
//
//- (void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//
//    
//}
//
@end

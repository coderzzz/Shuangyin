//
//  containViewController.m
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "containViewController.h"
#import "ExamSectionView.h"
#import "Exam0ptionCell.h"
#import "AnswerCell.h"
#import "AnalysisCell.h"
@interface containViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *charSource;

@end

@implementation containViewController
{
 
    ChapterPracticeModel *chapterModel;

}
#pragma mark getter

- (void)setData:(id)data{
    
    if (data) {
        
        _data = data;
        
        [self reLoadTableWithData:data];

    }

}

- (NSMutableArray *)charSource{
    
    if (_charSource == nil) {
        
        _charSource = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"]mutableCopy];
        
    }
    
    return _charSource;
    
}
#pragma mark ViewLife cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib= [UINib nibWithNibName:@"Exam0ptionCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"optionCell"];
    
    UINib *answerNib= [UINib nibWithNibName:@"AnswerCell" bundle:nil];
    
    [self.tableview registerNib:answerNib forCellReuseIdentifier:@"Answer"];
    
    UINib *analysisNib= [UINib nibWithNibName:@"AnalysisCell" bundle:nil];
    
    [self.tableview registerNib:analysisNib forCellReuseIdentifier:@"Analysis"];
    
}



#pragma mark Action



#pragma mark Service

- (void)reLoadTableWithData:(id)data{
    
    if ([data isKindOfClass:[ChapterPracticeModel class]]) {
        
        chapterModel = data;
        
        [self.tableview reloadData];

    }
    
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.examType isEqualToString:@"1"] ||[self.examType isEqualToString:@"0"]) return 1;
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if ([chapterModel.isFinsh boolValue]) {
            
            return 2;
        }
        else{
            return 1;
        }
    }
    
    return chapterModel.option.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        Exam0ptionCell *cell = [self configOptionCellAtIndexPath:indexPath tableView:tableView];
        return cell;
    }
    else {
        
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Answer"];
        
        if (![chapterModel.isFinsh boolValue]) {
            
            cell.lab.text = @"查看解析";
            
            cell.lab.textColor = BaseColor;
            
            cell.lineLab.hidden = YES;
            
        }
        else{
            
            if (indexPath.row == 1) {
                
                AnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Analysis"];
                
                cell.lab.text = chapterModel.analysis;
                return cell;
                
            }
            else{
                
                cell.lab.textColor = [UIColor darkGrayColor];
                
                cell.lineLab.hidden = NO;
                
                cell.lab.text = chapterModel.answerString;
            }

        }
        
        return cell;
    }

}

- (Exam0ptionCell *)configOptionCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    
    Exam0ptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    [cell.btn setTitle:self.charSource[indexPath.row] forState:UIControlStateNormal];
    
    OptionModel *model = chapterModel.option[indexPath.row];

    cell.lab.text = model.content;
    
    
    if ([chapterModel.isFinsh boolValue]) {
        
        if ([model.isSelect boolValue]) {
            
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            cell.btn.backgroundColor = BaseColor;
            
            [cell btnBorderColorWitch:BaseColor];
            
        }
        else if(![model.isSelect boolValue] && [model.is_answer boolValue]){
            
            
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            cell.btn.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:158.0/255.0 blue:166.0/255.0 alpha:1];
            
            [cell btnBorderColorWitch:[UIColor clearColor]];
            
        }
        else{
            
            [cell.btn setTitleColor:BaseColor forState:UIControlStateNormal];
            
            cell.btn.backgroundColor = [UIColor clearColor];
            
            [cell btnBorderColorWitch:BaseColor];
        }
        
    }
    else{
        
        if ([model.isSelect boolValue]) {
            
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            cell.btn.backgroundColor = BaseColor;
            
            [cell btnBorderColorWitch:BaseColor];
            
        }
        else{
            
            [cell.btn setTitleColor:BaseColor forState:UIControlStateNormal];
            
            cell.btn.backgroundColor = [UIColor clearColor];
            
            [cell btnBorderColorWitch:BaseColor];
            
        }
    }
 
    return cell;
    
}


#pragma mark UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([chapterModel.isFinsh boolValue]) return;
    
    
    if (indexPath.section ==1) {
        
        BOOL isSelect = NO;
        
        for (OptionModel *model in chapterModel.option) {
            
            if ([model.isSelect boolValue]) {
                
                isSelect = YES;
                
                break;
            }
        }
        
        if (isSelect) {
            
            
            chapterModel.isFinsh = @"1";
            
            NSMutableArray *myCharArray = [NSMutableArray array];
            
            NSMutableArray *myIdArray = [NSMutableArray array];
            
            NSMutableArray *correctCharArray = [NSMutableArray array];
            
            NSMutableArray *correctIdArray = [NSMutableArray array];
            
            for (int a = 0; a<chapterModel.option.count; a++) {
                
                OptionModel *model = chapterModel.option[a];
                
                NSString *str = self.charSource[a];
                
                if ([model.is_answer boolValue]) {
                    
                    [correctIdArray addObject:model.id];
                    
                    [correctCharArray addObject:str];
                }
                
                if ([model.isSelect boolValue]) {
                    
                    [myIdArray addObject:model.id];
                    
                    [myCharArray  addObject:str];
                }
            }
            
            
            BOOL isCorrect = [myIdArray isEqualToArray:correctIdArray];
            
            NSString *temp = [correctCharArray componentsJoinedByString:@","];
            
            NSString *my   = [myCharArray componentsJoinedByString:@","];
            
            NSString *dataStr;
            
            if (!isCorrect) {
                
                dataStr = [NSString stringWithFormat:@"正确答案是%@,你的答案是%@,回答错误。",temp,my];
            }
            
            else{
                
                dataStr = @"回答正确。";
            }
            
            chapterModel.answerString = dataStr;
            
            [self.tableview reloadData];
            
            return;
            
        }
        
        return;
    }
    
    
    OptionModel *model = chapterModel.option[indexPath.row];

    if ([chapterModel.ismulti boolValue]) {

        model.isSelect = [model.isSelect boolValue]?@"0":@"1";

     }
     else{
        
         for (OptionModel *mo in chapterModel.option) {
             
             mo.isSelect = @"0";
         }
         
         model.isSelect = @"1";
     }

    [self.tableview reloadData];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return nil;
    }
    
    ExamSectionView *view = [[ExamSectionView alloc]init];
    
    if ([chapterModel.ismulti boolValue]) {
        
        view.lab.text = [NSString stringWithFormat:@"多选 %@",chapterModel.title];
    }
    else{
        
        view.lab.text = [NSString stringWithFormat:@"单选 %@",chapterModel.title];
    }
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            NSString *string = chapterModel.analysis;
            
            CGFloat h = [RTLabel getHightWithString:string andSizeValue:14.0 andWidth:(ScreenWidth-16)];
            
            h = h+70-36;
            
            if (h<70) {
                h = 70;
            }
            return 70;
        }
        return 44;
    }
    
    OptionModel *model = chapterModel.option[indexPath.row];
    
    NSString *string = model.content;
    
    CGFloat h = [RTLabel getHightWithString:string andSizeValue:14.0 andWidth:(ScreenWidth-8-51)];
    
    h = h+20;
    
    if (h<50) {
        
        h = 50;
    }
    
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == 1) {
        return 2;
    }
    NSString *string = [NSString stringWithFormat:@"多选 %@",chapterModel.title];
    
    CGFloat h = [RTLabel getHightWithString:string andSizeValue:16.0 andWidth:(ScreenWidth-16)];
    
    h = h+20;
    
    if (h<65) {
        
        h = 65;
    }

    return h;
}


@end

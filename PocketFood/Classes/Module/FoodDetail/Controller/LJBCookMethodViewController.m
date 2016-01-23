//
//  LJBCookMethodViewController.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  做法视图

#import "LJBCookMethodViewController.h"
#import "LJBFoodNetworker.h"
#import "LJBFoodMaterial.h"
#import "LJBAppraiseSectionView.h"
#import "LJBCookTipsCell.h"
#import "LJBCookStep.h"
#import "LJBCookStepCell.h"

@interface LJBCookMethodViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) LJBFoodMaterial * materialModel;

@end

@implementation LJBCookMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self getDataFromServer];
}

#pragma mark - 适配子控件
- (void)addSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 64, 0));
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [LJBFoodNetworker getFoodDataFromServerWithSuccess:^(id model) {
        
        self.materialModel = model;
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 计算步骤内容高度
            for (LJBCookStep * stepModel in self.materialModel.steps) {
                
                stepModel.descHeight = [self calculateStepDescSizeWithModel:stepModel];
            }
            
            // 计算贴士高度
            [self calculateTipsSize];
            
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food material error:%@", error);
        
    } withFoodCode:[LJBFoodSingleTon sharedFood].foodCode foodType:KFoodDataMaterialType];
}

- (CGFloat)calculateStepDescSizeWithModel:(LJBCookStep *)stepModel {
    
    CGSize size = [stepModel.desc boundingRectWithSize:CGSizeMake(KScreenSize.width - 160, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return size.height;
}

- (void)calculateTipsSize {
    
    CGSize size = [self.materialModel.tips boundingRectWithSize:CGSizeMake(KScreenSize.width - 15*6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    self.materialModel.tipsHeight = size.height;
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.materialModel.steps.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 小贴士cell
        
        LJBCookTipsCell * cell = [LJBCookTipsCell cellWithTableView:tableView];
        
        cell.tipsText = self.materialModel.tips;
        
        return cell;
        
    } else {
        
        // 做法列表cell
        LJBCookStepCell * cell = [LJBCookStepCell cellWithTableView:tableView];
        
        cell.stepModel = self.materialModel.steps[indexPath.row];
        
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        // 材料组名
        LJBAppraiseSectionView * sectionView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
        [sectionView configTitleWithTitles:@[@"详细做法", @"", @""]];
        return sectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.materialModel.tipsHeight + 15*5;
    } else {
        LJBCookStep * stepModel = self.materialModel.steps[indexPath.row];
        
        return stepModel.descHeight > 80 ? stepModel.descHeight+20 : 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else {
        return 0;
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end

//
//  LJBMaterialViewController.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  材料视图

#import "LJBMaterialViewController.h"
#import "LJBFoodMaterialImageCell.h"
#import "LJBFoodNetworker.h"
#import "LJBFoodMaterial.h"
#import "LJBAppraiseSectionView.h"
#import "LJBMaterialCondiment.h"

@interface LJBMaterialViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  食物图片
 */
@property (nonatomic, strong) UIImageView * foodImage;

/**
 *  食物原料TableView
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 *  食物原料做法模型
 */
@property (nonatomic, strong) LJBFoodMaterial * materialModel;

@end

@implementation LJBMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self getDataFromServer];
}

#pragma mark - 适配子控件
- (void)addSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 20, 0));
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [LJBFoodNetworker getFoodDataFromServerWithSuccess:^(id model) {
        
        self.materialModel = model;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food material error:%@", error);
        
    } withFoodCode:[LJBFoodSingleTon sharedFood].foodCode foodType:KFoodDataMaterialType];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.materialModel.condiments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 食物图片cell
        LJBFoodMaterialImageCell * cell = [LJBFoodMaterialImageCell cellWithTableView:tableView];
        
        cell.imageUrl = self.materialModel.image_url;
        
        return cell;
        
    } else {
    
        // 材料列表cell
        static NSString * ID = @"food_material_cell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        LJBMaterialCondiment * condimentModel = self.materialModel.condiments[indexPath.row];
        
        cell.textLabel.text = condimentModel.name;
        cell.detailTextLabel.text = condimentModel.amount;
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        // 材料组名
        LJBAppraiseSectionView * sectionView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
        [sectionView configTitleWithTitles:@[@"原料列表", @"", @""]];
        return sectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return KScreenSize.height/3;
    } else {
        return 44;
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
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end

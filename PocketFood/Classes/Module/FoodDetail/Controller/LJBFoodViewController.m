//
//  LJBFoodViewController.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodViewController.h"
#import "LJBFoodMaterialCookMethodViewController.h"
#import "LJBIngredientInfoViewController.h"

#import "LJBFood.h"
#import "LJBFoodCompare.h"
#import "LJBFoodNetworker.h"
#import "LJBMoreSectionView.h"
#import "LJBAppraiseSectionView.h"
#import "LJBFoodNameCell.h"
#import "LJBFoodAppraiseCell.h"
#import "LJBFoodCaloryCell.h"
#import "LJBFoodIngredientCell.h"
#import "LJBFoodCompareCell.h"

#define FoodName_Cell_Height 60
#define Min_AppraiseHeight 80

#define SectionFooter_Height 40

@interface LJBFoodViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  收藏按钮
 */
@property (nonatomic, strong) UIButton * favoriteBtn;

/**
 *  食物详情表格视图
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 *  食物模型
 */
@property (nonatomic, strong) LJBFood * foodModel;

/**
 *  营养元素数组
 */
@property (nonatomic, strong) NSArray * ingredients;

@end

@implementation LJBFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self getFoodDataFromServer];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[LJBDBTool sharedDatabase] isExistsFood:[LJBFoodSingleTon sharedFood].foodCode]) {
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucangle"] forState:UIControlStateNormal];
    }
}

#pragma mark - 配置导航栏
- (void)setupNavigationBar {
    [super setupNavigationBar];
    
    // 解决右导航栏靠左的问题
    UIBarButtonItem * spaceRightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceRightItem.width = -20;
    
    // 右边收藏按钮
    _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucangle"] forState:UIControlStateSelected];
    _favoriteBtn.frame = CGRectMake(0, 0, 50, 55);
    [_favoriteBtn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithCustomView:_favoriteBtn];
    self.navigationItem.rightBarButtonItems = @[spaceRightItem, rightBtn];
}

#pragma mark - 返回按钮
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 收藏按钮
- (void)favoriteAction {
    
    if ([[LJBDBTool sharedDatabase] isExistsFood:[LJBFoodSingleTon sharedFood].foodCode]) {
        [[LJBDBTool sharedDatabase] removeFood:self.foodModel];
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    } else {
        [[LJBDBTool sharedDatabase] saveFood:self.foodModel];
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucangle"] forState:UIControlStateNormal];
    }
}

- (void)setupTableView {
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 获取食物数据
- (void)getFoodDataFromServer {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    [LJBFoodNetworker getFoodDataFromServerWithSuccess:^(id model) {
        
        self.foodModel = model;
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self calculateAppraiseHeight];
        
            [self.tableView reloadData];
            
            self.title = self.foodModel.name;
            
            [MMProgressHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food error:%@", error);
        
    } withFoodCode:[LJBFoodSingleTon sharedFood].foodCode foodType:KFoodDataDetailType];
    
}

#pragma mark - 计算食物评价高度
- (void)calculateAppraiseHeight {
#warning 宽度！
    CGSize size = [self.foodModel.appraise boundingRectWithSize:CGSizeMake(KScreenSize.width-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    if (size.height < Min_AppraiseHeight) {
        self.foodModel.appraiseHeight = Min_AppraiseHeight;
    } else {
    
        self.foodModel.appraiseHeight = size.height;
    }
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.foodModel.units.count) {
        
        // 存在“所含热量”组时，返回4组
        return 4;
    } else {
        
        // 不存在“所含热量”
        return 3;
    }
//    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        
        // 食物名称或评价
        return 1;
    } else if (self.foodModel.units.count && section == 2) {
        
        if (self.foodModel.compare.target_name.length) {
            
            // 存在食物对比
            return self.foodModel.units.count + 1;
            
        } else {
            // 所含热量
            return self.foodModel.units.count;
        }
    } else {
        
        // 营养元素
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        // 食物名称cell
        
        LJBFoodNameCell * cell = [LJBFoodNameCell cellWithTableView:tableView];
        
        cell.model = self.foodModel;
        
        return cell;
        
    } else if (indexPath.section == 1) {
        // 食物评价cell
        
        LJBFoodAppraiseCell * cell = [LJBFoodAppraiseCell cellWithTableView:tableView];
        
        cell.model = self.foodModel;
        
        // 食物原料与做法回调方法
        cell.FoodMaterialAction = ^{
            [self presentToMaterialViewControllerWithModel:self.foodModel];
        };
        
        return cell;
        
        
    } else if (indexPath.section == 2 && self.foodModel.units.count) {
        
        
        if (self.foodModel.compare.target_name.length) {
            
            if (indexPath.row == 0) {
                
                // 食物对比
                
                LJBFoodCompareCell * cell = [LJBFoodCompareCell cellWithTableView:tableView];
                
                cell.model = self.foodModel;
                
                return cell;
            } else {
                
                LJBFoodCaloryCell * cell = [LJBFoodCaloryCell cellWithTableView:tableView];
                
                cell.model = self.foodModel.units[indexPath.row-1];
                
                return cell;
            }
            
        } else {
            // 食物热量cell
            
            LJBFoodCaloryCell * cell = [LJBFoodCaloryCell cellWithTableView:tableView];
            
            cell.model = self.foodModel.units[indexPath.row];
            
            return cell;
        }
        
    } else {
        // 食物营养cell
        
        NSString * ingredientName = self.ingredients[indexPath.row];
        
        LJBFoodIngredientCell * cell = [LJBFoodIngredientCell cellWithTableView:tableView];
        
        [cell configCellWithFood:self.foodModel ingredient:ingredientName];
        
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        // 食物评价section
        
        LJBAppraiseSectionView * sectionView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
        
        sectionView.sectionType = KFoodSectionAppraiseType;
        
        return sectionView;
        
    } else if (section == 1 && self.foodModel.units.count) {
        // 食物热量section
        
        LJBAppraiseSectionView * sectionView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
        
        sectionView.sectionType = KFoodSectionCaloryType;
        
        return sectionView;
        
    } else if (section == 1 || (self.foodModel.units.count && section == 2)) {
        
        // 食物营养元素section
        LJBAppraiseSectionView * sectionView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
        
        sectionView.sectionType = KFoodSectionIngredientType;
        
        return sectionView;
        
    } else {
        
        // 查看更多营养信息section
        LJBMoreSectionView * sectionView = [LJBMoreSectionView sectionViewWithTableView: tableView];
        
        // 查看更多营养信息回调
        sectionView.ShowMoreIngredientInfoAction = ^{
            [self presentToIngredientInfoViewControllerWithModel:self.foodModel];
        };
        
        return sectionView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
#warning 屏蔽做法
    CGFloat height = 20;
    if ([self.foodModel.recipe intValue]) {
        // 存在做法
        height = 20 + 44;
    } else {
        height = 20;
    }
    
    if (indexPath.section == 0) {
        
        // 食物名称cell
        return FoodName_Cell_Height;
        
    } else if (indexPath.section == 1 && self.foodModel) {
        
        // 食物评价cell
        return self.foodModel.appraiseHeight + height;
        
    } else if (indexPath.section == 2 && indexPath.row == 0 && self.foodModel.compare.target_name.length) {
        
        // 食物对比cell
        return FoodName_Cell_Height + 10;
        
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SectionFooter_Height;
}

#pragma mark - private method
#pragma mark 食物原料回调方法
- (void)presentToMaterialViewControllerWithModel:(LJBFood *)foodModel {
    
    LJBFoodMaterialCookMethodViewController * materialVC = [[LJBFoodMaterialCookMethodViewController alloc] init];
    
    [self.navigationController pushViewController:materialVC animated:YES];
}

#pragma mark 查看更多营养信息回调方法
- (void)presentToIngredientInfoViewControllerWithModel:(LJBFood *)foodModel {
    
    LJBIngredientInfoViewController * ingredientVC = [[LJBIngredientInfoViewController alloc] init];
    ingredientVC.foodModel = foodModel;
    [self.navigationController pushViewController:ingredientVC animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)ingredients {
    
    if (!_ingredients) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"IngredientArray.plist" ofType:nil];
        _ingredients = [NSArray arrayWithContentsOfFile:path];
    }
    return _ingredients;
}

@end

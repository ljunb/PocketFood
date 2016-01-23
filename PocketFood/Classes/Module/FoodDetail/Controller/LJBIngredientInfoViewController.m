//
//  LJBIngredientInfoViewController.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  食物营养元素信息

#import "LJBIngredientInfoViewController.h"
#import "LJBFood.h"
#import "LJBAppraiseSectionView.h"
#import "LJBFoodIngredientCell.h"

@interface LJBIngredientInfoViewController () <UITableViewDataSource, UITableViewDelegate>
/**
 *  营养元素数组
 */
@property (nonatomic, strong) NSArray * ingredients;

/**
 *  表格视图
 */
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation LJBIngredientInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

#pragma mark - 设置导航栏按钮
- (void)setupNavigationBar {
    [super setupNavigationBar];
    
    self.title = @"营养信息";
}

#pragma mark - 添加TableView
- (void)setupTableView {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ingredients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBFoodIngredientCell * cell = [LJBFoodIngredientCell cellWithTableView:tableView];
    
    [cell configCellWithFood:self.foodModel ingredient:self.ingredients[indexPath.row]];
    
    return cell;
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

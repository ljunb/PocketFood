//
//  LJBFoodCategotySeasonController.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodCategotySeasonController.h"
#import "LJBFoodNetworker.h"
#import "UIImageView+WebCache.h"
#import "LJBFoodGroupCategory.h"
#import "LJBFoodSeasonCell.h"
#import "LJBFoodsDetailController.h"

@interface LJBFoodCategotySeasonController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * seasons;

@end

@implementation LJBFoodCategotySeasonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataFromServer];
}

#pragma mark - 返回按钮
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [LJBFoodNetworker getFoodCategoryDataFromServerWithSuccess:^(NSArray *categories) {
        
        if (self.seasons.count) {
            [self.seasons removeAllObjects];
        }
        
        [self.seasons addObjectsFromArray:categories];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food category season error:%@", error);
        
    } withParams:@{@"kind":self.category}];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seasons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBFoodGroupCategory * model = self.seasons[indexPath.row];
    
    LJBFoodSeasonCell * cell = [LJBFoodSeasonCell cellWithTableView:tableView];
    
    cell.categoryModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBFoodGroupCategory * model = self.seasons[indexPath.row];
    
    LJBFoodsDetailController * foodsVC = [[LJBFoodsDetailController alloc] init];
    
    foodsVC.title = model.name;
    foodsVC.model = model;
    foodsVC.kind = self.category;
    
    [self.navigationController pushViewController:foodsVC animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)seasons {
    
    if (!_seasons) {
        _seasons = [NSMutableArray array];
    }
    return _seasons;
}

@end

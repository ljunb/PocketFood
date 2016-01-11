//
//  LJBFavoriteViewController.m
//  PocketFood
//
//  Created by qf on 15/11/24.
//  Copyright © 2015年 qf. All rights reserved.
//  收藏视图

#import "LJBFavoriteViewController.h"
#import "LJBFoodsCell.h"
#import "LJBFood.h"
#import "LJBFoodSubViewController.h"

@interface LJBFavoriteViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  收藏TableView
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 *  收藏数组
 */
@property (nonatomic, strong) NSMutableArray * favorites;

@end

@implementation LJBFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.favorites.count) {
        [self.favorites removeAllObjects];
    }
    
    [self.favorites addObjectsFromArray:[[LJBDBTool sharedDatabase] getAllFoods]];
    [self.tableView reloadData];
}

- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBFood * foodModel = self.favorites[indexPath.row];
    
    LJBFoodsCell * cell = [LJBFoodsCell cellWithTableView:tableView];
    
    [cell configCellWithModel:foodModel orderBy:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBFood * foodModel = self.favorites[indexPath.row];
    
    [LJBFoodSingleTon sharedFood].foodCode = foodModel.code;
    
    LJBFoodSubViewController * foodVC = [[LJBFoodSubViewController alloc] init];
    
    [self.navigationController pushViewController:foodVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        
        LJBFood * food = self.favorites[indexPath.row];
        
        if ([[LJBDBTool sharedDatabase] removeFood:food]) {
            
            [self.favorites removeObject:food];
            
            [self.tableView reloadData];
        }
    }
}


#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 60;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)favorites {
    
    if (!_favorites) {
        _favorites = [NSMutableArray array];
    }
    return _favorites;
}

@end

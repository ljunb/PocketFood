//
//  LJBSearchViewController.m
//  PocketFood
//
//  Created by qf on 15/11/23.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBSearchViewController.h"
#import "LJBKeywordCell.h"
#import "LJBMainNetworker.h"
#import "LJBAppraiseSectionView.h"
#import "LJBFoodsCell.h"
#import "LJBFoodNetworker.h"
#import "LJBFood.h"
#import "LJBFoodSubViewController.h"
#import "LJBClearHistoryCell.h"

@interface LJBSearchViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

/**
 *  搜索输入框
 */
@property (nonatomic, strong) UITextField * searchField;

/**
 *  搜索按钮
 */
@property (nonatomic, strong) UIButton * searchBtn;

/**
 *  搜索历史
 */
@property (nonatomic, strong) NSMutableArray * history;

/**
 *  大家都在搜
 */
@property (nonatomic, strong) NSMutableArray * keywords;

/**
 *  显示搜索的TableView
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 *  搜索结果TableView
 */
@property (nonatomic, strong) UITableView * resultTableView;

/**
 *  搜索结果数组
 */
@property (nonatomic, strong) NSMutableArray * results;

/**
 *  搜索页数
 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation LJBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self getDataFromServer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.history.count) {
        [self.history removeAllObjects];
    }
    
    [self.history addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"history"]];
    
}

#pragma mark - 重写父类方法
- (void)backAction {
    [self.searchField resignFirstResponder];
    
    if (self.tableView.hidden) {
        
        self.searchField.text = nil;
        
        self.resultTableView.hidden = YES;
        
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 配置导航栏
- (void)setupNavigationBar {
    [super setupNavigationBar];
    
    // 搜索框
    self.searchField.frame = CGRectMake(0, 0, KScreenSize.width-40, 35);
    self.navigationItem.titleView = self.searchField;
    
    UIBarButtonItem * spaceRightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceRightItem.width = -20;

    // 搜索按钮
    [self.searchBtn setImage:[[UIImage imageNamed:@"ic_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.searchBtn.frame = CGRectMake(0, 0, 50, 44);
    [self.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    
    self.navigationItem.rightBarButtonItems = @[spaceRightItem, rightBtn];
    
}

#pragma mark - 适配TableViews
- (void)setupTableView {
    
    // 搜索历史+大家都在搜
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 搜索结果
    [self.resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.resultTableView.hidden = YES;
    
    // 加载更多
    self.resultTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        _currentPage++;
        
        [self searchActionWithKeyword:self.searchField.text];
    }];
    
    // 初始页码
    _currentPage = 1;
}


#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [LJBMainNetworker getKeywordsDataFromServerWithSuccess:^(NSArray *keywords) {
        
        if (self.keywords.count) {
            [self.keywords removeAllObjects];
        }
        
        [self.keywords addObjectsFromArray:keywords];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food keywords error:%@", error);
    }];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        
        if (self.history.count && section == 0) {
            return self.history.count+1;
        } else {
            return 1;
        }
    } else {
        return self.results.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        
        
    
        if (indexPath.section == 1) {
            LJBKeywordCell * cell = [LJBKeywordCell cellWithTableView:tableView];
            
            [cell configCellWithKeywords:self.keywords];
            
            // 关键词点击回调
            cell.KeywordClickAction = ^(NSString * keyword) {
                [self searchActionWithKeyword:keyword];
            };
            
            return cell;
        } else {
            
            if (indexPath.row == self.history.count) {
                
                LJBClearHistoryCell * cell = [LJBClearHistoryCell cellWithTableView:tableView];
                
                cell.ClearHistoryAction = ^{
                    
                    [self.history removeAllObjects];
                    
                    [self.tableView reloadData];
                    
                    [self storeKeywords];
                };
                
                return cell;
                
            } else {
                
                static NSString * ID = @"history_cell";
                
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
                
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageView.image = [UIImage imageNamed:@"ic_search_history"];
                cell.textLabel.text = self.history[indexPath.row];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                
                return cell;
            }
        }
    } else {
        
        LJBFoodsCell * cell = [LJBFoodsCell cellWithTableView:tableView];
        
        LJBFood * model = self.results[indexPath.row];
        
        [cell configCellWithModel:model orderBy:1];
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LJBAppraiseSectionView * headerView = [LJBAppraiseSectionView sectionViewWithTableView:tableView];
    
    if (section == 0) {
        [headerView configTitleWithTitles:@[@"最近搜索", @"", @""]];
    } else {
        [headerView configTitleWithTitles:@[@"大家都在搜", @"", @""]];
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        
        if (!self.history.count && section == 0) {
            return 0;
        } else {
            return 40;
        }

    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        if (indexPath.section == 1) {
            // 大家都在搜cell高度
            return 150;
        } else {
            
            if (self.history.count) {
                
                return 44;
                
            } else {
            
                return 0;
            }
        }
    } else {
        // 结果cell行高
        return 60;
    }
}

#pragma mark cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.resultTableView) {
        // 选中搜索结果
        
        LJBFood * model = self.results[indexPath.row];
        
        [[LJBFoodSingleTon sharedFood] setFoodCode:model.code];
        
        LJBFoodSubViewController * foodVC = [[LJBFoodSubViewController alloc] init];
        
        [self.navigationController pushViewController:foodVC animated:YES];
        
    } else {
        
        if (indexPath.section == 0 && indexPath.row != self.history.count) {
            // 选中历史记录
            
            [self searchActionWithKeyword:self.history[indexPath.row]];
        }
    }
}

#pragma mark - 点击搜索按钮方法
- (void)searchBtnAction {
    
    NSString * searchStr = [self.searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    if (searchStr.length) {
        
        [self searchActionWithKeyword:searchStr];
        
    } else {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"输入不能为空哦!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * hideAction = [UIAlertAction actionWithTitle:@"现在输入!" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:hideAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - 点击关键词搜索方法
- (void)searchActionWithKeyword:(NSString *)keyword {
    
    if (![self.searchField.text isEqualToString:keyword]) {
        _currentPage = 1;
    }
    
    self.searchField.text = keyword;
    
    [self.searchField resignFirstResponder];
    
    [self searchFoodDataFromServerWithKeyword:keyword];
    
    if (![self.history containsObject:keyword]) {
        
        NSString * searchStr = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        [self.history addObject:searchStr];
        
        [self storeKeywords];
    }
}

- (void)storeKeywords {
    [[NSUserDefaults standardUserDefaults] setObject:self.history forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 请求搜索的数据
- (void)searchFoodDataFromServerWithKeyword:(NSString *)keyword {
    
    NSString * page = [NSString stringWithFormat:@"%ld", _currentPage];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    [LJBFoodNetworker searchFoodsDataFromServerWithSuccess:^(NSArray *foods) {
        
        if (_currentPage == 1) {
            [self.results removeAllObjects];
        }
        
        [self.results addObjectsFromArray:foods];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.resultTableView reloadData];
            self.resultTableView.hidden = NO;
            
            if (_currentPage == 1) {
                [self.resultTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
            self.tableView.hidden = YES;
            
            [MMProgressHUD dismiss];
            [self.resultTableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Search food error:%@", error);
        [self.resultTableView.mj_footer endRefreshing];
        
    } withParams:@{@"q" : keyword, @"page" : page}];
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (self.tableView.hidden) {
        [self.searchField resignFirstResponder];
        
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        
        self.resultTableView.hidden = YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self searchBtnAction];
    
    return YES;
}

- (void)headerAction {
    [self.searchField resignFirstResponder];
}

#pragma mark - getter
- (UITextField *)searchField {
    
    if (!_searchField) {
        _searchField = [[UITextField alloc] init];
        _searchField.borderStyle = UITextBorderStyleRoundedRect;
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.delegate = self;
        _searchField.placeholder = @"请输入食物名称";
    }
    return _searchField;
}

- (UIButton *)searchBtn {
    
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
    }
    return _searchBtn;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableView *)resultTableView {
    
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc] init];
        _resultTableView.dataSource = self;
        _resultTableView.delegate = self;
        _resultTableView.bounces = NO;
        _resultTableView.showsVerticalScrollIndicator = NO;
        _resultTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_resultTableView];
    }
    return _resultTableView;
}

- (NSMutableArray *)keywords {
    
    if (!_keywords) {
        _keywords = [NSMutableArray array];
    }
    return _keywords;
}

- (NSMutableArray *)history {
    
    if (!_history) {
        _history = [NSMutableArray array];
    }
    return _history;
}

- (NSMutableArray *)results {
    
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}

@end

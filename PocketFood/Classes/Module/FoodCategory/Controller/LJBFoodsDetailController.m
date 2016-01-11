//
//  LJBFoodsDetailController.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodsDetailController.h"
#import "LJBFoodGroupCategory.h"
#import "LJBFoodNetworker.h"
#import "LJBFood.h"
#import "LJBFoodsCell.h"
#import "LJBFoodsSliderView.h"
#import "LJBFoodSubViewController.h"

#define TableView_Count 4

@interface LJBFoodsDetailController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

/**
 *  装载TableView的滚动视图
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 *  排序的TableView数组
 */
@property (nonatomic, strong) NSMutableArray * tableViews;

/**
 *  TableView对应的数据源数组
 */
@property (nonatomic, strong) NSMutableArray * dataSources;

/**
 *  TableView对应的请求参数数组
 */
@property (nonatomic, strong) NSMutableArray * params;

/**
 *  滑块视图
 */
@property (nonatomic, strong) LJBFoodsSliderView * sliderView;

@property (nonatomic, strong) UIButton * sortButton;

@end

@implementation LJBFoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSliderView];
    
    [self setupTableViews];
    
    [self getDataFromServer];
    
    
}

#pragma mark - 添加滑块视图
- (void)setupSliderView {
    
    _sliderView = [[LJBFoodsSliderView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width*2/3+20, 40) titles:@[@"常见", @"热量↑", @"蛋白质↓", @"脂肪↑"] selectAtIndex:^(NSInteger index) {
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * index, 0)];
        }];
    }];
    
    [self.view addSubview:_sliderView];
}


#pragma mark - 加载所有排序视图
- (void)setupTableViews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    
    for (NSInteger i = 0; i < TableView_Count; i++) {
        
        // 添加TableView
        UITableView * tableView = [[UITableView alloc] init];
        tableView.frame = CGRectMake(KScreenSize.width * i, 0, KScreenSize.width, KScreenSize.height-40-64);
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // 头部刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            // 取出对应tableview的页数
            NSDictionary * dict = self.params[i];
            NSInteger page = [dict[@"page"] integerValue];
            
            // 修改页数
            page = 1;
            
            // 覆盖原参数字典，并重新请求数据
            [self getDataFromServerWithPage:page paramsIndex:i];
            
        }];
        
        // 加载更多
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            // 取出对应tableview的页数
            NSDictionary * dict = self.params[i];
            NSInteger page = [dict[@"page"] integerValue];
    
            // 修改页数
            page++;
            
            // 覆盖原参数字典，并重新请求数据
            [self getDataFromServerWithPage:page paramsIndex:i];
        }];
        
        [self.scrollView addSubview:tableView];
        
        // 添加到数组
        [self.tableViews addObject:tableView];
    }
    
    self.scrollView.contentSize = CGSizeMake(KScreenSize.width * TableView_Count, 0);
}

#pragma mark 更新参数数组页数，重新请求数据
- (void)getDataFromServerWithPage:(NSInteger)page paramsIndex:(NSInteger)index {
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:self.params[index]];
    [mutableDic setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    
    [self.params replaceObjectAtIndex:index withObject:mutableDic];
    
    // 请求对应的数据
    [self getDataFromServerWithParams:self.params[index] dataSourceIndex:index];
    
}

#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    // 依次请求排序数据
    for (NSInteger i = 0; i < TableView_Count; i++) {
        
        NSString * kind = self.kind;
        NSString * value = self.model.ID;
        NSString * order_by = [NSString stringWithFormat:@"%d", i+1];
        NSString * page = @"1";
        NSString * order_asc = [NSString stringWithFormat:@"%d", i % 2];
        
        NSDictionary * param = @{@"kind":kind, @"value":value, @"order_by":order_by, @"page":page, @"order_asc":order_asc};
        
        // 添加到参数数组
        [self.params addObject:param];
        
        [self getDataFromServerWithParams:param dataSourceIndex:i];
    }
}

#pragma mark - 请求数据
- (void)getDataFromServerWithParams:(NSDictionary *)params dataSourceIndex:(NSInteger)index {
    
    [LJBFoodNetworker getFoodsDataFromServerWithSuccess:^(NSArray *foods) {
        
        // 当前页为第一页，移除旧数据
        if ([params[@"page"] integerValue] == 1) {
            [self.dataSources[index] removeAllObjects];
        }
        
        // 添加至数据源
        [self.dataSources[index] addObjectsFromArray:foods];
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableViews[index] reloadData];
            
            [[self.tableViews[index] valueForKey:@"mj_header"] endRefreshing];
            [[self.tableViews[index] valueForKey:@"mj_footer"] endRefreshing];
            
            [MMProgressHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Foods error:%@", error);
        
        [[self.tableViews[index] valueForKey:@"mj_header"] endRefreshing];
        [[self.tableViews[index] valueForKey:@"mj_footer"] endRefreshing];
        
    } withParams:params];
    
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 取得对应TableView的下标
    NSInteger index = [self.tableViews indexOfObject:tableView];
    
    return [self.dataSources[index] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = [self.tableViews indexOfObject:tableView];
    
    LJBFood * model = [self.dataSources[index] objectAtIndex:indexPath.row];
    
    LJBFoodsCell * cell = [LJBFoodsCell cellWithTableView:tableView];
    
    NSString * orderStr = [self.params[index] valueForKey:@"order_by"];
    
    [cell configCellWithModel:model orderBy:[orderStr integerValue]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = [self.tableViews indexOfObject:tableView];
    
    LJBFood * model = [self.dataSources[index] objectAtIndex:indexPath.row];
    
    [[LJBFoodSingleTon sharedFood] setFoodCode:model.code];
    
    LJBFoodSubViewController * foodVC = [[LJBFoodSubViewController alloc] init];
    
    [self.navigationController pushViewController:foodVC animated:YES];
}

#pragma mark - ScrollView delegate
#pragma mark 滑块联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        
        [self.sliderView setContentOffset:scrollView.contentOffset.x * (KScreenSize.width*2/3+20)/4 / KScreenSize.width];
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)dataSources {
    
    if (!_dataSources) {
        
        _dataSources = [NSMutableArray array];
        
        // 添加4个数组，对应每个TableView的数据源
        for (NSInteger i = 0; i < TableView_Count; i++) {
            NSMutableArray * array = [NSMutableArray array];
            [_dataSources addObject:array];
        }
    }
    return _dataSources;
}

- (NSMutableArray *)tableViews {
    
    if (!_tableViews) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}


- (NSMutableArray *)params {
    
    if (!_params) {
        _params = [NSMutableArray array];
    }
    return _params;
}

@end

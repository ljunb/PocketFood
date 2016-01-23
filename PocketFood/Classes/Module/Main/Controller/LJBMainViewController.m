//
//  LJBMainViewController.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//  主界面

#import "LJBMainViewController.h"
#import "AppDelegate.h"

#import "LJBSliderMenuViewController.h"
#import "LJBMainBannerCell.h"
#import "LJBMainBannerBottomCell.h"
#import "LJBMainTopicCell.h"
#import "LJBTopicHeaderView.h"

#import "LJBMainTopic.h"
#import "LJBMainFood.h"
#import "LJBMainNetworker.h"

#import "LJBTopicViewController.h"
#import "LJBFoodViewController.h"
#import "LJBMoreTopicController.h"
#import "IIViewDeckController.h"
#import "LJBSearchViewController.h"


#define BannerImage_Count 5
#define Topic_Count 13


@interface LJBMainViewController () <UITableViewDataSource, UITableViewDelegate, IIViewDeckControllerDelegate>

/**
 *  左上角菜单按钮
 */
@property (nonatomic, strong) UIButton * menuButton;
/**
 *  搜索按钮
 */
@property (nonatomic, strong) UIButton * searchButton;
/**
 *  主界面表格
 */
@property (nonatomic, strong) UITableView * tableView;
/**
 *  广告栏图片数组
 */
@property (nonatomic, strong) NSMutableArray * bannerImages;
/**
 *  广告栏下面的图片数组
 */
@property (nonatomic, strong) NSMutableArray * bannerBottomImages;
/**
 *  首页专题模型数组
 */
@property (nonatomic, strong) NSMutableArray * mainTopics;
/**
 *  更多专题模型数组
 */
@property (nonatomic, strong) NSMutableArray * moreTopics;

@end

@implementation LJBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置侧滑菜单协议
    self.viewDeckController.delegate = self;
    
    [self setupStatusBar];
    
    // 添加表格视图
    [self fittingTableView];

    // 请求广告栏数据
    [self getBannerDataFromServer];
    
    // 请求专题数据
    [self getTopicDataFromServer];
}

#pragma mark - 设置状态栏
- (void)setupStatusBar {
    
    UIView * statusBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width, 20)];
    statusBgView.backgroundColor = KColor(234, 82, 90);
    [self.view addSubview:statusBgView];
}

#pragma mark - 适配子控件
- (void)fittingTableView {
    
    // 表格视图
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getBannerDataFromServer];
        [self getTopicDataFromServer];
    }];
    
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        [self getBannerDataFromServer];
//        [self getTopicDataFromServer];
//    }];
    
    // 菜单按钮
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_top).offset(10);
        make.left.equalTo(self.tableView.mas_left).offset(5);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    [self.menuButton setBackgroundImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
    [self.menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * searchBgView = [[UIView alloc] initWithFrame:CGRectMake(KScreenSize.width-40, 10, 35, 35)];
    searchBgView.layer.cornerRadius = 35/2;
    searchBgView.layer.masksToBounds = YES;
    searchBgView.backgroundColor = [UIColor blackColor];
    searchBgView.alpha = 0.3;
    [self.tableView addSubview:searchBgView];
    
    // 搜索按钮
    self.searchButton.frame = CGRectMake(KScreenSize.width-40, 10, 35, 35);
    [self.searchButton setImage:[[UIImage imageNamed:@"ic_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [self.searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 左侧菜单事件
- (void)menuAction {
    
    // 回调菜单滑出/隐藏方法
    if (self.OpenLeftMenuViewAction) {
        self.OpenLeftMenuViewAction(self.menuButton.selected);
    }
    
    self.menuButton.selected = !self.menuButton.selected;
}

#pragma mark 搜索按钮事件
- (void)searchAction {
    
    LJBSearchViewController * searchVC = [[LJBSearchViewController alloc] init];
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:searchVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - 请求广告栏数据
- (void)getBannerDataFromServer {
    
    [LJBMainNetworker getBannerDataFromServerWithSuccess:^(NSArray *models) {
        
        if (self.bannerImages.count) {
            [self.bannerImages removeAllObjects];
        }
        
        // 前5张用来轮播
        for (NSInteger i = 0; i < BannerImage_Count; i++) {
            [self.bannerImages addObject:models[i]];
        }
        
        if (self.bannerBottomImages.count) {
            [self.bannerBottomImages removeAllObjects];
        }
        
        // 后面的放置下方
        for (NSInteger i = BannerImage_Count; i < models.count; i++) {
            [self.bannerBottomImages addObject:models[i]];
        }
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Main banner error:%@", error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 请求专题数据
- (void)getTopicDataFromServer {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    [LJBMainNetworker getTopicDataFromServerWithSuccess:^(NSArray *models) {
        
        if (self.mainTopics.count) {
            [self.mainTopics removeAllObjects];
        }
        
        if (self.moreTopics.count) {
            [self.moreTopics removeAllObjects];
        }
        // 主页专题数组
        [self.mainTopics addObjectsFromArray:[models objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, Topic_Count)]]];
        // 更多专题数组
        [self.moreTopics addObjectsFromArray:[models objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(Topic_Count, models.count-Topic_Count)]]];
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            [MMProgressHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Main topic error:%@", error);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - UITableView dataSource
#pragma mark section number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } else {
        return self.mainTopics.count;
    }
}

#pragma mark tableView cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {   // 头部广告栏cell
            
            LJBMainBannerCell * cell = [LJBMainBannerCell cellWithTableView:tableView];
            
            if (self.bannerImages.count) {
                [cell configCellWithImages:self.bannerImages];
            }
            
            // 广告栏图片单击回调方法
            cell.ShowFoodDetailAction = ^(NSInteger index){
                [self presentToFoodViewControllerWithModel:self.bannerImages[index]];
            };
            
            return cell;
            
        } else {                    // 广告栏下面图片cell
            
            LJBMainBannerBottomCell * cell = [LJBMainBannerBottomCell cellWithTableView:tableView];
            
            if (self.bannerBottomImages.count) {
                [cell configCellWithImages:self.bannerBottomImages];
            }
            
            // 广告栏图片单击回调方法
            cell.ShowFoodDetailAction = ^(NSInteger index){
                [self presentToFoodViewControllerWithModel:self.bannerBottomImages[index]];
            };
            
            return cell;
        }
        
    } else {                        // 专题cell
    
        LJBMainTopicCell * cell = [LJBMainTopicCell cellWithTableView:tableView];
        
        LJBMainTopic * model = self.mainTopics[indexPath.row];
        
        [cell configCellWithModel:model];
        
        return cell;
    }
    
    return nil;
}

#pragma mark section headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return nil;
    } else {
        LJBTopicHeaderView * headerView = [LJBTopicHeaderView sectionViewWithTableView:tableView];
        
        // 查看更多 回调方法
        headerView.ShowMoreTopicAction = ^{
            [self presentToMoreTopicViewController];
        };
        
        return headerView;
    }
}

#pragma mark section height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    } else {
        return 35;
    }
}

#pragma mark row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return KScreenSize.height / 3.0;
        } else {
            return KScreenSize.height / 3.0 / 2.0;
        }
        
    } else if (indexPath.section == 1){
        return 120;
    }
    return 0;
}

#pragma mark - 首页广告栏图片挑转方法
- (void)presentToFoodViewControllerWithModel:(LJBMainFood *)model {
    
    LJBFoodViewController * foodVC = [[LJBFoodViewController alloc] init];
    foodVC.title = model.food_name;
    
    [LJBFoodSingleTon sharedFood].foodCode = model.food_code;
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:foodVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - 查看更多跳转方法
- (void)presentToMoreTopicViewController {
    
    LJBMoreTopicController * moreVC = [[LJBMoreTopicController alloc] init];
    moreVC.moreTopics = self.moreTopics;
    moreVC.title = @"更多专题";
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:moreVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBMainTopic * model = self.mainTopics[indexPath.row];
    
    // 跳转至专题详情页
    LJBTopicViewController * topicVC = [[LJBTopicViewController alloc] init];
    
    topicVC.topic_id = model.topic_id;
    topicVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:topicVC animated:YES completion:nil];
}

#pragma mark - IIViewDeckControllerDelegate
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    // 显示左视图时
    self.menuButton.selected = YES;
    self.coverView.hidden = NO;
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    // 隐藏左视图
    self.menuButton.selected = NO;
    self.coverView.hidden = YES;
}

#pragma mark - getter
- (UIButton *)menuButton {
    
    if (!_menuButton) {
        _menuButton = [[UIButton alloc] init];
        [self.tableView addSubview:_menuButton];
    }
    return _menuButton;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)bannerImages {
    
    if (!_bannerImages) {
        _bannerImages = [NSMutableArray array];
    }
    return _bannerImages;
}

- (NSMutableArray *)bannerBottomImages {
    
    if (!_bannerBottomImages) {
        _bannerBottomImages = [NSMutableArray array];
    }
    return _bannerBottomImages;
}

- (NSMutableArray *)mainTopics {
    
    if (!_mainTopics) {
        _mainTopics = [NSMutableArray array];
    }
    return _mainTopics;
}

- (NSMutableArray *)moreTopics {
    
    if (!_moreTopics) {
        _moreTopics = [NSMutableArray array];
    }
    return _moreTopics;
}

- (UIButton *)searchButton {
    
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] init];
        _searchButton.tintColor = [UIColor whiteColor];
        [self.tableView addSubview:_searchButton];
    }
    return _searchButton;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.frame = CGRectMake(0, 0, 100, KScreenSize.height);
        [self.view addSubview:_coverView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

@end

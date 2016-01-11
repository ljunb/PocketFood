//
//  LJBFoodMaterialViewController.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  食物原料与做法

#import "LJBFoodMaterialCookMethodViewController.h"
#import "LJBMaterialViewController.h"
#import "LJBCookMethodViewController.h"
#import "LJBTitleSelectView.h"

@interface LJBFoodMaterialCookMethodViewController () <UIScrollViewDelegate>

/**
 *  装载VC的滚动视图
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 *  标题滑块
 */
@property (nonatomic, strong) LJBTitleSelectView * titleSelView;

@end

@implementation LJBFoodMaterialCookMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
}

#pragma mark - 添加子视图控制器
- (void)setupChildViewControllers {
    
    // 滑块视图
    _titleSelView = [[LJBTitleSelectView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width/3, 28) titles:@[@"原料", @"做法"] selectAtIndex:^(NSInteger index) {
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * index, 0)];
        }];
    }];

    self.navigationItem.titleView = _titleSelView;
    
    // 原料VC
    LJBMaterialViewController * materialVC = [[LJBMaterialViewController alloc] init];
    materialVC.view.frame = CGRectMake(0, 0, KScreenSize.width, KScreenSize.height);
    [self.scrollView addSubview:materialVC.view];
    [self addChildViewController:materialVC];

    // 做法VC
    LJBCookMethodViewController * cookMethodVC = [[LJBCookMethodViewController alloc] init];
    cookMethodVC.view.frame = CGRectMake(KScreenSize.width, 0, KScreenSize.width, KScreenSize.height);
    [self.scrollView addSubview:cookMethodVC.view];
    [self addChildViewController:cookMethodVC];
    
    // 可滚动大小
    self.scrollView.contentSize = CGSizeMake(KScreenSize.width*2, 0);
}

#pragma mark - ScrollView delegate
#pragma mark 滚动视图与滑块联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.titleSelView setContentOffset:scrollView.contentOffset.x * self.titleSelView.bounds.size.width/2 / KScreenSize.width];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

@end

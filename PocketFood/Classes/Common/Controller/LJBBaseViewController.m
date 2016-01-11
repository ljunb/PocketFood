//
//  LJBBaseViewController.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//  基类

#import "LJBBaseViewController.h"

@interface LJBBaseViewController ()

@end

@implementation LJBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

#pragma mark - 配置导航栏
- (void)setupNavigationBar {
    
    // 状态栏背景
    [[UINavigationBar appearance] setBarTintColor:KColor(234, 82, 90)];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 导航栏标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置导航栏按钮
    [self setupNavigationBarItem];
}

#pragma mark - 设置导航栏按钮
- (void)setupNavigationBarItem {
    
    // 解决左导航栏靠右的问题
    UIBarButtonItem * spaceLeftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceLeftItem.width = -20;
    
    // 左边返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ic_back_white"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50, 44);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItems = @[spaceLeftItem, leftBtn];

}

#pragma mark - 返回按钮事件
- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
 
}


@end
